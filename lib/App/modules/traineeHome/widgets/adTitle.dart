import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdTitle extends StatelessWidget {
  const AdTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 120, top: 43),
      child: Text(
        "The best courses \nfrom experts",
        style: TextStyle(
          fontSize: 50.spMin,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}