import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/values/colors.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
  });
  final String text1;
  final String text2;
  final String text3;
  final String text4;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: TabBar(
        labelColor: tabBarLabelColor,
        dividerColor: tabBarDividerColor,
        labelStyle: TextStyle(fontSize: 16.spMin, fontWeight: FontWeight.w600),
        unselectedLabelColor: tabBarUnselectedLabelColor,
        tabs: [
          Tab(
            text: text1,
          ),
          Tab(
            text: text2,
          ),
          Tab(
            text: text3,
          ),
          Tab(
            text: text4,
          )
        ], // list of tabs
      ),
    );
  }
}
