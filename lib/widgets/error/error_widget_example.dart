import 'package:flutter/material.dart';
import 'error_widget.dart';

// 使用示例
class ErrorWidgetExample extends StatelessWidget {
  const ErrorWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Widget Examples')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. 基础错误组件
          const GlobalErrorWidget(
            title: '出错了',
            message: '无法加载数据，请稍后重试',
            onRetry: null, // 替换为实际的重试函数
          ),

          const Divider(height: 40),

          // 2. 网络错误
          NetworkErrorWidget(
            onRetry: () {
              // 重试网络请求
              print('Retrying network request...');
            },
          ),

          const Divider(height: 40),

          // 3. 空数据
          EmptyDataWidget(
            title: '暂无订单',
            message: '您还没有任何订单记录',
            onRefresh: () {
              // 刷新数据
              print('Refreshing data...');
            },
          ),

          const Divider(height: 40),

          // 4. 加载失败
          LoadingErrorWidget(
            onRetry: () {
              print('Retrying loading...');
            },
            error: 'TimeoutException: Request timeout',
          ),

          const Divider(height: 40),

          // 5. 使用CustomErrorWidgetBuilder
          CustomErrorWidgetBuilder.build(
            context: context,
            type: CustomErrorType.network,
            customMessage: '服务器连接失败',
            onRetry: () {
              print('Custom retry action');
            },
          ),
        ],
      ),
    );
  }
}

// 在实际使用中的示例
class RealWorldExample extends StatefulWidget {
  const RealWorldExample({super.key});

  @override
  State<RealWorldExample> createState() => _RealWorldExampleState();
}

class _RealWorldExampleState extends State<RealWorldExample> {
  bool isLoading = false;
  bool hasError = false;
  List<String>? data;

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      // 模拟网络请求
      await Future.delayed(const Duration(seconds: 2));

      // 模拟成功获取数据
      setState(() {
        data = ['Item 1', 'Item 2', 'Item 3'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (hasError) {
      return NetworkErrorWidget(
        onRetry: loadData,
        message: '无法连接到服务器，请检查网络后重试',
      );
    }

    if (data == null || data!.isEmpty) {
      return EmptyDataWidget(
        title: '暂无内容',
        message: '这里还没有任何数据',
        onRefresh: loadData,
      );
    }

    return ListView.builder(
      itemCount: data!.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(data![index]),
        );
      },
    );
  }
}
