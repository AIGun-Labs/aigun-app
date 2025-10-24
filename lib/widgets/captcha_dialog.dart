import 'dart:convert';
import 'dart:typed_data';
import "dart:ui" as ui;

import 'package:flutter/material.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaptchaDialog {
  static Future<String?> show(
    BuildContext context, {
    required String base64Image,
    required String thumbnailBase64Image,
    Widget? title,
    CaptchaMarkStyle markStyle = const CaptchaMarkStyle(),
  }) {
    return showDialog<String?>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return CaptchaDialogContent(
          base64Image: base64Image,
          thumbnailBase64Image: thumbnailBase64Image,
          title: title,
          markStyle: markStyle,
        );
      },
    );
  }
}

/// The internal stateful content of the dialog.
// class _CaptchaDialogContent extends StatefulWidget {
//   final String base64Image;
//   final String thumbnailBase64Image;
//   final Widget? title;
//   final CaptchaMarkStyle markStyle;

//   const _CaptchaDialogContent({
//     required this.base64Image,
//     required this.thumbnailBase64Image,
//     this.title,
//     required this.markStyle,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _CaptchaDialogContentState createState() => _CaptchaDialogContentState();
// }
class CaptchaDialogContent extends StatefulWidget {
  final String base64Image;
  final String thumbnailBase64Image;
  final Widget? title;
  final CaptchaMarkStyle markStyle;
  const CaptchaDialogContent({
    required this.base64Image,
    required this.thumbnailBase64Image,
    this.title,
    required this.markStyle,
    super.key,
  });
  @override
  State<CaptchaDialogContent> createState() => CaptchaDialogContentState();
}

class CaptchaDialogContentState extends State<CaptchaDialogContent> {
  // 存储最终要提交的坐标（基于图片原始尺寸，左下角原点）
  final List<Offset> _tapPoints = [];

  // -- 图片相关状态 --
  Uint8List? _imageBytes;
  Uint8List? _thumbnailBytes;
  String? _error;

  // -- 坐标计算的关键状态 --
  // 图片的原始（内在）尺寸
  Size? _intrinsicImageSize;
  // 图片在UI上实际渲染的区域 (位置和大小)
  Rect? _renderedImageRect;
  @override
  void initState() {
    super.initState();
    _decodeAndProcessImage();
  }

  /// 解码并获取图片原始尺寸
  Future<void> _decodeAndProcessImage() async {
    try {
      final imageString = widget.base64Image.split(',').last;
      final thumbnailString = widget.thumbnailBase64Image.split(',').last;

      _imageBytes = base64Decode(imageString);
      _thumbnailBytes = base64Decode(thumbnailString);
      // 使用 dart:ui 解码并获取图片原始尺寸，这是最精确的方法
      final codec = await ui.instantiateImageCodec(_imageBytes!);
      final frame = await codec.getNextFrame();

      // 更新状态，触发UI重新计算渲染区域
      if (mounted) {
        setState(() {
          _intrinsicImageSize = Size(
            frame.image.width.toDouble(),
            frame.image.height.toDouble(),
          );
          _error = null;
        });
      }
    } catch (e) {
      Logger.error("Base64 or Image Codec Error: $e");
      if (mounted) {
        setState(() {
          _error = "验证码加载失败";
        });
      }
    }
  }

  /// 核心逻辑：处理点击事件
  void _handleTap(TapUpDetails details) {
    if (_renderedImageRect == null || _intrinsicImageSize == null) return;

    // 1. 获取相对于SizedBox (300x220) 的点击位置
    final Offset tapInContainer = details.localPosition;
    // 2. 检查点击是否在实际渲染的图片区域内
    if (_renderedImageRect!.contains(tapInContainer)) {
      // 3. 计算点击位置相对于图片左上角的位置
      final Offset tapOnImage = tapInContainer - _renderedImageRect!.topLeft;
      // 4. 将坐标从 "UI渲染尺寸" 缩放到 "图片原始尺寸"
      final double scaleX =
          _intrinsicImageSize!.width / _renderedImageRect!.width;
      final double scaleY =
          _intrinsicImageSize!.height / _renderedImageRect!.height;
      final Offset scaledTap = Offset(
        tapOnImage.dx * scaleX,
        tapOnImage.dy * scaleY,
      );
      // 5. 将坐标原点从左上角转换为左下角
      final Offset finalPoint = Offset(
        scaledTap.dx,
        _intrinsicImageSize!.height - scaledTap.dy,
      );
      setState(() {
        _tapPoints.add(finalPoint);
      });
    }
  }

