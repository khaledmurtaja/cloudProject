import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../data/models/training.dart';

class TraineeLearninController extends GetxController {
  dynamic argumentData = Get.rootDelegate;
  final RxList<Training> myLearnings = <Training>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() async {
    String uid = await argumentData.arguments()['uId'];
    await fetchUserTrainings(uid);
    isLoading.value = false;

    super.onInit();
  }

  Future<void> fetchUserTrainings(String userId) async {
    final userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;

    final selectedTrainingIds =
        List<String>.from(data['selected_training_ids']);
    final trainingsSnapshot = await FirebaseFirestore.instance
        .collection('trainings')
        .where(FieldPath.documentId, whereIn: selectedTrainingIds)
        .get();

    final trainings = await Future.wait(trainingsSnapshot.docs.map((doc) async {
      final data = doc.data();
      final advisorImgUrl = await getUserImageUrl(data['advisorId']);
      return Training(
        id: doc.id,
        name: data['trainingName'],
        description: data['description'],
        advisorId: '',
        advisorName: data['advisorName'],
        category: '',
        dates: [],
        imageUrl: data['courseImageUrl'],
        isPaidCourse: false,
        price: 50,
        advisorImgUrl: advisorImgUrl,
      );
    }));
    myLearnings.assignAll(trainings);
  }

  int generateRandomNumber() {
    final random = Random();
    return random.nextInt(101);
  }

  double calculatePercentage(int number) {
    return number / 100;
  }

  Future<String> getUserImageUrl(String id) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          snapshot.docs.first;
      Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;

      final userImgUrl = data['userImgUrl'] as String;
      return userImgUrl;
    } else {
      return '';
    }
  }
}
