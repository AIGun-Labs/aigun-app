// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
//  Generated file. Do not edit.
//

import PackageDescription

let package = Package(
    name: "FlutterGeneratedPluginSwiftPackage",
    platforms: [
        .macOS("10.15")
    ],
    products: [
        .library(name: "FlutterGeneratedPluginSwiftPackage", type: .static, targets: ["FlutterGeneratedPluginSwiftPackage"])
    ],
    dependencies: [
        .package(name: "webview_flutter_wkwebview", path: "../.packages/webview_flutter_wkwebview"),
        .package(name: "video_player_avfoundation", path: "../.packages/video_player_avfoundation"),
        .package(name: "url_launcher_macos", path: "../.packages/url_launcher_macos"),
        .package(name: "shared_preferences_foundation", path: "../.packages/shared_preferences_foundation"),
        .package(name: "share_plus", path: "../.packages/share_plus"),
        .package(name: "path_provider_foundation", path: "../.packages/path_provider_foundation"),
        .package(name: "sentry_flutter", path: "../.packages/sentry_flutter"),
        .package(name: "package_info_plus", path: "../.packages/package_info_plus"),
        .package(name: "flutter_timezone", path: "../.packages/flutter_timezone"),
        .package(name: "wakelock_plus", path: "../.packages/wakelock_plus"),
        .package(name: "device_info_plus", path: "../.packages/device_info_plus"),
        .package(name: "connectivity_plus", path: "../.packages/connectivity_plus"),
        .package(name: "sqflite_darwin", path: "../.packages/sqflite_darwin"),
        .package(name: "audioplayers_darwin", path: "../.packages/audioplayers_darwin"),
        .package(name: "app_settings", path: "../.packages/app_settings"),
        .package(name: "macos_ui", path: "../.packages/macos_ui"),
        .package(name: "macos_window_utils", path: "../.packages/macos_window_utils"),
        .package(name: "appkit_ui_element_colors", path: "../.packages/appkit_ui_element_colors"),
        .package(name: "dynamic_color", path: "../.packages/dynamic_color")
    ],
    targets: [
        .target(
            name: "FlutterGeneratedPluginSwiftPackage",
            dependencies: [
                .product(name: "webview-flutter-wkwebview", package: "webview_flutter_wkwebview"),
                .product(name: "video-player-avfoundation", package: "video_player_avfoundation"),
                .product(name: "url-launcher-macos", package: "url_launcher_macos"),
                .product(name: "shared-preferences-foundation", package: "shared_preferences_foundation"),
                .product(name: "share-plus", package: "share_plus"),
                .product(name: "path-provider-foundation", package: "path_provider_foundation"),
                .product(name: "sentry-flutter", package: "sentry_flutter"),
                .product(name: "package-info-plus", package: "package_info_plus"),
                .product(name: "flutter-timezone", package: "flutter_timezone"),
                .product(name: "wakelock-plus", package: "wakelock_plus"),
                .product(name: "device-info-plus", package: "device_info_plus"),
                .product(name: "connectivity-plus", package: "connectivity_plus"),
                .product(name: "sqflite-darwin", package: "sqflite_darwin"),
                .product(name: "audioplayers-darwin", package: "audioplayers_darwin"),
                .product(name: "app-settings", package: "app_settings"),
                .product(name: "macos-ui", package: "macos_ui"),
                .product(name: "macos-window-utils", package: "macos_window_utils"),
                .product(name: "appkit-ui-element-colors", package: "appkit_ui_element_colors"),
                .product(name: "dynamic-color", package: "dynamic_color")
            ]
        )
    ]
)