  /// 将存储的坐标（左下角原点，原始尺寸）转换回UI坐标（左上角原点，渲染尺寸）以便显示
  Offset _convertPointForDisplay(Offset savedPoint) {
    if (_renderedImageRect == null || _intrinsicImageSize == null) {
         return Offset.zero;
    }
   
    // 1. 将原点从左下角转回左上角
    final Offset topLeftPoint = Offset(
      savedPoint.dx,
      _intrinsicImageSize!.height - savedPoint.dy,
    );
    // 2. 将坐标从 "图片原始尺寸" 缩放回 "UI渲染尺寸"
    final double scaleX =
        _renderedImageRect!.width / _intrinsicImageSize!.width;
    final double scaleY =
        _renderedImageRect!.height / _intrinsicImageSize!.height;

    final Offset renderScalePoint = Offset(
      topLeftPoint.dx * scaleX,
      topLeftPoint.dy * scaleY,
    );

    // 3. 加上图片在容器中的偏移量，得到最终在UI上的位置
    return renderScalePoint + _renderedImageRect!.topLeft;
  }

  void _reset() {
    setState(() {
      _tapPoints.clear();
    });
  }

  void _verify() {
    if (_tapPoints.isEmpty) return;
    // 拼接成 "x,y,x,y,x,y" 格式，并四舍五入为整数
    final String dots =
        _tapPoints.map((p) => '${p.dx.round()},${p.dy.round()}').join(',');
    Navigator.of(context).pop(dots);
  }

  void _cancel() {
    Navigator.of(context).pop(null);
  }

  @override
  Widget build(BuildContext context) {
    // 每次 build 时都重新计算图片在容器内的实际位置和大小
    // 这是确定性的，只要图片原始尺寸和容器尺寸已知
    if (_intrinsicImageSize != null) {
      final containerSize = Size(300.w, 220.h);
      final FittedSizes fittedSizes = applyBoxFit(
        BoxFit.contain,
        _intrinsicImageSize!,
        containerSize,
      );
      final Size renderedSize = fittedSizes.destination;
      // 计算居中后的偏移量
      final double dx = (containerSize.width - renderedSize.width) / 2;
      final double dy = (containerSize.height - renderedSize.height) / 2;
      _renderedImageRect =
          Rect.fromLTWH(dx, dy, renderedSize.width, renderedSize.height);
    }
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 使用 Flexible 避免标题文本过长时溢出
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '请按顺序点击图片中的文字',
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                ),
                SizedBox(height: 10.h),
                if (_thumbnailBytes != null)
                  Image.memory(_thumbnailBytes!,
                      fit: BoxFit.contain, height: 40.h),
              ],
            ),
          ),
          IconButton(
            onPressed: _cancel,
            icon: const Icon(Icons.close),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
      content: SizedBox(
        width: 300.w, // 固定容器宽度
        height: 220.h, // 固定容器高度
        child: _buildCaptchaArea(),
      ),
      actionsPadding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 24.h),
      actions: <Widget>[
        Row(
          // 您原有的布局很好，这里保留
          children: [
            Flexible(
              child: CustomButton(
                onPressed: _reset,
                text: '重置',
                textColor: Colors.black,
                backgroundColor: Colors.white,
                borderSide: const BorderSide(color: Color(0xFFB2B2B2)),
                height: 50.h,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(width: 20.w),
            Flexible(
              child: CustomButton(
                onPressed: _tapPoints.isEmpty ? null : _verify,
                text: '验证',
                textColor: Colors.white,
                backgroundColor: Colors.black,
                height: 50.h,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCaptchaArea() {
    if (_error != null) {
      return Center(
          child: Text(_error!, style: const TextStyle(color: Colors.red)));
    }
    // 等待图片尺寸解析完成
    if (_imageBytes == null || _renderedImageRect == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return GestureDetector(
      onTapUp: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          // 使用 Positioned 精确控制图片的位置和大小
          Positioned.fromRect(
            rect: _renderedImageRect!,
            child: Image.memory(
              _imageBytes!,
              fit: BoxFit.fill, // 此时应使用 fill，因为大小已经计算好了
            ),
          ),
          // 绘制标记点
          ..._tapPoints.map((point) {
            final style = widget.markStyle;
            final displayPoint = _convertPointForDisplay(point);
            return Positioned(
              left: displayPoint.dx - style.radius,
              top: displayPoint.dy - style.radius,
              child: IgnorePointer(
                child: Container(
                  width: style.radius * 2,
                  height: style.radius * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: style.backgroundColor,
                    border: Border.all(
                        color: style.borderColor, width: style.borderWidth),
                  ),
                  child: Center(
                    child: Text(
                      '${_tapPoints.indexOf(point) + 1}',
                      style: TextStyle(
                        color: style.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: style.fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class CaptchaMarkStyle {
  final double radius;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final Color textColor;
  final double fontSize;

  const CaptchaMarkStyle({
    this.radius = 12.0,
    this.backgroundColor = const Color.fromRGBO(255, 0, 0, 0.5),
    this.borderColor = const Color.fromARGB(255, 255, 255, 255),
    this.borderWidth = 1.5,
    this.textColor = Colors.white,
    this.fontSize = 14.0,
  });
}
