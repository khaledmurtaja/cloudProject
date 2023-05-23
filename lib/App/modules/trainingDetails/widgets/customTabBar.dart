import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/values/colors.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: TabBar(
        labelColor: tabBarLabelColor,
        dividerColor: tabBarDividerColor,
        labelStyle: TextStyle(
            fontSize: 16.spMin,
            fontWeight: FontWeight.w600),
        unselectedLabelColor: tabBarUnselectedLabelColor,
        tabs: const [
          Tab(
            text: 'About Course',
          ),
          Tab(
            text: 'Advisor',
          ),
          Tab(
            text: 'Syllabus',
          ),
          Tab(
            text: 'FQA',
          )
        ], // list of tabs
      ),
    );
  }
}
