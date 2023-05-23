import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:getx_architecture/App/modules/manegerHome/repository.dart';
import 'package:getx_architecture/App/modules/manegerHome/requestsPage.dart';
import 'package:getx_architecture/App/modules/manegerHome/statisticsPage.dart';
import 'package:getx_architecture/App/modules/manegerHome/trainessPage.dart';
import 'package:getx_architecture/core/utils/helperFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/core/values/enums.dart';
import 'package:getx_architecture/core/values/roles.dart';

import '../../data/models/attendanceDate.dart';
import '../../data/models/user.dart';
import 'advisorsPage.dart';
import 'coursesPage.dart';

class ManagerHomeController extends GetxController {
  QuerySnapshot? snapshot;
  bool isLoading = false;
  bool isStatisticsSelected = true;
  bool isCoursesSelected = false;
  bool isRequestsSelected = false;
  bool isTraineesSelected = false;
  bool isAdvisorsSelected = false;
  String courseCategory = "";
  int advisorCount = 0;
  int traineeCount = 0;
  final formKey = GlobalKey<FormState>();
  String selectedDay = "saturday";
  String advisorCountText = "";
  String traineeCountText = "";
  bool isAdvisorLoading = false;
  bool isTraineeLoading = false;
  int currentPageIndex = 0;
  String advisorName = "";
  String advisorId = "";
  String hoursFrom = "9";
  String minutesFrom = "00";
  String periodFrom = "AM";
  String hoursTo = "11";
  String minutesTo = "00";
  String periodTo = "AM";
  String imageName = "Choose Image";
  bool isPaidCourse = false;
  bool addingTrainingLoading = false;
  List<String> categories = [
    "DataBase",
    "Design",
    "FrontEnd",
    "BackEnd",
    "Mobile",
    "DevOps",
    "Security"
  ];
  List<String> advisors = [];
  bool isCreateCourseButtonPressed = false;
  List<AttendanceDate> attendanceDates = [];
  FilePickerResult? filePickerResult;
  String imgUrl = "";
  bool isEditing = false;
  CoursePaying payingValue = CoursePaying.free;
  List<SystemUser> listOfSystemUser = [];
  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Sunday'
  ];

  TextEditingController courseName = TextEditingController();
  TextEditingController courseDescription = TextEditingController();
  TextEditingController coursePrice = TextEditingController();
  List<Widget> pages = [
    StatisticsPage(),
    CoursesPage(),
    RequestsPage(),
    TraineePage(),
    AdvisorPage()
  ];

  final repo = Get.find<ManagerHomeRepository>();

  @override
  Future<void> onInit() async {
    await setAdvisorCount();
    await setCourseCount();
    await fetchUsersWithEmptyId();
    await getUsers(category: "FrontEnd", role: Roles.advisor);
    update();
  }

  Future<void> fetchUsersWithEmptyId() async {
    snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: '')
        .get();
    final List<QueryDocumentSnapshot<Object?>>? documents = snapshot?.docs;
    documents?.forEach((document) {
      // Do something with the document data
    });
  }

  getUsers({required String category, required String role}) async {
    try {
      advisors = [];
      courseCategory = category;
      final repo = Get.find<ManagerHomeRepository>();
      listOfSystemUser = await repo.getUsers(category: category, role: role);
      if (role == Roles.advisor) {
        for (var element in listOfSystemUser) {
          advisors.add(element.name);
        }
      }
      update();
    } catch (error) {
      print(error);
    }
  }

  updateIdField({required String uid, required String newId}) async {
    try {
      await repo.updateIdField(uid: uid, newId: newId);
      //back
    } catch (e) {
      showSnackBar(
          message: "failed to update user ID",
          snackPosition: SnackPosition.TOP);
    }
  }

  sendEmail(
      {required String name,
      required String email,
      required String message}) async {
    try {
      await repo.sendEmail(name: name, email: email, message: message);
      showSnackBar(message: "success");
    } catch (e) {
      showSnackBar(
          message: "failed to send email", snackPosition: SnackPosition.TOP);
    }
  }

  onStatisticsSelected() {
    isStatisticsSelected = true;
    isCoursesSelected = false;
    isRequestsSelected = false;
    isTraineesSelected = false;
    isAdvisorsSelected = false;
    currentPageIndex = 0;
    update();
  }

  onCoursesSelected() {
    isStatisticsSelected = false;
    isCoursesSelected = true;
    isRequestsSelected = false;
    isTraineesSelected = false;
    isAdvisorsSelected = false;
    currentPageIndex = 1;
    update();
  }

  onRequestsSelected() {
    isStatisticsSelected = false;
    isCoursesSelected = false;
    isRequestsSelected = true;
    isTraineesSelected = false;
    isAdvisorsSelected = false;
    currentPageIndex = 2;
    update();
  }

  onTraineesSelected() {
    isStatisticsSelected = false;
    isCoursesSelected = false;
    isRequestsSelected = false;
    isTraineesSelected = true;
    isAdvisorsSelected = false;
    currentPageIndex = 3;
    update();
  }

  onAdvisorSelected() {
    isStatisticsSelected = false;
    isCoursesSelected = false;
    isRequestsSelected = false;
    isTraineesSelected = false;
    isAdvisorsSelected = true;
    currentPageIndex = 4;
    update();
  }

  setAdvisorCount() async {
    try {
      final repo = Get.find<ManagerHomeRepository>();
      isAdvisorLoading = true;
      update();
      advisorCount = await repo.getAdvisorsNumber();
      isAdvisorLoading = false;
      advisorCountText = "$advisorCount";
      update();
    } catch (exception) {
      isAdvisorLoading = false;
      advisorCountText = "failed to get data";
      update();
      showSnackBar(message: "something went wrong,check internet connection");
    }
  }

  setCourseCount() async {
    try {
      final repo = Get.find<ManagerHomeRepository>();
      isTraineeLoading = true;
      update();
      traineeCount = await repo.getTraineesCount();
      isTraineeLoading = false;
      traineeCountText = "$traineeCount";
      update();
    } catch (exception) {
      isTraineeLoading = false;
      traineeCountText = "failed to get data";
      update();
      showSnackBar(message: "something went wrong,check internet connection");
    }
  }

  changeFromTime({required TimeOfDay fromTime}) {
    periodFrom = fromTime.hour < 12 ? "AM" : "PM";
    hoursFrom = fromTime.hourOfPeriod.toString();
    minutesFrom = fromTime.minute.toString();
    if (minutesFrom.length == 1) {
      minutesFrom = "0$minutesFrom";
    }
    update();
  }

  changeToTime({required TimeOfDay toTime}) {
    periodTo = toTime.hour < 12 ? "AM" : "PM";
    hoursTo = toTime.hourOfPeriod.toString();
    minutesTo = toTime.minute.toString();
    if (minutesTo.length == 1) {
      minutesTo = "0$minutesTo";
    }
    update();
  }

  changeEditMode() {
    isEditing = !isEditing;
    update();
  }

  changeSelectedDay({required String newValue}) {
    selectedDay = newValue;
    update();
  }

  addDate() {
    attendanceDates.add(AttendanceDate(
        day: selectedDay,
        startHour: "$hoursFrom:$minutesFrom$periodFrom",
        endHour: "$hoursTo:$minutesTo$periodTo"));
    changeEditMode();
  }

  pickFile() async {
    try {
      filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png','jpeg'],
      );
      imageName = filePickerResult!.files.first.name;
      update();
      return filePickerResult;
    } catch (error) {
      //handle error;
      print(error);
    }
  }

  updateAddCourseButtonStatues() {
    isCreateCourseButtonPressed = true;
    update();
  }

  updatePayingRadioButton({required value}) {
    if (value == CoursePaying.paid) {
      isPaidCourse = true;
    } else {
      isPaidCourse = false;
    }
    payingValue = value;
    print(isPaidCourse);
    update();
  }

  storeTrainingData() async {
    try {
      addingTrainingLoading = true;
      update();
      final repo = Get.find<ManagerHomeRepository>();
      await repo.storeTrainingData();
      addingTrainingLoading = false;
      update();
      showSnackBar(
          message: "Training has been added successfully",
          backGroundColor: Colors.green);
    } catch (error) {
      print(error);
      addingTrainingLoading = false;
      update();
      showSnackBar(message: "something went wrong");
    }
  }
  // Future<int > getAdvisorsNumber() async {
  //   QuerySnapshot<Map<String, dynamic>> snapshot =
  //       await FirebaseFirestore.instance.collection('users').get();
  //   for (var doc in snapshot.docs) {
  //     Map<String, dynamic>? data = doc.data();
  //     List<dynamic> roles = data['roles'];
  //
  //     if (roles.contains(Roles.advisor)) {
  //       advisorCount++;
  //     }
  //   }
  //
  //   return advisorCount;
  // }
}
