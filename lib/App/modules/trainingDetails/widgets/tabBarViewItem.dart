import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/helperFunctions.dart';
import '../../../../core/values/colors.dart';
import '../controller.dart';

class TabBarViewItem extends StatelessWidget {
  const TabBarViewItem({
    super.key,
    required this.controller,
  });

  final TrainingDetaileController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Course',
            style: TextStyle(
              fontSize: 35.spMin,
              fontWeight: FontWeight.w600,
                            color: titleColor

            ),
          ),
          SizedBox(
            height: getMediaQueryHeight(context: context, value: 20),
          ),
          SizedBox(
            width: getMediaQueryWidth(context: context, value: 400),
            child: Text(
              controller.training!.description,
              maxLines: 5,
              style: TextStyle(
                color: descriptionColor,
                fontSize: 16.spMin,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
