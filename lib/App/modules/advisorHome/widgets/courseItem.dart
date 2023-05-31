import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/values/colors.dart';

class CourseItem extends StatelessWidget {
  String imageUrl;
  String description;
  String price;
  bool isPaid;
  String advisorName;
  CourseItem(
      {required this.imageUrl,
        required this.description,
        required this.price,
        required this.isPaid,
        required this.advisorName});
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
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 47.h,
            ),
            Text(
              description,
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
              '\$$price',
            ),
            SizedBox(
              height: 16.h,
            ),
            DecoratedBox(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.blue, width: 1))),
              child: Text(
                advisorName,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.blue,
                    fontSize: 12.spMin),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
              height: 16.h,
            )
          ],
        ),
      ),
    );
  }
}
