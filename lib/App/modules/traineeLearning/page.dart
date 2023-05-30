import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/widgets/customAppBar.dart';
import 'package:getx_architecture/core/utils/helperFunctions.dart';
import 'package:getx_architecture/core/values/colors.dart';
import 'package:image_network/image_network.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../widgets/customButton.dart';
import 'controller.dart';
import 'widgets/itemCard.dart';

class TraineeLearningScreen extends GetView<TraineeLearninController> {
  const TraineeLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(controller.onStart);
    return Scaffold(
        appBar: CustomAppBar(),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:
                            getMediaQueryHeight(context: context, value: 100),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/cup.png'),
                          SizedBox(
                            width:
                                getMediaQueryWidth(context: context, value: 40),
                          ),
                          Text(
                            'Complete your journey and get a certificate',
                            style: TextStyle(
                                fontSize: 32.spMin,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(
                        height:
                            getMediaQueryHeight(context: context, value: 100),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: getMediaQueryWidth(
                                context: context, value: 100),
                            top: 43),
                        child: Text(
                          'My Learning',
                          style: TextStyle(
                              fontSize: 28.spMin, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: getMediaQueryWidth(
                                context: context, value: 100),
                            right: getMediaQueryWidth(
                                context: context, value: 100),
                            top: 20,
                            bottom: 20),
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: controller.myLearnings.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 4 / 1,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemBuilder: (BuildContext context, int index) {
                            final randomNumber =
                                controller.generateRandomNumber();
                            final percentage =
                                controller.calculatePercentage(randomNumber);

                            return ItemCard(
                              controller: controller,
                              percentage: percentage,
                              randomNumber: randomNumber,
                              index: index,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
