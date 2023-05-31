import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/values/colors.dart';
import '../controller.dart';

class StudentsItem extends StatelessWidget {
  String imageUrl;
  String name;
  String email;
  String field;
  AdvisorController controller;
  StudentsItem(
      {required this.imageUrl,
        required this.name,
        required this.email,
        required this.controller,
        required this.field});
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
              email,
            ),
            SizedBox(
              height: 16.h,
            ),
            DecoratedBox(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.blue, width: 1))),
              child: Text(
                field,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.blue,
                    fontSize: 12.spMin),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
           SelectableText(
             controller.url[0]
           )
           ,
            SizedBox(
              height: 16.h,
            )
          ],
        ),
      ),
    );
  }
}
