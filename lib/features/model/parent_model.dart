import 'package:eschool/features/model/student.dart';

class ParentDetail {
  int id;
  String parentName;
  String currentAddress;
  String permanentAddress;
  int  mobileNo;
  String email;
  String picture;
  String gender;
  String occupation;
  String education;
  String nationality;
  String maritalStatus;
  String relationshipToStudent;

  ParentDetail({
    required this.id,
    required this.parentName,
    required this.currentAddress,
    required this.permanentAddress,
    required this.mobileNo,
    required this.email,
    required this.picture,
    required this.gender,
    required this.occupation,
    required this.education,
    required this.nationality,
    required this.maritalStatus,
    required this.relationshipToStudent,
  });

  factory ParentDetail.fromJson(Map<String, dynamic> json) {
    return ParentDetail(
      id: json['id'],
      parentName: json['parent_name'],
      currentAddress: json['current_address'],
      permanentAddress: json['permanent_address'],
      mobileNo: json['mobile_no'],
      email: json['email'],
      picture: json['parent_photo'],
      gender: json['gender'],
      occupation: json['occupation'],
      education: json['education'],
      nationality: json['nationality'],
      maritalStatus: json['marital_status'],
      relationshipToStudent: json['relation'],
    );
  }
}



class ParentDetail2 {
  int id;
  String parentName;
  String relationshipToStudent;

  ParentDetail2({
    required this.id,
    required this.parentName,
    required this.relationshipToStudent,
  });

  factory ParentDetail2.fromJson(Map<String, dynamic> json) {
    return ParentDetail2(
      id: json['id'],
      parentName: json['parent_name'],
      relationshipToStudent: json['relation'],
    );
  }
}



class ParentStudent {
  int id;
  String createdAt;
  String updatedAt;
  ParentDetail2 parent;
  Student2 student;

  ParentStudent({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.parent,
    required this.student,
  });

  factory ParentStudent.fromJson(Map<String, dynamic> json) {
    return ParentStudent(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      parent: ParentDetail2.fromJson(json['parent']),
      student: Student2.fromJson(json['student']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'parent': parent,
    'student': student,
  };
}

