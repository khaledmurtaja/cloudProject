import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/values/colors.dart';

class TraineeItem extends StatelessWidget {
  String usrImageUrl;
  String name;
  String field;
  TraineeItem(
      {required this.usrImageUrl,
        required this.name,
        required this.field,
    });
  @override
  Widget build(BuildContext context) {
    return Container(
      height:407.h ,
      width: 281.w,
      color: dashboardCardColors,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  usrImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 47.h,
            ),
            Text(
              name,
              maxLines: 2,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12.spMin),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              field,
            ),
            SizedBox(
              height: 16.h,
            ),

          ],
        ),
      ),
    );
  }
}
