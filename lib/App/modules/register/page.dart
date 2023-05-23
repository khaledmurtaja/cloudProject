import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/utils/helperFunctions.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/imagePaths.dart';
import '../../../routes/routes.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customDropDown.dart';
import '../../widgets/customFormField.dart';
import 'controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: getMediaQueryWidth(context: context, value: 612),
              child: Image.asset(
                ImagePaths.loginScreenImage,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              width: getMediaQueryWidth(context: context, value: 828),
              child: Form(
                  key: controller.formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: getMediaQueryWidth(
                          context: context,
                          value: 120,
                        ),
                        right: getMediaQueryWidth(context: context, value: 120),
                        top: getMediaQueryHeight(context: context, value: 88)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 32.spMin),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                "Back to Login",
                                style: TextStyle(
                                    color: clickHereColor, fontSize: 20.spMin),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height:
                              getMediaQueryHeight(context: context, value: 18),
                        ),
                        SizedBox(
                          height:
                              getMediaQueryHeight(context: context, value: 50),
                        ),
                        Text(
                          "Name",
                          style: TextStyle(fontSize: 20.spMin),
                        ),
                        SizedBox(
                          height:
                              getMediaQueryHeight(context: context, value: 16),
                        ),
                        CustomFormField(
                          leftPadding: 5,
                          topContentPadding: 18,
                          bottomContentPadding: 18,
                          validator: validateNameField,
                          controller: controller.nameController,
                          hint: "Enter your name",
                          isPassword: false,
                          width: getMediaQueryWidth(
                            context: context,
                            value: 588,
                          ),
                        ),
                        SizedBox(
                          height:
                              getMediaQueryHeight(context: context, value: 24),
                        ),
                        Text(
                          "Email",
                          style: TextStyle(fontSize: 20.spMin),
                        ),
                        SizedBox(
                          height:
                              getMediaQueryHeight(context: context, value: 16),
                        ),
                        CustomFormField(
                          leftPadding: 5,
                          topContentPadding: 18,
                          bottomContentPadding: 18,
                          validator: validateEmail,
                          controller: controller.emailController,
                          hint: "Enter your Email",
                          isPassword: false,
                          width: getMediaQueryWidth(
                            context: context,
                            value: 588,
                          ),
                        ),
                        SizedBox(
                          height:
                              getMediaQueryHeight(context: context, value: 24),
                        ),
                        Text(
                          "Password",
                          style: TextStyle(fontSize: 20.spMin),
                        ),
                        SizedBox(
                          height:
                              getMediaQueryHeight(context: context, value: 16),
                        ),
                        GetBuilder<RegisterController>(
                          builder: (controller) {
                            return CustomFormField(
                              leftPadding: 5,
                              topContentPadding: 18,
                              bottomContentPadding: 18,
                              validator: validatePasswordRegister,
                              controller: controller.passwordController,
                              isPassword: controller.securePassword,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.onRedEyeClicked();
                                  },
                                  icon: controller.securePassword
                                      ? const Icon(Icons.remove_red_eye)
                                      : const Icon(
                                          Icons.visibility_off_outlined)),
                              hint: "Enter your password",
                              width: getMediaQueryWidth(
                                context: context,
                                value: 588,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height:
                              getMediaQueryHeight(context: context, value: 33),
                        ),
                        GetBuilder<RegisterController>(
                          builder: (controller) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomButton(
                                    onPressed: () async {
                                      await controller.pickFile();
                                    },
                                    text: controller.fileName),
                                SizedBox(
                                  height: getMediaQueryHeight(
                                      context: context, value: 5),
                                ),
                                controller.fileName == "choose file"&&controller.isRegisterButtonPressed
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: Text(
                                          "Choose supporting file",
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
                        SizedBox(
                          height:
                              getMediaQueryHeight(context: context, value: 67),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Register as",
                                    style: TextStyle(
                                        fontSize: 16.spMin,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: getMediaQueryHeight(
                                        context: context, value: 8),
                                  ),
                                  CustomDropdownButton(
                                    height: getMediaQueryHeight(
                                        context: context, value: 48),
                                    width: getMediaQueryWidth(
                                        context: context, value: 176),
                                    textStyle: TextStyle(
                                        fontSize: 16.spMin,
                                        color: customCardTextColor),
                                    data: controller.role,
                                    onChange: (value) {
                                      controller.changeRoleFiled(role: value);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Specialization",
                                    style: TextStyle(
                                        fontSize: 16.spMin,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: getMediaQueryHeight(
                                        context: context, value: 8),
                                  ),
                                  CustomDropdownButton(
                                    height: getMediaQueryHeight(
                                        context: context, value: 48),
                                    width: getMediaQueryWidth(
                                        context: context, value: 176),
                                    textStyle: TextStyle(
                                        fontSize: 16.spMin,
                                        color: customCardTextColor),
                                    data: controller.professions,
                                    onChange: (value) {
                                      controller.changeProfessionFiled(
                                          value: value);
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height:
                              getMediaQueryHeight(context: context, value: 67),
                        ),
                        GetBuilder<RegisterController>(
                          builder: (controller) {
                            if (controller.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              return CustomButton(
                                onPressed: () async {
                                  controller.updateRegisterButtonStatues();
                                  bool isFormValidated = controller
                                      .formKey.currentState!
                                      .validate();
                                  if (isFormValidated &&
                                      controller.fileName != "choose file") {
                                    /// after signing in successfully
                                    await controller.registerUser(
                                        email: controller.emailController.text,
                                        password:
                                            controller.passwordController.text);
                                  }
                                },
                                text: 'Register',
                                textBtnFontWeight: FontWeight.w700,
                                color: buttonColor,
                              );
                            }
                          },
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Padding(
  //         padding: const EdgeInsets.all(10),
  //         child: ListView(
  //           children: <Widget>[
  //             Container(
  //                 alignment: Alignment.center,
  //                 padding: const EdgeInsets.all(10),
  //                 child: const Text(
  //                   'TutorialKart',
  //                   style: TextStyle(
  //                       color: Colors.blue,
  //                       fontWeight: FontWeight.w500,
  //                       fontSize: 30),
  //                 )),
  //             Container(
  //               padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
  //               child: TextField(
  //                 controller: controller.nameController,
  //                 decoration: const InputDecoration(
  //                   border: OutlineInputBorder(),
  //                   labelText: 'name',
  //                 ),
  //               ),
  //             ),
  //             Container(
  //                 alignment: Alignment.center,
  //                 padding: const EdgeInsets.all(10),
  //                 child: const Text(
  //                   'Sign in',
  //                   style: TextStyle(fontSize: 20),
  //                 )),
  //             Container(
  //               padding: const EdgeInsets.all(10),
  //               child: TextField(
  //                 controller: controller.emailController,
  //                 decoration: const InputDecoration(
  //                   border: OutlineInputBorder(),
  //                   labelText: 'Email',
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
  //               child: TextField(
  //                 obscureText: true,
  //                 controller: controller.passwordController,
  //                 decoration: const InputDecoration(
  //                   border: OutlineInputBorder(),
  //                   labelText: 'Password',
  //                 ),
  //               ),
  //             ),
  //             GetBuilder<RegisterController>(
  //               builder: (controller) {
  //                 return DropdownButton<String>(
  //                   value: controller.selectedRoleValue,
  //                   onChanged: (newValue) {
  //                     controller.changeRoleFiled(role: newValue!);
  //                   },
  //                   items: const [
  //                     DropdownMenuItem(
  //                       value: 'trainee',
  //                       child: Text('trainee'),
  //                     ),
  //                     DropdownMenuItem(
  //                       value: 'advisor',
  //                       child: Text('advisor'),
  //                     ),
  //                   ],
  //                 );
  //               },
  //             ),
  //             GetBuilder<RegisterController>(
  //               builder: (controller) {
  //                 return DropdownButton<String>(
  //                   value: controller.selectedProfessionValue,
  //                   onChanged: (newValue) {
  //                     controller.changeProfessionFiled(value: newValue!);
  //                   },
  //                   items: const [
  //                     DropdownMenuItem(
  //                       value: 'mobile development',
  //                       child: Text('Mobile Development'),
  //                     ),
  //                     DropdownMenuItem(
  //                       value: 'web development',
  //                       child: Text('Web Development'),
  //                     ),
  //                     DropdownMenuItem(
  //                       value: 'ui_ux',
  //                       child: Text('UI/UX'),
  //                     ),
  //                   ],
  //                 );
  //               },
  //             ),
  //             Container(
  //                 height: 50,
  //                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
  //                 child: ElevatedButton(
  //                   child: const Text('choose supporting document'),
  //                   onPressed: () async {
  //                     await controller.pickFile();
  //                   },
  //                 )),
  //             TextButton(
  //               onPressed: () {
  //                 //forgot password screen
  //               },
  //               child: const Text(
  //                 'Forgot Password',
  //               ),
  //             ),
  //             GetBuilder<RegisterController>(
  //               builder: (controller) {
  //                 if (!controller.isLoading) {
  //                   return Container(
  //                       height: 50,
  //                       padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
  //                       child: ElevatedButton(
  //                         child: const Text('register'),
  //                         onPressed: () async {
  //                           await controller.registerUser(
  //                               email: controller.emailController.text,
  //                               password: controller.passwordController.text);
  //                           Get.toNamed(Routes.REVIEW);
  //                         },
  //                       ));
  //                 } else {
  //                   return const Center(child: CircularProgressIndicator());
  //                 }
  //               },
  //             ),
  //             SizedBox(
  //               height: 20.h,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 const Text('have an account'),
  //                 TextButton(
  //                   child: const Text(
  //                     'Sign in',
  //                     style: TextStyle(fontSize: 20),
  //                   ),
  //                   onPressed: () {
  //                     Get.toNamed(Routes.LOGIN);
  //                     //signup screen
  //                   },
  //                 )
  //               ],
  //             ),
  //           ],
  //         )),
  //   );
  // }
}
