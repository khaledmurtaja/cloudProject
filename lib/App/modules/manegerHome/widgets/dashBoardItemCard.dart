import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/helperFunctions.dart';
import '../../../../core/values/colors.dart';

class DashBoardItemCard extends StatelessWidget {
  String title;
  String value;
  bool? isLoading;
  DashBoardItemCard(
      {super.key, required this.title, required this.value, this.isLoading});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: getMediaQueryHeight(context: context, value: 159),
          width: getMediaQueryWidth(context: context, value: 159),
          decoration: BoxDecoration(
              color: dashboardCardColors,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: getMediaQueryHeight(context: context, value: 16)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 20.spMin),
                  ),
                ),
              ),
              SizedBox(
                height: getMediaQueryHeight(context: context, value: 16),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: getMediaQueryWidth(context: context, value: 16)),
                child: !isLoading!
                    ? Text(
                        value,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20.spMin),
                      )
                    : SizedBox(
                        height: 20.h,
                        width: 10.w,
                        child: const CircularProgressIndicator(strokeWidth: 1,)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
