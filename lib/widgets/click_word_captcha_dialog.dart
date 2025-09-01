import 'dart:convert';

import 'package:flutter/material.dart';

typedef VoidSuccessCallback = void Function(List<Offset> points);

class ClickWordCaptchaDialog extends StatefulWidget {
  final String base64Image;
  final List<String> wordList; // 要点击的文字
  final VoidSuccessCallback onSuccess;
  final VoidCallback onFail;

  const ClickWordCaptchaDialog({
    Key? key,
    required this.base64Image,
    required this.wordList,
    required this.onSuccess,
    required this.onFail,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context, {
    required String base64Image,
    required List<String> wordList,
    required VoidSuccessCallback onSuccess,
    required VoidCallback onFail,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: ClickWordCaptchaDialog(
          base64Image: base64Image,
          wordList: wordList,
          onSuccess: onSuccess,
          onFail: onFail,
        ),
      ),
    );
  }

  @override
  State<ClickWordCaptchaDialog> createState() => _ClickWordCaptchaDialogState();
}

class _ClickWordCaptchaDialogState extends State<ClickWordCaptchaDialog> {
  List<Offset> _tapOffsetList = [];
  String get _wordStr => widget.wordList.join(', ');

  void _onTapDown(TapDownDetails details) {
    if (_tapOffsetList.length < widget.wordList.length) {
      setState(() {
        _tapOffsetList.add(details.localPosition);
      });
      if (_tapOffsetList.length == widget.wordList.length) {
        // 校验逻辑由外部处理
        widget.onSuccess(_tapOffsetList);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageBytes = Base64Decoder().convert(widget.base64Image);

    return Container(
      width: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 顶部标题和关闭按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('请完成安全验证', style: TextStyle(fontSize: 18)),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // 图片和点击点
          GestureDetector(
            onTapDown: _onTapDown,
            child: Stack(
              children: [
                Image.memory(imageBytes),
                ..._tapOffsetList.asMap().entries.map((entry) {
                  int idx = entry.key;
                  Offset offset = entry.value;
                  return Positioned(
                    left: offset.dx - 10,
                    top: offset.dy - 10,
                    child: Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('${idx + 1}',
                          style: const TextStyle(color: Colors.white)),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // 底部提示
          Text(
            '请依次点击【$_wordStr】',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
