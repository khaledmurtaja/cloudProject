import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import 'controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'TutorialKart',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'name',
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: controller.passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              GetBuilder<RegisterController>(
                builder: (controller) {
                  return DropdownButton<String>(
                    value: controller.selectedRoleValue,
                    onChanged: (newValue) {
                      controller.changeRoleFiled(role: newValue!);
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'trainee',
                        child: Text('trainee'),
                      ),
                      DropdownMenuItem(
                        value: 'advisor',
                        child: Text('advisor'),
                      ),
                    ],
                  );
                },
              ),
              GetBuilder<RegisterController>(
                builder: (controller) {
                  return DropdownButton<String>(
                    value: controller.selectedProfessionValue,
                    onChanged: (newValue) {
                      controller.changeProfessionFiled(value: newValue!);
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'mobile development',
                        child: Text('Mobile Development'),
                      ),
                      DropdownMenuItem(
                        value: 'web development',
                        child: Text('Web Development'),
                      ),
                      DropdownMenuItem(
                        value: 'ui_ux',
                        child: Text('UI/UX'),
                      ),
                    ],
                  );
                },
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('choose supporting document'),
                    onPressed: () async {
                      await controller.pickFile();
                    },
                  )),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Forgot Password',
                ),
              ),
              GetBuilder<RegisterController>(
                builder: (controller) {
                  if (!controller.isLoading) {
                    return Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text('register'),
                          onPressed: () async {
                            await controller.registerUser(
                                email: controller.emailController.text,
                                password: controller.passwordController.text);
                            Get.toNamed(Routes.REVIEW);
                          },
                        ));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('have an account'),
                  TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.LOGIN);
                      //signup screen
                    },
                  )
                ],
              ),
            ],
          )),
    );
  }
}
