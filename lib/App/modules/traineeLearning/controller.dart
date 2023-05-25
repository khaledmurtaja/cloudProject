import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../data/models/training.dart';

class TraineeLearninController extends GetxController {
  dynamic argumentData = Get.rootDelegate;
  final RxList<Training> myLearnings = <Training>[].obs;
  @override
  void onInit() async {
    String uid = await argumentData.arguments()['uId'];
    fetchUserTrainings(uid);
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

    final trainings = trainingsSnapshot.docs.map((doc) {
      final data = doc.data();
      return Training(
        id: doc.id,
        name: data['trainingName'],
        description: data['description'],
        advisorId: '',
        advisorName: '',
        category: '',
        dates: [],
        imageUrl: '',
        isPaidCourse: false,
        price: 50,
      );
    }).toList();
    myLearnings.assignAll(trainings);
  }
}
