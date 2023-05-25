import 'package:get/get.dart';

class AllTrainingsController extends GetxController {
  dynamic argumentData = Get.rootDelegate;
  String trainingType = '';
  final RxBool isLoading = true.obs;

  @override
  void onInit() async {
    trainingType = await argumentData.arguments()['trainingType'];
    // print(trainingType);
    isLoading.value = false;

    super.onInit();
  }
/*
  @override
  void onClose() {
    print('gfhfhfgh');

    Get.delete<AllTrainingsController>();

    super.onClose();
  }

  @override
  void dispose() {
    print('gfhfhfgh');
    Get.delete<AllTrainingsController>();
    super.dispose();
  }

  */
}
