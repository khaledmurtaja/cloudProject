// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/values/colors.dart';

class CustomFixedRow extends StatelessWidget {


final String title;
final String supTitle;
final String imageUrl;
  const CustomFixedRow({
    Key? key,
    required this.title,
    required this.supTitle,
    required this.imageUrl,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imageUrl),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20.spMin,
                  fontWeight: FontWeight.w600,
                  color: titleColor),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              supTitle,
              style: TextStyle(fontSize: 16.spMin, fontWeight: FontWeight.w500),
            )
          ],
        )
      ],
    );
  }
}
