import 'package:flutter/material.dart';
import 'avatar.dart';

/// DefaultAvatar 组件使用示例
class AvatarExamples extends StatelessWidget {
  const AvatarExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('头像组件示例')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('1. 默认头像（使用项目中的 default-avatar.png）',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Row(
              children: [
                DefaultAvatar(size: 48),
                SizedBox(width: 16),
                DefaultAvatar(size: 64),
                SizedBox(width: 16),
                DefaultAvatar(size: 80),
              ],
            ),
            const SizedBox(height: 24),
            const Text('2. 带占位符文字的头像',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Row(
              children: [
                DefaultAvatar(
                  size: 48,
                  placeholderText: '张',
                ),
                SizedBox(width: 16),
                DefaultAvatar(
                  size: 48,
                  placeholderText: '李四',
                ),
                SizedBox(width: 16),
                DefaultAvatar(
                  size: 48,
                  placeholderText: '王五六',
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('3. 网络头像',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Row(
              children: [
                DefaultAvatar(
                  size: 48,
                  avatarUrl: 'https://example.com/avatar1.jpg',
                  placeholderText: '网络头像',
                ),
                SizedBox(width: 16),
                DefaultAvatar(
                  size: 64,
                  avatarUrl: 'https://example.com/avatar2.jpg',
                  placeholderText: '头像',
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('4. 带边框的头像',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Row(
              children: [
                DefaultAvatar(
                  size: 48,
                  placeholderText: '边框',
                  showBorder: true,
                ),
                SizedBox(width: 16),
                DefaultAvatar(
                  size: 48,
                  placeholderText: '彩色边框',
                  showBorder: true,
                  borderColor: Colors.blue,
                  borderWidth: 2,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('5. 方形头像',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Row(
              children: [
                DefaultAvatar(
                  size: 48,
                  shape: BoxShape.rectangle,
                  placeholderText: '方形',
                ),
                SizedBox(width: 16),
                DefaultAvatar(
                  size: 48,
                  shape: BoxShape.rectangle,
                  showBorder: true,
                  borderColor: Colors.green,
                  placeholderText: '方形边框',
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('6. 自定义占位符',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DefaultAvatar(
              size: 64,
              customPlaceholder: Container(
                color: Colors.purple,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
