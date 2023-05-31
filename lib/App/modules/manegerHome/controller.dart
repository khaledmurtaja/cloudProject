import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:getx_architecture/App/data/models/ad.dart';
import 'package:getx_architecture/App/modules/manegerHome/repository.dart';
import 'package:getx_architecture/App/modules/manegerHome/requestsPage.dart';
import 'package:getx_architecture/App/modules/manegerHome/statisticsPage.dart';
import 'package:getx_architecture/App/modules/manegerHome/trainessPage.dart';
import 'package:getx_architecture/core/utils/helperFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/core/values/enums.dart';
import 'package:getx_architecture/core/values/roles.dart';
import 'package:getx_architecture/routes/routes.dart';
import '../../data/models/attendanceDate.dart';
import 'package:getx_architecture/App/data/models/trainings.dart';
import '../../data/models/user.dart';
import '../../data/services/sharedPrefService.dart';
import 'advisorsPage.dart';
import 'bannerPage.dart';
import 'coursesPage.dart';

class ManagerHomeController extends GetxController {
  QuerySnapshot? usersWithNoIds;
  bool isLoading = false;
  bool isStatisticsSelected = true;
  bool isCoursesSelected = false;
  bool isRequestsSelected = false;
  bool isTraineesSelected = false;
  bool isAdvisorsSelected = false;
  bool isBannerSelected = false;
  String courseCategory = "";
  int advisorCount = 0;
  int traineeCount = 0;
  int courseCount = 0;
  int requestCount = 0;
  final formKey = GlobalKey<FormState>();
  final bannerFormKey = GlobalKey<FormState>();
  final updateBannerFormKey = GlobalKey<FormState>();
  String selectedDay = "saturday";
  String advisorCountText = "";
  String traineeCountText = "";
  String coursesCountText = "";
  String requestsCountText = "";
  bool isAdvisorLoading = false;
  bool isTraineeLoading = false;
  bool isCoursesLoading = false;
  bool isRequestsLoading = false;
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
  String bannerImageName = "Choose Image";
  List<Ad> banners = [];
  bool isPaidCourse = false;
  bool addingTrainingLoading = false;
  bool addingBannerLoading = false;
  bool updatingBannerLoading=false;
  bool gettingCoursesLoading=false;
  bool getTraineesLoading=false;
  bool isFetchingUsersWithEmptyIdLoading = false;
  bool isVerifying = false;
  String selectedUId = "";
  bool isGettingBannersLoading = false;
  int bannersLength=0;
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
  bool isCreateBannerButtonPressed = false;
  List<AttendanceDate> attendanceDates = [];
  FilePickerResult? filePickerResult;
  FilePickerResult? bannerFilePickerResult;
  String imgUrl = "";
  String bannerImageUrl = "";
  TextEditingController bannerName = TextEditingController();
  TextEditingController bannerUpdatedName = TextEditingController();
  bool isEditing = false;
  CoursePaying payingValue = CoursePaying.free;
  List<SystemUser> listOfSystemUser = [];
  List<SystemUser> usersWithEmptyIdList = [];
  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Sunday'
  ];
  List<Training> trainings=[];
  List<SystemUser> trainees=[];

  TextEditingController courseName = TextEditingController();
  TextEditingController courseDescription = TextEditingController();
  TextEditingController coursePrice = TextEditingController();
  List<Widget> pages = [
    StatisticsPage(),
    CoursesPage(),
    RequestsPage(),
    TraineesPage(),
    AdvisorPage(),
    BannerPage()
  ];

  final repo = Get.find<ManagerHomeRepository>();

  @override
  Future<void> onInit() async {
    try {
      await setAdvisorCount();
      await setTraineeCount();
      await setRequestsCount();
      await setCoursesCount();
      await fetchUsersWithEmptyId();
      await getBanners();
      await fetchTrainings();
      await fetchTrainees();
      await getUsers(category: "FrontEnd", role: Roles.advisor);
      update();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchUsersWithEmptyId() async {
    try {
      isFetchingUsersWithEmptyIdLoading = true;
      update();
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: '')
          .get();
      usersWithEmptyIdList = querySnapshot.docs
          .map((doc) => SystemUser.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      isFetchingUsersWithEmptyIdLoading = false;
      update();
    } catch (e) {
      isFetchingUsersWithEmptyIdLoading = false;
      update();
      showSnackBar(message: "check internet connection");
      print(e);
    }
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
          //getBanners
        }
      }
      update();
    } catch (error) {
      print(error);
    }
  }

  getBanners() async {
    try {
      banners = [];
      isGettingBannersLoading = true;
      update();
      final repo = Get.find<ManagerHomeRepository>();
      banners = await repo.getBanners();
      isGettingBannersLoading = false;
      update();
    } catch (error) {
      isGettingBannersLoading = false;
      update();
      print(error);
    }
  }

  updateIdField({required String uid, required String newId}) async {
    try {
      isVerifying = true;
      update();
      await repo.updateIdField(uid: uid, newId: newId);
      await fetchUsersWithEmptyId();
      update();
    } catch (e) {
      isVerifying = false;
      update();
      showSnackBar(
          message: "failed to update user ID,Check internet connection",
          snackPosition: SnackPosition.TOP);
    }
  }

  sendEmail(
      {required String name,
      required String email,
      required String message}) async {
    try {
      await repo.sendEmail(name: name, email: email, message: message);
      isVerifying = false;
      update();
      showSnackBar(
          title: "Success",
          message: "User Verified",
          backGroundColor: Colors.green);
    } catch (e) {
      isVerifying = false;
      update();
      showSnackBar(
          message: "failed to send email,check internet connection",
          snackPosition: SnackPosition.TOP);
    }
  }

  onStatisticsSelected() {
    isStatisticsSelected = true;
    isCoursesSelected = false;
    isRequestsSelected = false;
    isTraineesSelected = false;
    isAdvisorsSelected = false;
    isBannerSelected = false;
    currentPageIndex = 0;
    update();
  }

  onCoursesSelected() {
    isStatisticsSelected = false;
    isCoursesSelected = true;
    isRequestsSelected = false;
    isTraineesSelected = false;
    isAdvisorsSelected = false;
    isBannerSelected = false;
    currentPageIndex = 1;
    update();
  }

  onRequestsSelected() {
    isStatisticsSelected = false;
    isCoursesSelected = false;
    isRequestsSelected = true;
    isTraineesSelected = false;
    isAdvisorsSelected = false;
    isBannerSelected = false;
    currentPageIndex = 2;
    update();
  }

  onTraineesSelected() {
    isStatisticsSelected = false;
    isCoursesSelected = false;
    isRequestsSelected = false;
    isTraineesSelected = true;
    isAdvisorsSelected = false;
    isBannerSelected = false;
    currentPageIndex = 3;
    update();
  }

  onAdvisorSelected() {
    isStatisticsSelected = false;
    isCoursesSelected = false;
    isRequestsSelected = false;
    isTraineesSelected = false;
    isAdvisorsSelected = true;
    isBannerSelected=false;
    currentPageIndex = 4;
    update();
  }

  onBannerSelected() {
    isStatisticsSelected = false;
    isCoursesSelected = false;
    isRequestsSelected = false;
    isTraineesSelected = false;
    isAdvisorsSelected = false;
    isBannerSelected = true;
    currentPageIndex = 5;
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

  setTraineeCount() async {
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

  setCoursesCount() async {
    try {
      final repo = Get.find<ManagerHomeRepository>();
      isCoursesLoading = true;
      update();
      courseCount = await repo.getCoursesCount();
      isCoursesLoading = false;
      coursesCountText = "$courseCount";
      update();
    } catch (exception) {
      isCoursesLoading = false;
      coursesCountText = "failed to get data";
      update();
      showSnackBar(message: "something went wrong,check internet connection");
    }
  }

  setRequestsCount() async {
    try {
      final repo = Get.find<ManagerHomeRepository>();
      isRequestsLoading = true;
      update();
      requestCount = await repo.getRequestsCount();
      isRequestsLoading = false;
      requestsCountText = "$requestCount";
      update();
    } catch (exception) {
      isRequestsLoading = false;
      requestsCountText = "failed to get data";
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
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );
      imageName = filePickerResult!.files.first.name;
      update();
      return filePickerResult;
    } catch (error) {
      //handle error;
      print(error);
    }
  }

  pickBannerFile() async {
    try {
      bannerFilePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );
      bannerImageName = bannerFilePickerResult!.files.first.name;
      update();
      return bannerFilePickerResult;
    } catch (error) {
      //handle error;
      print(error);
    }
  }

  updateAddCourseButtonStatues() {
    isCreateCourseButtonPressed = true;
    update();
  }

  updateAddBannerButtonStatues() {
    isCreateBannerButtonPressed = true;
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
          title: "success",
          message: "Training has been added successfully",
          backGroundColor: Colors.green);
    } catch (error) {
      print(error);
      addingTrainingLoading = false;
      update();
      showSnackBar(message: "something went wrong");
    }
  }

  storeBannerData() async {
    try {
      addingBannerLoading = true;
      update();
      final repo = Get.find<ManagerHomeRepository>();
      await repo.storeBannerData();
      addingBannerLoading = false;
      update();
      Get.back();
      await Future.delayed(const Duration(milliseconds: 100));
      showSnackBar(
          title: "success",
          message: "Banner has been added successfully",
          backGroundColor: Colors.green);
    } catch (error) {
      print(error);
      addingBannerLoading = false;
      update();
      showSnackBar(message: "something went wrong");
    }
  }
  updateBannerData({required int index}) async {
    try {
      updatingBannerLoading = true;
      update();
      final repo = Get.find<ManagerHomeRepository>();
      await repo.updateBannerData(index: index);
      updatingBannerLoading = false;
      update();
      showSnackBar(
          title: "success",
          message: "Banner has been Updated successfully",
          backGroundColor: Colors.green);
    } catch (error) {
      print(error);
      updatingBannerLoading = false;
      update();
      showSnackBar(message: "something went wrong");
    }
  }
  fetchTrainings() async {
    //getTraineesLoading
    try {
      gettingCoursesLoading = true;
      update();
      final repo = Get.find<ManagerHomeRepository>();
      await repo.fetchTrainings();
      gettingCoursesLoading = false;
    }catch(e){
      gettingCoursesLoading=false;
      update();
      showSnackBar(message: "something went wrong");
    }

  }
  fetchTrainees() async {
    //
    try {
      getTraineesLoading = true;
      update();
      final repo = Get.find<ManagerHomeRepository>();
      await repo.fetchTrainees();
      getTraineesLoading = false;
    }catch(e){
      getTraineesLoading=false;
      update();
      showSnackBar(message: "something went wrong");
    }

  }

  logout(){
    final sharedPref = Get.find<AppSharedPref>();
    sharedPref.deleteValue(key: "Uid");
    sharedPref.deleteValue(key: "userrole");
    Get.rootDelegate.offNamed(Routes.LOGIN);

  }
}
