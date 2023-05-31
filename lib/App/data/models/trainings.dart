import 'attendanceDate.dart';

class Training {
  late String trainingName;
  late String trainingId;
  late String category;
  late String description;
  late String advisorId;
  late String advisorName;
  late String courseImageUrl;
  late bool isPaidCourse;
  late String price;
  late List<AttendanceDate> dates;

  Training({
    required this.trainingName,
    required this.category,
    required this.description,
    required this.trainingId,
    required this.dates,
    required this.advisorId,
    required this.advisorName,
    required this.courseImageUrl,
    required this.price,
    required this.isPaidCourse
  });

  Training.fromJson(Map<String, dynamic> json) {
    trainingName = json['trainingName'];
    trainingId=json['trainingId'];
    category = json['category'];
    description = json['description'];
    dates = (json['dates'] as List<dynamic>).map((date) => AttendanceDate.fromJson(date)).toList();
    advisorId=json['advisorId'];
    advisorName=json['advisorName'];
    courseImageUrl=json['courseImageUrl'];
    isPaidCourse=json['isPaidCourse'];
    price=json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    List<Map<String, String>> dateList = [];
    data['trainingName'] = trainingName;
    data['category'] = category;
    data['description'] = description;
    data['advisorId']=advisorId;
    data['advisorName']=advisorName;
    data['courseImageUrl']=courseImageUrl;
    data['isPaidCourse']=isPaidCourse;
    data['price']=price;
    data['trainingId']=trainingId;
    for (var element in dates) {
      dateList.add(element.toJson());
    }
    data['dates']=dateList;

    return data;
  }
}
