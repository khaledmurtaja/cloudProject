import 'attendanceDate.dart';

class Training {
  late String trainingName;
  late String category;
  late String description;
  late List<AttendanceDate> dates;

  Training({
    required this.trainingName,
    required this.category,
    required this.description,
    required this.dates
  });

  Training.fromJson(Map<dynamic, dynamic> json) {
    trainingName = json['name'];
    category = json['category'];
    description = json['description'];
    dates=json['dates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    List<Map<String, String>> dateList = [];
    data['trainingName'] = trainingName;
    data['category'] = category;
    data['description'] = description;
    for (var element in dates) {
      dateList.add(element.toJson());
    }
    data['dates']=dateList;

    return data;
  }
}
