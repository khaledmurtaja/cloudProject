import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../data/models/training.dart';
import '../../data/models/user.dart';

class TrainingDetaileBeforeRecordingController extends GetxController {
  dynamic argumentData = Get.rootDelegate;
  Training? training;

  SystemUser? advisor;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxBool isLoading = true.obs;

  @override
  void onInit() async {
    training = await argumentData.arguments()['trainingObject'] as Training;
    print(training);
    await fetchUser();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> fetchUser() async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('users')
          .where('id', isEqualTo: training!.advisorId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot userSnapshot = snapshot.docs.first;
        Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
        advisor = SystemUser(
            name: data['name'],
            role: '',
            email: data['email'],
            field: data['field'],
            id: "",
            uid: '',
            balance: '',
            selectedTrainingIds: [],
            userImgUrl: '');
      } else {
        advisor = null;
      }
      update();
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}
