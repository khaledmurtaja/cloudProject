import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviewing your request"),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
             const Text(
                "we are reviewing your request,if it suits as an id will be sent to your email\nyou have to use it to login \n to the system"),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('back to login'),
                onPressed: () {
                  Get.toNamed("/login");
                },
              ))
          ],
        ),
      ),
    );
  }
}
