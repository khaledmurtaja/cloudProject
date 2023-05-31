import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/data/models/trainings.dart';
import 'package:getx_architecture/core/utils/helperFunctions.dart';
import 'package:getx_architecture/core/values/roles.dart';

import '../../../routes/routes.dart';
import '../../data/models/user.dart';
import '../../data/services/sharedPrefService.dart';
import 'myCourses.dart';
import 'myStudents.dart';

class AdvisorController extends GetxController {
  bool isMyCoursesSelected = false;
  bool isMyStudentsSelected = false;
  bool gettingUserDataLoading = false;
  bool gettingTrainingsLoading = false;
  bool gettingStudentsLoading = false;
  List<Training> trainings = [];
  List<String> advisorCoursesIds = [];
  List<SystemUser> students = [];
  int currentPageIndex = 0;
  List<String> url=[];
  SystemUser? advisor;
  List<Widget> pages = [MyCourses(), MyStudents()];

  @override
  void onInit() async {
    await getCurrentUserData();
    await getUsersBySelectedTrainingIds();
  }

  logout() {
    final sharedPref = Get.find<AppSharedPref>();
    sharedPref.deleteValue(key: "Uid");
    sharedPref.deleteValue(key: "userrole");
    Get.rootDelegate.offNamed(Routes.LOGIN);
  }

  onMyCoursesSelected() {
    isMyCoursesSelected = true;
    isMyStudentsSelected = false;
    currentPageIndex = 0;
    update();
  }

  onMyStudentsSelected() {
    isMyCoursesSelected = false;
    isMyStudentsSelected = true;
    currentPageIndex = 1;
    update();
  }

  getCurrentUserData() async {
    try {
      gettingUserDataLoading = true;
      update();
      AppSharedPref appSharedPref = Get.find<AppSharedPref>();
      String? value = await appSharedPref.getStringValue(key: "Uid");
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('users').doc(value);
      DocumentSnapshot snapshot = await documentReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        advisor = SystemUser.fromJson(data);
        gettingUserDataLoading = false;
        await fetchTrainings();
        update();
      } else {
        return null;
      }
    } catch (e) {
      gettingUserDataLoading = false;
      update();
      showSnackBar(message: "check network connection");
    }
  }

  fetchTrainings() async {
    trainings = [];
    gettingTrainingsLoading = true;
    update();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('trainings')
        .where('advisorId', isEqualTo: advisor!.id)
        .get();
    gettingTrainingsLoading = false;
    update();

    if (querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> documents = querySnapshot.docs;
      for (var document in documents) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        advisorCoursesIds.add(document.id);
        // advisorCoursesIds.add(Training.fromJson(data).trainingId);
        trainings.add(Training.fromJson(data));
      }
      advisorCoursesIds.forEach((element) {
        print(element);
      });
    }
  }

  getUsersBySelectedTrainingIds() async {
    try {
      gettingStudentsLoading = false;
      update();
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot = await usersCollection
          .where('selected_training_ids', arrayContainsAny: advisorCoursesIds)
          .where('role', isEqualTo: Roles.trainee)
          .get();
      gettingStudentsLoading = false;
      update();

      List<DocumentSnapshot> userDocuments = querySnapshot.docs;
      for (var element in userDocuments) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        List<DocumentSnapshot> fileDocuments = await element.reference
            .collection('files')
            .get()
            .then((querySnapshot) => querySnapshot.docs);

        for (var file in fileDocuments) {
          Map<String, dynamic> fileData = file.data() as Map<String, dynamic>;
          // print(file.data());
          url.add(fileData['files'][0]['url']);
          print(url[0]);
        }
        students.add(SystemUser.fromJson(data));
        print(students[1].email);
      }
    } catch (e) {
      gettingStudentsLoading = false;
      update();
    }
  }
}
