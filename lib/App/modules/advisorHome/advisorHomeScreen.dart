import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvisorHomesScreen extends StatelessWidget {
  const AdvisorHomesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("advisor"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Get.toNamed("/advisorTrainees");
          },
          child: Text('Go To AdvisorTraineesScreen '),
        ),
      ),
    );
  }
}
