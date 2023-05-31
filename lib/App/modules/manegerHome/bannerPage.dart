import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/manegerHome/widgets/addBannerDialog.dart';
import 'package:getx_architecture/App/modules/manegerHome/widgets/addCourseDialog.dart';
import 'package:getx_architecture/App/modules/manegerHome/widgets/updateBannerDialog.dart';

import '../../../core/utils/helperFunctions.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/imagePaths.dart';
import '../../widgets/customButton.dart';
import 'controller.dart';

class BannerPage extends StatelessWidget {
  const BannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<ManagerHomeController>();
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: getMediaQueryWidth(context: context, value: 40),
                top: getMediaQueryHeight(context: context, value: 80)),
            child: Row(
              children: [
                Icon(
                  Icons.add_link_outlined,
                  size: 32.spMin,
                ),
                SizedBox(
                  width: getMediaQueryWidth(context: context, value: 8),
                ),
                Text(
                  "Banners",
                  style: TextStyle(
                      fontSize: 32.spMin,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const Spacer(),
                CustomButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return AddBannerDialog(
                            controller: controller,
                          );
                        });
                  },
                  text: 'Add Banner',
                  width: getMediaQueryWidth(context: context, value: 248),
                  color: buttonColor,
                ),
                SizedBox(
                  width: getMediaQueryWidth(context: context, value: 120),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          GetBuilder<ManagerHomeController>(
            builder: (controller) {
              if (controller.isGettingBannersLoading) {
                return const CircularProgressIndicator();
              } else {
                print("object");
                return Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 400,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: controller.banners.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: textFormFieldColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                controller.banners[index].imageUrl,
                                height: 171.h,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 18.w),
                                child: Text(
                                  controller.banners[index].name,
                                  style: TextStyle(
                                      fontSize: 16.spMin,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Spacer(),
                              Center(
                                  child: CustomButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                  );
                                  controller.bannerUpdatedName.text=controller.banners[index].name;
                                  showDialog(
                                      context: context,
                                      builder: (c) {
                                        return UpdateBannerDialog(
                                          controller: controller,
                                          index: index,
                                        );
                                      });
                                },
                                text: "Edit",
                                width: 248,
                              )),
                              SizedBox(
                                height: 32.h,
                              )
                            ],
                          ),
                        );
                      }),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
