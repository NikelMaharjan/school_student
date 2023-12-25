import 'package:eschool/features/model/class_model.dart';

class RoutineData {
  int id;
  String day;
  String startTime;
  String endTime;
  ClassSecSubject classSubject;


  RoutineData({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.classSubject,

  });

  factory RoutineData.fromJson(Map<String, dynamic> json) => RoutineData(
    id: json['id'],
    day: json['day'],
    startTime: json['start_time'],
    endTime: json['end_time'],
    classSubject:ClassSecSubject.fromJson(json['class_subject']),
  );


}
