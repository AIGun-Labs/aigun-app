import 'package:flutter/material.dart';

import 'error_widget.dart';

class ErrorWidgetExample extends StatelessWidget {
  const ErrorWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Widget Examples')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const GlobalErrorWidget(title: '', message: '，', onRetry: null),

          const Divider(height: 40),

          NetworkErrorWidget(
            onRetry: () {
              print('Retrying network request...');
            },
          ),

          const Divider(height: 40),

          EmptyDataWidget(
            title: '',
            message: '',
            onRefresh: () {
              print('Refreshing data...');
            },
          ),

          const Divider(height: 40),

          LoadingErrorWidget(
            onRetry: () {
              print('Retrying loading...');
            },
            error: 'TimeoutException: Request timeout',
          ),

          const Divider(height: 40),

          CustomErrorWidgetBuilder.build(
            context: context,
            type: CustomErrorType.network,
            customMessage: '',
            onRetry: () {
              print('Custom retry action');
            },
          ),
        ],
      ),
    );
  }
}

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
      await Future.delayed(const Duration(seconds: 2));

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
      return NetworkErrorWidget(onRetry: loadData, message: '，');
    }

    if (data == null || data!.isEmpty) {
      return EmptyDataWidget(title: '', message: '', onRefresh: loadData);
    }

    return ListView.builder(
      itemCount: data!.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(data![index]));
      },
    );
  }
}
