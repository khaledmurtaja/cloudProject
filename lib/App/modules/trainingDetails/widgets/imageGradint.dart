import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import '../../../../core/utils/helperFunctions.dart';
import '../controller.dart';

class ImageGradint extends StatelessWidget {
  const ImageGradint({
    super.key,
    required this.controller,
  });

  final TrainingDetaileController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ImageNetwork(
            image: controller.training!.imageUrl,
            height: getMediaQueryHeight(context: context, value: 510),
            width: getMediaQueryWidth(context: context, value: 600)),
        Container(
          height: getMediaQueryHeight(context: context, value: 510),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.6),
          ),
        ),
        Container(
          height: getMediaQueryHeight(context: context, value: 510),
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.grey.withOpacity(0.0),
                    Colors.white,
                  ],
                  stops: [
                    0.0,
                    1.0
                  ])),
        )
      ],
    );
  }
}
