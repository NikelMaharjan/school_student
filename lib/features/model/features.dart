

import 'package:eschool/features/model/class_model.dart';
import 'package:eschool/features/model/student.dart';

class StudentClass{
  final int id;
  final Student2 student;
  final ClassSection? className;
  final int rollNo;
  final bool currentLevel;

  StudentClass({
    required this.className,
    required this.id,
    required this.student,
    required this.rollNo,
    required this.currentLevel
});

  factory StudentClass.fromJson(Map<String, dynamic> json) {
    return StudentClass(
      id: json['id'],
      student: Student2.fromJson(json['student']),
      className: json['class_section'] != null ? ClassSection.fromJson(json['class_section']):null,
      rollNo: json['roll_no'],
      currentLevel: json['current_level'],
    );
  }

}