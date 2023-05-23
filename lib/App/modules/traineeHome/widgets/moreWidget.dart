// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreWidget extends StatelessWidget {

    Function onPressed;

   MoreWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 150),
      child: GestureDetector(
      onTap: () {
        onPressed();
      },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'More',
              style: TextStyle(fontSize: 16.spMin, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
