import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/traineeProfile/widgets/paymentForm.dart';
import 'package:getx_architecture/App/modules/traineeProfile/widgets/paymentSection.dart';
import 'package:getx_architecture/core/utils/helperFunctions.dart';
import 'package:image_network/image_network.dart';

import '../../../core/values/colors.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/customButton.dart';
import 'controller.dart';

class TraineeProfileScreen extends GetView<TraineeProfileController> {
  const TraineeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: getMediaQueryWidth(
                                  context: context, value: 80),
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              child: ClipOval(
                                child: ImageNetwork(
                                  image:
                                      controller.systemUser.value!.userImgUrl,
                                  width: getMediaQueryWidth(
                                      context: context, value: 100),
                                  height: getMediaQueryHeight(
                                      context: context, value: 150),
                                  fitWeb: BoxFitWeb.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: getMediaQueryWidth(
                                context: context, value: 100),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person),
                                  SizedBox(
                                    width: getMediaQueryWidth(
                                        context: context, value: 8),
                                  ),
                                  Text(
                                    'Personal Information',
                                    style: TextStyle(
                                      fontSize: 28.spMin,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getMediaQueryWidth(
                                    context: context, value: 30),
                              ),
                              Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 20.spMin,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: getMediaQueryWidth(
                                  context: context,
                                  value: 16,
                                ),
                              ),
                              PersonalInfCard(
                                  value: controller.systemUser.value!.name),
                              SizedBox(
                                height: getMediaQueryWidth(
                                  context: context,
                                  value: 24,
                                ),
                              ),
                              Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 20.spMin,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: getMediaQueryWidth(
                                  context: context,
                                  value: 16,
                                ),
                              ),
                              PersonalInfCard(
                                  value: controller.systemUser.value!.email),
                              SizedBox(
                                height: getMediaQueryWidth(
                                  context: context,
                                  value: 24,
                                ),
                              ),
                              Text(
                                'Specialization',
                                style: TextStyle(
                                  fontSize: 20.spMin,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: getMediaQueryWidth(
                                  context: context,
                                  value: 16,
                                ),
                              ),
                              PersonalInfCard(
                                  value: controller.systemUser.value!.field),
                              SizedBox(
                                height: getMediaQueryWidth(
                                  context: context,
                                  value: 24,
                                ),
                              ),
                              Text(
                                'Id',
                                style: TextStyle(
                                  fontSize: 20.spMin,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: getMediaQueryWidth(
                                  context: context,
                                  value: 16,
                                ),
                              ),
                              PersonalInfCard(
                                  value: controller.systemUser.value!.uid),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: getMediaQueryWidth(
                                context: context, value: 10)),
                        child: PaymentSection(
                          controller: controller,
                        ),
                      ),
                    ),
                  ]),
      ),
    );
  }
}

class PersonalInfCard extends StatelessWidget {
  const PersonalInfCard({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getMediaQueryWidth(context: context, value: 500),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: cardBackgroundColor,
        child: Padding(
          padding: EdgeInsets.only(
            left: getMediaQueryWidth(context: context, value: 25),
            right: getMediaQueryWidth(context: context, value: 25),
            top: getMediaQueryHeight(context: context, value: 20),
            bottom: getMediaQueryHeight(context: context, value: 20),
          ),
          child: Text(value),
        ),
      ),
    );
  }
}

class PaymentSection extends StatelessWidget {
  const PaymentSection({
    super.key,
    required this.controller,
  });

  final TraineeProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.payment),
            SizedBox(
              width: getMediaQueryWidth(context: context, value: 8),
            ),
            Text(
              'My Wallet',
              style: TextStyle(
                fontSize: 28.spMin,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(
          height: getMediaQueryHeight(context: context, value: 30),
        ),
       Container(
      width: getMediaQueryWidth(context: context, value: 400),
      child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: cardBackgroundColor,
          child: Padding(
            padding: EdgeInsets.only(
              left: getMediaQueryWidth(context: context, value: 35),
              right: getMediaQueryWidth(context: context, value: 35),
              top: getMediaQueryHeight(context: context, value: 40),
              bottom: getMediaQueryHeight(context: context, value: 40),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/icons/logos_mastercard.png'),
                    SizedBox(
                      width: getMediaQueryWidth(context: context, value: 8),
                    ),
                    Image.asset('assets/icons/logos_paypal.png'),
                    SizedBox(
                      width: getMediaQueryWidth(context: context, value: 8),
                    ),
                    Image.asset('assets/icons/logos_visa.png'),
                    SizedBox(
                      width: getMediaQueryWidth(context: context, value: 8),
                    ),
                  ],
                ),
                SizedBox(
                  height: getMediaQueryWidth(context: context, value: 30),
                ),
                Text(
                  '${controller.balance.value}\$',
                  style: TextStyle(
                    fontSize: 32.spMin,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: getMediaQueryWidth(context: context, value: 80),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      width: getMediaQueryWidth(context: context, value: 100),
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'Increase Balance',
                          content: PaymentForm(
                            controller: controller,
                          ),
                        );
                      },
                      text: 'Deposit',
                    ),
                    CustomButton(
                      width: getMediaQueryWidth(context: context, value: 100),
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'Increase Balance',
                          content: PaymentForm(
                            controller: controller,
                          ),
                        );
                      },
                      text: 'Coupons',
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
      ],
    );
  }
}

class PaymentForm extends StatelessWidget {
  const PaymentForm({
    super.key,
    required this.controller,
  });

  final TraineeProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current Balance: ${controller.balance.value}'),
        SizedBox(height: 16.0),
        TextField(
          controller: controller.balanceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Amount to Add',
          ),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            controller.increaseBalance(controller.uId.value);
          },
          child: Text('Increase Balance'),
        ),
      ],
    );
  }
}
