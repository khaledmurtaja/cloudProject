// ignore_for_file: public_member_api_docs, sort_constructors_first, sort_child_properties_last
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../core/utils/helperFunctions.dart';
import '../../core/values/colors.dart';
import '../data/models/user.dart';
import '../modules/traineeHome/controller.dart';
import '../modules/traineeLearning/controller.dart';
import 'customButton.dart';

class TrainerDialogDetails extends StatelessWidget {
  final SystemUser trainerData;
  final bool withCommunicate;
  TrainerDialogDetails({
    Key? key,
    required this.trainerData,
    required this.withCommunicate,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dealRandomNumber = generateRandomNumber();
    final dealPercentage = calculatePercentage(dealRandomNumber);
    final conversationRandomNumber = generateRandomNumber();
    final conversationPercentage =
        calculatePercentage(conversationRandomNumber);
    final timeManagementRandomNumber = generateRandomNumber();
    final timeManagementPercentage =
        calculatePercentage(timeManagementRandomNumber);
    final leadershipRandomNumber = generateRandomNumber();
    final leadershipPercentage = calculatePercentage(leadershipRandomNumber);
    final cooperationRandomNumber = generateRandomNumber();
    final cooperationPercentage = calculatePercentage(cooperationRandomNumber);
    return SizedBox(
        width: getMediaQueryWidth(context: context, value: 700),
        height: withCommunicate
            ? getMediaQueryHeight(context: context, value: 650)
            : getMediaQueryHeight(context: context, value: 550),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: ClipOval(
                            child: ImageNetwork(
                              image: trainerData.userImgUrl,
                              width: getMediaQueryWidth(
                                  context: context, value: 80),
                              height: getMediaQueryHeight(
                                  context: context, value: 80),
                              fitWeb: BoxFitWeb.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width:
                              getMediaQueryWidth(context: context, value: 20),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              trainerData.name,
                              style: TextStyle(
                                fontSize: 20.spMin,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: getMediaQueryHeight(
                                  context: context, value: 15),
                            ),
                            Text(
                              trainerData.email,
                              style: TextStyle(
                                fontSize: 12.spMin,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top:
                              getMediaQueryHeight(context: context, value: 24)),
                      child: Text(
                        'About',
                        style: TextStyle(
                          fontSize: 24.spMin,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 8),
                    ),
                    Text(
                      '${trainerData.name} ipsum dolor sit amet\nconsectetur. Lorem in sagittis et\nlibero pretium congue vel\nbibendum.\nIpsum viverra nunc elementum\ntincidunt non.\nId fermentum aenean dictum\nmalesuada neque enim eu.\nFacilisis tincidunt sed eugiat.\nIn adipiscing sed enim ac nulla.\nEnim rhoncus quis odio\nquamimperdiet id nisi facilisis dui.\nOdio sapien nullam ac\n aliquam in scelerisque.',
                      style: TextStyle(
                        fontSize: 16.spMin,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    !withCommunicate
                        ? Container()
                        : SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 24),
                          ),
                    !withCommunicate
                        ? Container()
                        : CustomButton(
                            onPressed: () {},
                            text: 'Connect with him',
                            width: getMediaQueryWidth(
                                context: context, value: 300),
                          )
                  ],
                ),
                flex: 1,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'skills',
                      style: TextStyle(
                        fontSize: 24.spMin,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 8),
                    ),
                    Text(
                      'Deal',
                      style: TextStyle(
                        fontSize: 20.spMin,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 8),
                    ),
                    LinearPercentIndicator(
                      barRadius: const Radius.circular(20.0),
                      width: getMediaQueryWidth(context: context, value: 300),
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2000,
                      percent: dealPercentage,
                      center: Text(
                        "${dealRandomNumber}%",
                        style: TextStyle(
                            fontSize: 8.spMin,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      progressColor: indicatorEnableColor,
                      backgroundColor: indicatorNotEnabledColor,
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 24),
                    ),
                    Text(
                      'Conversation',
                      style: TextStyle(
                        fontSize: 20.spMin,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 8),
                    ),
                    LinearPercentIndicator(
                      barRadius: const Radius.circular(20.0),
                      width: getMediaQueryWidth(context: context, value: 300),
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2000,
                      percent: conversationPercentage,
                      center: Text(
                        "${conversationRandomNumber}%",
                        style: TextStyle(
                            fontSize: 8.spMin,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      progressColor: indicatorEnableColor,
                      backgroundColor: indicatorNotEnabledColor,
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 24),
                    ),
                    Text(
                      'Time management',
                      style: TextStyle(
                        fontSize: 20.spMin,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 8),
                    ),
                    LinearPercentIndicator(
                      barRadius: const Radius.circular(20.0),
                      width: getMediaQueryWidth(context: context, value: 300),
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2000,
                      percent: timeManagementPercentage,
                      center: Text(
                        "${timeManagementRandomNumber}%",
                        style: TextStyle(
                            fontSize: 8.spMin,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      progressColor: indicatorEnableColor,
                      backgroundColor: indicatorNotEnabledColor,
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 24),
                    ),
                    Text(
                      'Leadership',
                      style: TextStyle(
                        fontSize: 20.spMin,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 8),
                    ),
                    LinearPercentIndicator(
                      barRadius: const Radius.circular(20.0),
                      width: getMediaQueryWidth(context: context, value: 300),
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2000,
                      percent: leadershipPercentage,
                      center: Text(
                        "${leadershipRandomNumber}%",
                        style: TextStyle(
                            fontSize: 8.spMin,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      progressColor: indicatorEnableColor,
                      backgroundColor: indicatorNotEnabledColor,
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 24),
                    ),
                    Text(
                      'Cooperation',
                      style: TextStyle(
                        fontSize: 20.spMin,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 8),
                    ),
                    LinearPercentIndicator(
                      barRadius: const Radius.circular(20.0),
                      width: getMediaQueryWidth(context: context, value: 300),
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2000,
                      percent: cooperationPercentage,
                      center: Text(
                        "${cooperationRandomNumber}%",
                        style: TextStyle(
                            fontSize: 8.spMin,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      progressColor: indicatorEnableColor,
                      backgroundColor: indicatorNotEnabledColor,
                    ),
                  ],
                ),
                flex: 1,
              ),
            ],
          ),
        ));
  }
}
