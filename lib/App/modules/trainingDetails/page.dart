import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/trainingDetails/controller.dart';
import 'package:getx_architecture/App/modules/trainingDetails/widgets/advisorItem.dart';
import 'package:getx_architecture/App/modules/trainingDetails/widgets/customFixedRow.dart';
import 'package:getx_architecture/App/modules/trainingDetails/widgets/customTabBar.dart';
import 'package:getx_architecture/App/modules/trainingDetails/widgets/fixedSideMenu.dart';
import 'package:getx_architecture/App/modules/trainingDetails/widgets/imageGradint.dart';
import 'package:getx_architecture/App/modules/trainingDetails/widgets/tabBarViewItem.dart';
import 'package:getx_architecture/App/modules/trainingDetails/widgets/trainingTopDetails.dart';
import 'package:getx_architecture/core/utils/helperFunctions.dart';
import 'package:image_network/image_network.dart';

import '../../../core/values/colors.dart';
import '../../widgets/customButtonWidget.dart';

class TrainingDetaileScreen extends GetView<TrainingDetaileController> {
  const TrainingDetaileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: GetBuilder<TrainingDetaileController>(
          builder: (newController) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ImageGradint(controller: newController),
                    TrainingTopDetails(
                      controller: newController,
                      training: controller.training!,
                    )
                  ],
                ),
                SizedBox(
                  height: getMediaQueryHeight(context: context, value: 70),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: CustomTabBar(),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: getMediaQueryHeight(context: context, value: 50),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 700,
                        height: 400,
                        child: TabBarView(
                          children: [
                            TabBarViewItem(controller: controller),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Advisor',
                                  style: TextStyle(
                                      fontSize: 35.spMin,
                                      fontWeight: FontWeight.w600,
                                      color: titleColor),
                                ),
                                SizedBox(
                                  height: getMediaQueryHeight(
                                    context: context,
                                    value: 30,
                                  ),
                                ),
                                AdvisorItem(
                                  controller: newController,
                                ),
                              ],
                            ),
                            TabBarViewItem(controller: controller),
                            TabBarViewItem(controller: controller),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      const Expanded(
                        flex: 1,
                        child: FixedSideMenu(),
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //     height: getMediaQueryHeight(context: context, value: 50)),

                SizedBox(
                    height: getMediaQueryHeight(context: context, value: 50)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}