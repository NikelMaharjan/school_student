import 'class_model.dart';
import 'exam_model.dart';

class NoticeData {
  final int id;
  final String title;
  final String description;
  final String? image;
  final bool forAllClass;
  final bool sendNotification;
  final String createdAt;
  final String updatedAt;

  NoticeData({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.forAllClass,
    required this.sendNotification,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NoticeData.fromJson(Map<String, dynamic> json) {
    return NoticeData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image']??null,
      forAllClass: json['for_all_class'],
      sendNotification: json['send_notification'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}



class ClassNotice {
  final int id;
  final String createdAt;
  final String updatedAt;
  final ClassSection? className;
  final NoticeData notice;
  ClassNotice({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.className,
    required this.notice,
  });

  factory ClassNotice.fromJson(Map<String, dynamic> json) {
    return ClassNotice(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      className: json['class_section']==null?ClassSection.fromJson(json['class_section']):null,
      notice: NoticeData.fromJson(json['notice']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'class_name': className,
      'notice': notice,
    };
  }
}

class SubjectName{

  final int id;
  final Subject2 subjectName;

  SubjectName({
    required this.subjectName,
    required this.id
  });

  factory SubjectName.fromJson(Map<String, dynamic> json) {
    return SubjectName(
      id: json['id'],
      subjectName: Subject2.fromJson(json['status']),

    );
  }


}


class SubjectNotice {
  final int id;
  final String title;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ClassSubject? subjectName;

  SubjectNotice({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    this.subjectName,
  });

  factory SubjectNotice.fromJson(Map<String, dynamic> json) {
    return SubjectNotice(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      subjectName: json['class_subject'] != null ? ClassSubject.fromJson(json['class_subject']) : null,
    );
  }


}
