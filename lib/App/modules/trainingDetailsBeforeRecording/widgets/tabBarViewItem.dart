// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/helperFunctions.dart';
import '../../../../core/values/colors.dart';
import '../../../data/models/training.dart';
import '../controller.dart';

class TabBarViewItem extends StatelessWidget {
  final Training training;
  const TabBarViewItem({
    Key? key,
    required this.training,
  }) : super(key: key);

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
                color: titleColor),
          ),
          SizedBox(
            height: getMediaQueryHeight(context: context, value: 20),
          ),
          SizedBox(
            width: getMediaQueryWidth(context: context, value: 600),
            child: Text(
            training.description,
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
