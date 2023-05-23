import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_network/image_network.dart';

import '../../../data/models/ad.dart';

class AdCard extends StatelessWidget {
  const AdCard({
    super.key,
    required this.ad,
  });

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: 384,
      height: 200,
      child: Card(
        color: Colors.grey[400]?.withOpacity(.3),
        child: Column(
          children: [
            ImageNetwork(
              image: ad.imageUrl,
              width: 100,
              height: 100,
              fitWeb: BoxFitWeb.cover,
            ),
            const SizedBox(height: 8),
            Text(
              ad.name,
              style: TextStyle(
                  fontSize: 24.spMin,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}