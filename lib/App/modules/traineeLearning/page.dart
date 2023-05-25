import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/widgets/customAppBar.dart';

import 'controller.dart';

class TraineeLearningScreen extends GetView<TraineeLearninController> {
  const TraineeLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(controller.onStart);
    return Scaffold(
      appBar: CustomAppBar(),
    );
  }
}
