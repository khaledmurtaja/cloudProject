import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/routes/pages.dart';
import 'package:getx_architecture/routes/routes.dart';

import 'App/data/services/sharedPrefService.dart';
import 'core/values/firebase_consts.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initServices();

  runApp(MyApp());
}

initServices() {
  Get.lazyPut<CollectionReference>(
      () =>
          FirebaseFirestore.instance.collection(FireBaseConsts.userCollection),
      tag: "users");
  Get.lazyPut<CollectionReference>(
      () => FirebaseFirestore.instance
          .collection(FireBaseConsts.trainingCollection),
      tag: "trainings");
  Get.lazyPut<AppSharedPref>(
    () => AppSharedPref().init(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Tajawal"),
          getPages: AppPages.pages,
        );
      },
    );
  }
}

// 1682876656937000
// flutter run -d chrome --web-renderer html
// flutter run -d edge --web-renderer html

