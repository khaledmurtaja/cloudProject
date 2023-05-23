import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/data/models/ad.dart';
import 'package:getx_architecture/App/data/models/training.dart';
import 'package:getx_architecture/App/modules/traineeHome/controller.dart';
import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:getx_architecture/App/modules/traineeHome/widgets/adBackgroung.dart';
import 'package:getx_architecture/App/modules/traineeHome/widgets/adCard.dart';
import 'package:getx_architecture/App/modules/traineeHome/widgets/adTitle.dart';
import 'package:getx_architecture/App/modules/traineeHome/widgets/moreWidget.dart';
import 'package:getx_architecture/App/modules/traineeHome/widgets/trainingCard.dart';
import 'package:getx_architecture/core/utils/helperFunctions.dart';
import 'package:image_network/image_network.dart';

import '../../../core/values/colors.dart';
import '../../widgets/customButtonWidget.dart';

class TraineeHomeScreen extends GetView<TraineeHomeController> {
  const TraineeHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdaptiveNavBar(
        elevation: 0,
        backgroundColor: Colors.white,
        screenWidth: getMediaQueryWidth(context: context, value: 1440),
        title: const Text("Let's start learning, Moayed"),
        toolbarTextStyle:
            TextStyle(fontWeight: FontWeight.w600, fontSize: 20.spMin),
        titleTextStyle:
            TextStyle(fontWeight: FontWeight.w600, fontSize: 22.spMin),
        navBarItems: [
          NavBarItem(
            text: "Home",
            onTap: () {
              Get.toNamed('/traineeHome');
              // Navigator.pushNamed(context, "routeName");
            },
          ),
          NavBarItem(
            text: "My Learning",
            onTap: () {
              Get.toNamed('/traineeLearning');
            },
          ),
          NavBarItem(
            text: "My profile",
            onTap: () {

              
              Get.toNamed('/traineeProfile');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const AdBackground(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AdTitle(),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 40),
                    ),
                    Obx(
                      () => SizedBox(
                        height:
                            getMediaQueryHeight(context: context, value: 200),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 120),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.ads.length,
                            itemBuilder: (context, index) {
                              final ad = controller.ads[index];
                              return AdCard(ad: ad);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: 20,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120, top: 43),
              child: Text(
                'Recommended for you',
                style:
                    TextStyle(fontSize: 28.spMin, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => controller.isLoadingRecommendedTrainings.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      height: 380,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 120),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              min(controller.recommendedTrainings.length, 4),
                          itemBuilder: (BuildContext context, int index) {
                            final training =
                                controller.recommendedTrainings[index];
                            return TrainingCard(
                              training: training,
                              controller: controller,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 20,
                            );
                          },
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              height: 50,
            ),
            MoreWidget(
              onPressed: () {},
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120, top: 43),
              child: Text(
                'New Trainings',
                style:
                    TextStyle(fontSize: 28.spMin, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => controller.isLoadingNewTrainings.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      height: 380,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 120),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: min(controller.newTrainings.length, 4),
                          itemBuilder: (BuildContext context, int index) {
                            final training = controller.newTrainings[index];
                            return TrainingCard(
                              training: training,
                              controller: controller,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 20,
                            );
                          },
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              height: 50,
            ),
            MoreWidget(
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}









// C:\Users\moaye\flutterProject\cloudProject-1\assets\images\background_ads_home.svg
/*
    return Scaffold(
      appBar: AppBar(
        title: Text("Trainee"),
      ),
      body: Obx(
        () => Column(
          children: [
            Text(
              'Balance: \$${controller.balance.value}',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                controller.showAddBalanceDialog();
              },
              child: const Text('Add Balance'),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed('/trainingBooking');
              },
              child: Text('Click to go to book a training'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
