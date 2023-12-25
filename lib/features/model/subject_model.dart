
import 'class_model.dart';
import 'exam_model.dart';

class SubjectPlan {
  int id;
//  ClassSubject? subject;
  String teachingDuration;
  String description;
  String expectedOutcome;

  SubjectPlan({
    required this.id,
  //  required this.subject,
    required this.teachingDuration,
    required this.description,
    required this.expectedOutcome,
  });

  factory SubjectPlan.fromJson(Map<String, dynamic> json) {
    return SubjectPlan(
      id: json['id'],
     // subject: json['subject'] == null ? null : ClassSubject.fromJson(json['subject']),
      teachingDuration: json['teaching_duration'],
      description: json['description'],
      expectedOutcome: json['expected_outcome'],
    );
  }

}

class SubjectDetails {
  int id;
  Subject2 subject;

  SubjectDetails({
    required this.id,
    required this.subject,
  });

  factory SubjectDetails.fromJson(Map<String, dynamic> json) {
    return SubjectDetails(
      id: json['id'],
      subject: Subject2.fromJson(json['subject']),
    );
  }


}

class Subject {
  int id;
  String subjectName;

  Subject({
    required this.id,
    required this.subjectName,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      subjectName: json['subject_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'subject_name': subjectName,
  };
}
