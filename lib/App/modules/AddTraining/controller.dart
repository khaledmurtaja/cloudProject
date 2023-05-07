import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/AddTraining/repository.dart';
import 'package:getx_architecture/core/utils/helperFunctions.dart';
import '../../data/models/attendanceDate.dart';

class AddTrainingScreenController extends GetxController {
  TextEditingController trainingName = TextEditingController();
  TextEditingController trainingDescription = TextEditingController();
  String selectedCategory = "Mobile development";
  String selectedDay = "saturday";
  List<AttendanceDate> attendanceDates = [];
  String hoursFrom = "9";
  String minutesFrom = "00";
  String periodFrom = "AM";
  String hoursTo = "11";
  String minutesTo = "00";
  String periodTo = "AM";
  bool isEditing = false;
  bool isLoading=false;

  changeSelectedCategory({required String newValue}) {
    selectedCategory = newValue;
    update();
  }

  changeSelectedDay({required String newValue}) {
    selectedDay = newValue;
    update();
  }

  changeFormTime({required TimeOfDay fromTime}) {
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

  addDate() {
    attendanceDates.add(AttendanceDate(
        day: selectedDay, startHour: "$hoursFrom:$minutesFrom$periodFrom", endHour: "$hoursTo:$minutesTo$periodTo"));
    changeEditMode();
  }
  addTraining() async {
    try {
      isLoading=true;
      update();
      final repo = Get.find<AddTrainingRepository>();
      await repo.addNewTraining();
      isLoading=false;
      update();
      showSnackBar(message: "New training has been added successfully",backGroundColor: Colors.green);
    }catch(exception){
      isLoading=false;
      update();
      showSnackBar(message: "failed to add new training",);
    }
  }
}
