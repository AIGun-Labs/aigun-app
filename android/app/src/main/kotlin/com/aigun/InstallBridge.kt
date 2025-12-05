package com.aigun

import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.nio.file.Path

/**
 *  MethodChannel  MainActivity 。
 * Flutter  MethodChannel ：app.updater/install
 *
 * ：
 * - install(path: String): 
 * - canRequestPackageInstalls(): Boolean，Android 8.0+ 
 * - openSettings(): “”
 */
object InstallBridge {
    private const val CHANNEL = "app.updater/install"

    fun bind(engine: FlutterEngine, activity: Activity) {
        MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method){
                    "install" -> {
                        val path = call.argument<String>("path") ?: ""
                        try {
                            installApk(activity,path)
                            result.success("started")
                        } catch (e: BridgeException) {
                            result.error(e.code,e.message,null)
                        } catch (e: Exception){
                            result.error("internal_error",e.message,null)
                        }
                    }
                    "canRequestPackageInstalls" ->{
                        result.success(canInstallFromUnknownSources(activity))
                    }
                    "openSettings" -> {
                        openUnknownSourcesSettings(activity)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun canInstallFromUnknownSources(activity: Activity):Boolean {
        return  if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            activity.packageManager.canRequestPackageInstalls()
        } else true
    }

    @Throws(BridgeException::class)
    private fun installApk(activity: Activity,apkPath: String) {
        val file = File(apkPath)
        if(!file.exists()) {
            throw  BridgeException("file_not_found", "APK not found at: $apkPath")
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O && !canInstallFromUnknownSources(activity)) {
            throw  BridgeException("needs_permission", "MANAGE_UNKNOWN_APP_SOURCES required")
        }

        val uri: Uri = try {
            FileProvider.getUriForFile(
                activity,
                "${activity.applicationContext.packageName}.fileprovider",
                file
                )
        } catch (e: IllegalArgumentException) {
            throw BridgeException("security_error","FileProvider error: ${e.message}")
        }

        val intent = Intent(Intent.ACTION_VIEW).apply {
            setDataAndType(uri, "application/vnd.android.package-archive")
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        }

        try {
            if (intent.resolveActivity(activity.packageManager) != null) {
                activity.startActivity(intent)
            } else {
                throw BridgeException("no_handler", "NO activity can handle APK install")
            }
        } catch (e: SecurityException) {
            throw BridgeException("security_error",e.message ?: "Security exception")
        } catch (e: ActivityNotFoundException) {
            throw BridgeException("no_handler", e.message ?: "No handler")
        }
    }

    private fun openUnknownSourcesSettings(activity: Activity) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
           val intent = Intent(
               Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES,
               Uri.parse("package:${activity.packageName}")
           ).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            activity.startActivity(intent)
        } else {
            val intent = Intent(Settings.ACTION_SECURITY_SETTINGS)
                .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            activity.startActivity(intent)
        }
    }
}
/**  MethodChannel  */
class BridgeException(val code: String, override val message: String): Exception(message)
