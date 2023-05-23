import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/routes/pages.dart';

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
  Get.lazyPut<CollectionReference>(() =>
      FirebaseFirestore.instance.collection(FireBaseConsts.collectionName));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          initialRoute: "/login",
          // textDirection: TextDirection.rtl,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          getPages: AppPages.pages,
        );
      },
    );
  }
}

// 1682876656937000
// flutter run -d chrome --web-renderer html
// flutter run -d edge --web-renderer html

