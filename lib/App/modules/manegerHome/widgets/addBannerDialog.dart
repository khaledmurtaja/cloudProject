import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../../core/utils/helperFunctions.dart';
import '../../../../core/values/colors.dart';
import '../../../../core/values/imagePaths.dart';
import '../../../widgets/customButton.dart';
import '../../../widgets/customFormField.dart';
import '../controller.dart';

class AddBannerDialog extends StatelessWidget {
  ManagerHomeController controller;

  AddBannerDialog({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.only(
            left: getMediaQueryWidth(context: context, value: 40),
            right: getMediaQueryWidth(context: context, value: 119),
            top: getMediaQueryHeight(context: context, value: 24)),
        child: SizedBox(
          height: getMediaQueryHeight(context: context, value: 549),
          width: getMediaQueryWidth(context: context, value: 747),
          child: SingleChildScrollView(
            child: Form(
              key: controller.bannerFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Add Banner",
                        style: TextStyle(
                            fontSize: 20.spMin, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      GetBuilder<ManagerHomeController>(
                        builder: (controller) {
                          if (controller.addingBannerLoading) {
                            return const CircularProgressIndicator();
                          } else {
                            return CustomButton(
                              onPressed: () async {
                                controller.updateAddBannerButtonStatues();
                                if (controller.bannerFormKey.currentState!
                                        .validate() &&
                                    controller.bannerImageName !=
                                        "Choose Image") {
                                   controller.storeBannerData();

                                }
                              },
                              text: 'Save banner',
                              width: getMediaQueryWidth(
                                  context: context, value: 200),
                              color: buttonColor,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getMediaQueryHeight(context: context, value: 32),
                  ),
                  Text(
                    "Banner Name",
                    style: TextStyle(
                        fontSize: 20.spMin, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: getMediaQueryHeight(context: context, value: 16),
                  ),
                  CustomFormField(
                    validator: validateBannerNameField,
                    leftPadding: 0,
                    hint: "Banner name",
                    hintSize: 20,
                    prefixIcon: IconButton(
                        onPressed: null,
                        icon: SvgPicture.asset(
                            height: 20.spMin,
                            width: 20.spMin,
                            ImagePaths.courseNameIcon)),
                    controller: controller.bannerName,
                    isPassword: false,
                    topContentPadding: 18,
                    bottomContentPadding: 18,
                    width: getMediaQueryWidth(context: context, value: 588),
                  ),
                  SizedBox(
                    height: getMediaQueryHeight(context: context, value: 24),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: GetBuilder<ManagerHomeController>(
                      builder: (controller) {
                        return Column(
                          children: [
                            CustomButton(
                              theIconBesideText: Icons.image_sharp,
                              color: textFormFieldColor,
                              textColor: Colors.grey,
                              onPressed: () async {
                                await controller.pickBannerFile();
                              },
                              text: controller.bannerImageName,
                            ),
                            SizedBox(
                              height: getMediaQueryHeight(
                                  context: context, value: 5),
                            ),
                            controller.bannerImageName == "Choose Image" &&
                                    controller.isCreateBannerButtonPressed
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Text(
                                      "Choose banner image",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13.spMin),
                                    ),
                                  )
                                : Container()
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
