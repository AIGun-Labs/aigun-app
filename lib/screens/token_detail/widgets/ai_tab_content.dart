import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';

class AITabContent extends StatelessWidget {
  const AITabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Expanded(
              child: ListView.separated(
                  itemCount: 10,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: AppColors.border(context),
                      height: 1,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    // return IntelMessageItem(intel: null!, index: index);
                    return const SizedBox.shrink();
                  })),
        ],
      ),
    );
  }
}
