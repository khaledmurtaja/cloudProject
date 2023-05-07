class AttendanceDate {
  late String day;
  late String startHour;
  late String endHour;

  AttendanceDate({
    required this.day,
    required this.startHour,
    required this.endHour,
  });

  AttendanceDate.fromJson(Map<dynamic, dynamic> json) {
    day = json['day'];
    startHour = json['startHour'];
    endHour = json['endHour'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['day'] = day;
    data['startHour'] = startHour;
    data['endHour'] = endHour;

    return data;
  }
}
