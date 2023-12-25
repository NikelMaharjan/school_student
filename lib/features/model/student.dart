import 'class_model.dart';

class Student {
  final int id;
  final String studentName;
  final String gender;
  final String residentalAddress;
  final String nationality;
  final int mobileNumber;
  final int homeTel;
  final String email;
  final String dateOfBirthEng;
  final String dateOfBirthNep;
  final int age;
  final String religion;
  final String fatherName;
  final String motherName;
  final int fatherPhoneNumber;
  final int motherPhoneNumber;
  final String? guardianName;
  final String? guardianRelation;
  final String? studentPhoto;
  final bool? systemUser;




  Student({
    required this.id,
    required this.studentName,
    required this.gender,
    required this.residentalAddress,
    required this.nationality,
    required this.mobileNumber,
    required this.homeTel,
    required this.email,
    required this.dateOfBirthEng,
    required this.dateOfBirthNep,
    required this.age,
    required this.religion,
    required this.fatherName,
    required this.motherName,
    required this.fatherPhoneNumber,
    required this.motherPhoneNumber,
    required this.guardianName,
    required this.guardianRelation,
    required this.studentPhoto,
    required this.systemUser,

  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? '',
      studentName: json['student_name'] ?? '',
      gender: json['gender'] ?? '',
      residentalAddress: json['residental_address'] ?? '',
      nationality: json['nationality'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      homeTel: json['home_tel'] ?? '',
      email: json['email'] ?? '',
      dateOfBirthEng: json['date_of_birth_eng'] ?? '',
      dateOfBirthNep: json['date_of_birth_nep'] ?? '',
      age: json['age'] ?? '',
      religion: json['religion'] ?? '',
      fatherName: json['father_name'] ?? '',
      motherName: json['mother_name'] ?? '',
      fatherPhoneNumber: json['father_phone_number'] ?? '',
      motherPhoneNumber: json['mother_phone_number'] ?? '',
      guardianName: json['guardian_name'] ?? '',
      guardianRelation: json['guardian_relation'] ?? '',
      studentPhoto: json['student_photo'] ?? '',
      systemUser: json['create_system_user'] ?? '',


    );
  }

}


class Student2 {
  final int id;
  final String studentName;
  final String? studentPhoto;



  Student2({
    required this.id,
    required this.studentName,
    required this.studentPhoto,


  });

  factory Student2.fromJson(Map<String, dynamic> json) {
    return Student2(
      id: json['id'] ?? '',
      studentName: json['student_name'] ?? '',
      studentPhoto: json['student_photo'] ?? null,

    );
  }

}

