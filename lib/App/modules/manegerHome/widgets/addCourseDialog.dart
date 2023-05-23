import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:getx_architecture/App/modules/manegerHome/controller.dart';
import 'package:getx_architecture/core/values/roles.dart';
import '../../../../core/utils/helperFunctions.dart';
import '../../../../core/values/colors.dart';
import '../../../../core/values/enums.dart';
import '../../../../core/values/fontsStyles.dart';
import '../../../../core/values/imagePaths.dart';
import '../../../widgets/customButton.dart';
import '../../../widgets/customDropDown.dart';
import '../../../widgets/customFormField.dart';
import 'customDropDown.dart';

class AddCourseDialog extends StatelessWidget {
  ManagerHomeController controller;

  AddCourseDialog({required this.controller});

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
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Add Course",
                        style: TextStyle(
                            fontSize: 20.spMin, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      GetBuilder<ManagerHomeController>(
                        builder: (controller) {
                          if (controller.addingTrainingLoading) {
                            return const CircularProgressIndicator();
                          } else {
                            return CustomButton(
                              onPressed: () async {
                                controller.updateAddCourseButtonStatues();
                                if (controller.formKey.currentState!
                                        .validate() &&
                                    controller.imageName != "Choose Image") {
                                  await controller.storeTrainingData();
                                }
                              },
                              text: 'Save Course',
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
                    "Course Name",
                    style: TextStyle(
                        fontSize: 20.spMin, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: getMediaQueryHeight(context: context, value: 16),
                  ),
                  CustomFormField(
                    validator: validateCourseNameField,
                    leftPadding: 0,
                    hint: "Course name",
                    hintSize: 20,
                    prefixIcon: IconButton(
                        onPressed: null,
                        icon: SvgPicture.asset(
                            height: 20.spMin,
                            width: 20.spMin,
                            ImagePaths.courseNameIcon)),
                    controller: controller.courseName,
                    isPassword: false,
                    topContentPadding: 18,
                    bottomContentPadding: 18,
                    width: getMediaQueryWidth(context: context, value: 588),
                  ),
                  SizedBox(
                    height: getMediaQueryHeight(context: context, value: 24),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Advisor",
                            style: TextStyle(fontSize: 20.spMin),
                          ),
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 16),
                          ),
                          GetBuilder<ManagerHomeController>(
                            builder: (controller) {
                              return CustomAdvisorDropdownButton(
                                hint: "Choose Course advisor",
                                prefixIconPath: ImagePaths.advisorGreyIcon,
                                data: controller.listOfSystemUser,
                                width: getMediaQueryWidth(
                                    context: context, value: 274),
                                height: getMediaQueryHeight(
                                    context: context, value: 56),
                                textStyle: TextStyle(
                                    fontSize: 16.spMin,
                                    color: customCardTextColor),
                                onChange: (value) {
                                  controller.advisorName = value.name;
                                  controller.advisorId = value.id;
                                },
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        width: getMediaQueryWidth(context: context, value: 40),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Category",
                            style: TextStyle(fontSize: 20.spMin),
                          ),
                          SizedBox(
                            height: getMediaQueryHeight(
                                context: context, value: 16),
                          ),
                          GetBuilder<ManagerHomeController>(
                            builder: (controller) {
                              return CustomDropdownButton(
                                hint: "Choose Course Category",
                                prefixIconPath: ImagePaths.categoryGreyIcon,
                                data: controller.categories,
                                width: getMediaQueryWidth(
                                    context: context, value: 274),
                                height: getMediaQueryHeight(
                                    context: context, value: 56),
                                textStyle: TextStyle(
                                    fontSize: 16.spMin,
                                    color: customCardTextColor),
                                onChange: (value) async {
                                  await controller.getUsers(
                                      category: value, role: Roles.advisor);
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getMediaQueryHeight(context: context, value: 24),
                  ),
                  const Text("Description"),
                  SizedBox(
                    height: getMediaQueryHeight(context: context, value: 16),
                  ),
                  CustomFormField(
                    validator: validateDescription,
                    hintSize: 16,
                    leftPadding: 4,
                    textInputType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 3000,
                    controller: controller.courseDescription,
                    isPassword: false,
                    hint: "Write course description",
                    topContentPadding: 18,
                    bottomContentPadding: 112,
                    width: getMediaQueryWidth(context: context, value: 588),
                  ),
                  GetBuilder<ManagerHomeController>(
                    builder: (controller) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: const Text("Paid"),
                                  leading: Radio<CoursePaying>(
                                    value: CoursePaying.paid,
                                    groupValue: controller.payingValue,
                                    activeColor: Colors.black,
                                    onChanged: (value) {
                                      controller.updatePayingRadioButton(
                                          value: value);
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: const Text("Free"),
                                  leading: Radio<CoursePaying>(
                                    value: CoursePaying.free,
                                    activeColor: Colors.black,
                                    groupValue: controller.payingValue,
                                    onChanged: (value) {
                                      controller.updatePayingRadioButton(
                                          value: value);
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          controller.payingValue == CoursePaying.paid
                              ? CustomFormField(
                                  validator: validateCoursePrice,
                                  controller: controller.coursePrice,
                                  prefixIcon: IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.monetization_on,
                                        color: Colors.grey.shade300,
                                        size: 24.spMin,
                                      )),
                                  isPassword: false,
                                  width: 100.w,
                                  topContentPadding: 18,
                                  bottomContentPadding: 18,
                                  leftPadding: 5,
                                  hint: "Course price",
                                  textInputType: TextInputType.number,
                                )
                              : Container(),
                        ],
                      );
                    },
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
                                await controller.pickFile();
                              },
                              text: controller.imageName,
                            ),
                            SizedBox(
                              height: getMediaQueryHeight(
                                  context: context, value: 5),
                            ),
                            controller.imageName == "Choose Image" &&
                                    controller.isCreateCourseButtonPressed
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Text(
                                      "Choose course image",
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
                  SizedBox(
                    height: 16.h,
                  ),
                  GetBuilder<ManagerHomeController>(
                    builder: (controller) {
                      if (controller.isEditing) {
                        return ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 213),
                          child: CustomButton(
                            onPressed: () {
                              controller.addDate();
                            },
                            text: 'Save',
                          ),
                        );
                      } else {
                        return ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 213),
                          child: CustomButton(
                            onPressed: () {
                              controller.changeEditMode();
                            },
                            text: 'add new course date',
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  GetBuilder<ManagerHomeController>(
                    builder: (controller) {
                      if (controller.isEditing) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Day",
                                    style: TextStyle(fontSize: 20.spMin),
                                  ),
                                  CustomDropdownButton(
                                    data: controller.daysOfWeek,
                                    textStyle: const TextStyle(),
                                    onChange: (value) {
                                      controller.changeSelectedDay(
                                          newValue: value);
                                    },
                                    prefixIconData:
                                        Icons.calendar_month_rounded,
                                    hint: controller.selectedDay,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "From Time",
                                    style: TextStyle(fontSize: 20.spMin),
                                  ),
                                  CustomButton(
                                    color: textFormFieldColor,
                                    theIconBesideText: Icons.timer,
                                    textColor: Colors.grey,
                                    onPressed: () async {
                                      TimeOfDay? time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      controller.changeFromTime(
                                          fromTime: time!);
                                    },
                                    text:
                                        "${controller.hoursFrom}:${controller.minutesFrom} ${controller.periodFrom}",
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "To Time",
                                    style: TextStyle(fontSize: 20.spMin),
                                  ),
                                  CustomButton(
                                    color: textFormFieldColor,
                                    textColor: Colors.grey,
                                    theIconBesideText: Icons.timer,
                                    onPressed: () async {
                                      TimeOfDay? time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      controller.changeToTime(toTime: time!);
                                    },
                                    text:
                                        "${controller.hoursTo}:${controller.minutesTo} ${controller.periodTo}",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  GetBuilder<ManagerHomeController>(
                    builder: (controller) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            columns: [
                              DataColumn(
                                  label: Text(
                                'Course date',
                                style: FontStyles.tableHeadingStyle,
                              )),
                              DataColumn(
                                  label: Text(
                                'Day',
                                style: FontStyles.tableHeadingStyle,
                              )),
                              DataColumn(
                                  label: Text(
                                'Start Time',
                                style: FontStyles.tableHeadingStyle,
                              )),
                              DataColumn(
                                  label: Text(
                                'End Time',
                                style: FontStyles.tableHeadingStyle,
                              )),
                              // DataColumn(label: Text("")),
                            ],
                            rows: controller.attendanceDates.map((e) {
                              return DataRow(cells: [
                                DataCell(Text('#',
                                    style: FontStyles.tableCellStyle)),
                                DataCell(Text(
                                  e.day,
                                  style: FontStyles.tableCellStyle,
                                )),
                                DataCell(Text(e.startHour,
                                    style: FontStyles.tableCellStyle)),
                                DataCell(Text(e.endHour,
                                    style: FontStyles.tableCellStyle))
                              ]);
                            }).toList()),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
