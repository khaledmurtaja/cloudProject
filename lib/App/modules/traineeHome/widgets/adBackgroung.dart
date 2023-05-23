import 'package:flutter/material.dart';

import '../../../../core/utils/helperFunctions.dart';

class AdBackground extends StatelessWidget {
  const AdBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/background_ads_home.png',
      fit: BoxFit.fill,
      height: getMediaQueryHeight(
        context: context,
        value: 500,
      ),
      width: getMediaQueryWidth(context: context, value: 1440),
    );
  }
}