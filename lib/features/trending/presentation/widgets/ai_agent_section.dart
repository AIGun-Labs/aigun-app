import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ai_agent_section_header.dart';
import 'ai_agent_section_list.dart';

class AiAgentSection extends StatelessWidget {
  const AiAgentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AiAgentSectionHeader(),
        const AiAgentSectionList(),
        SizedBox(height: 5.h),
      ],
    );
  }
}
