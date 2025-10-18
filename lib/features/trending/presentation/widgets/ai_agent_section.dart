import 'package:flutter/material.dart';

import 'ai_agent_section_header.dart';
import 'ai_agent_section_list.dart';

class AiAgentSection extends StatelessWidget {
  const AiAgentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AiAgentSectionHeader(),
        AiAgentSectionList(),
      ],
    );
  }
}
