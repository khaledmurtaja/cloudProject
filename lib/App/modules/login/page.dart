import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/utils/helperFunctions.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/imagePaths.dart';
import '../../../routes/routes.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customFormField.dart';
import 'controller.dart';

class LoginScreen extends GetView<LoginController> {
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
                        Text(
                          "Log In",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 32.spMin),
                        ),
                        SizedBox(
                          height:
                              getMediaQueryHeight(context: context, value: 18),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Use your ID to login to the system.",
                                style: TextStyle(
                                    fontSize: 16.spMin,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              width: getMediaQueryWidth(
                                  context: context, value: 47),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                   Get.rootDelegate.toNamed(Routes.REGISTER);
                                },
                                child: Text(
                                  "Register here",
                                  style: TextStyle(
                                      color: clickHereColor, fontSize: 20.spMin),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height:
                              getMediaQueryHeight(context: context, value: 50),
                        ),
                        Text(
                          "ID",
                          style: TextStyle(fontSize: 20.spMin),
                        ),
                        SizedBox(
                          height:
                              getMediaQueryHeight(context: context, value: 16),
                        ),
                        CustomFormField(
                          topContentPadding: 18,
                          bottomContentPadding: 18,
                          leftPadding: 8,
                          validator: validateId,
                          controller: controller.idController,
                          hint: "Enter your ID",
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
                        GetBuilder<LoginController>(
                          builder: (controller) {
                            return CustomFormField(
                              topContentPadding: 18,
                              bottomContentPadding: 18,
                              leftPadding: 8,
                              validator: validatePasswordLogin,
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
                              getMediaQueryHeight(context: context, value: 67),
                        ),
                        GetBuilder<LoginController>(
                          builder: (controller) {
                            if (controller.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              return CustomButton(
                                onPressed: () async {
                                  bool isFormValidated = controller
                                      .formKey.currentState!
                                      .validate();
                                  if (isFormValidated) {

                                    /// after signing in successfully
                                    await controller.login(
                                        id: controller.idController.text,
                                        password:
                                            controller.passwordController.text);
                                  }
                                },
                                text: 'Log In',
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
}
