



import 'employee_info.dart';
import 'exam_model.dart';


class ClassSubject {
  int id;
  Subject2 subject;
  ClassSection? classSection;
  EmployeeData2 teacher;

  ClassSubject({
    required this.id,
    required this.subject,
    required this.classSection,
    required this.teacher,
  });

  factory ClassSubject.fromJson(Map<String, dynamic> json) {
    return ClassSubject(
      id: json['id'],
      subject: Subject2.fromJson(json['subject']),
      classSection: ClassSection.fromJson(json['class_section']),
      teacher: EmployeeData2.fromJson(json['teacher']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject.toJson(),
      'class_section': classSection?.toJson(),
      'teacher': teacher.toJson(),
    };
  }

}


class ClassSecSubject {
  final int id;
  final Subject subject;


  ClassSecSubject({
    required this.id,
    required this.subject,
  });

  factory ClassSecSubject.fromJson(Map<String, dynamic> json) {
    return ClassSecSubject(
      id: json['id'],
      subject: Subject.fromJson(json['subject']),
    );
  }


  @override
  String toString() {
    // TODO: implement toString
    return subject.subjectName;
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

  factory Subject.empty(){
    return Subject(
        id: 0,
        subjectName: ''
    );
  }

}


class ClassSection {
  int id;
  Sections sectionName;
  ClassName className;
  EmployeeData2 classTeacher;

  ClassSection({required this.id, required this.sectionName, required this.className, required this.classTeacher});

  factory ClassSection.fromJson(Map<String, dynamic> json) {
    return ClassSection(
      id: json['id'],
      sectionName: Sections.fromJson(json['section']),
      className: ClassName.fromJson(json['class_name']),
      classTeacher: EmployeeData2.fromJson(json['is_class_teacher']),
    );
  }
  factory ClassSection.empty() {
    return ClassSection(id: 0, sectionName: Sections.empty(), className: ClassName.empty(), classTeacher: EmployeeData2.empty());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'section_name': sectionName.toJson(),
      'class_name': className.toJson(),
      'class_teacher': classTeacher.toJson(),
    };
  }

}

class Sections {
  int id;
  String sectionName;
  String status;
  String createdAt;
  String updatedAt;

  Sections({
    required this.id,
    required this.sectionName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sections.fromJson(Map<String, dynamic> json) => Sections(
    id: json['id'],
    sectionName: json['section_name'],
    status: json['status'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );

  factory Sections.empty() => Sections(
    id: 0,
    sectionName:'',
    status: '',
    createdAt:'',
    updatedAt: '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'section_name': sectionName,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}



class ClassName {
  int id;
  ClassBatch batchName;

  ClassLevel classLevel;


  ClassName({required this.id, required this.batchName, required this.classLevel});

  factory ClassName.fromJson(Map<String, dynamic> json) {
    return ClassName(
      id: json['id'],
      batchName: ClassBatch.fromJson(json['batch']),
      classLevel: ClassLevel.fromJson(json['class_level']),

    );
  }
  factory ClassName.empty() {
    return ClassName(id: 0, batchName: ClassBatch.empty(), classLevel: ClassLevel.empty(),);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'batch': batchName.toJson(),
      'class_level': classLevel.toJson(),
    };
  }




}

class ClassBatch {
  int id;
  String batchName;

  ClassBatch({
    required this.id,
    required this.batchName,
  });

  factory ClassBatch.fromJson(Map<String, dynamic> json) {
    return ClassBatch(
      id: json['id'],
      batchName: json['batch_name'],
    );
  }

  factory ClassBatch.empty(){
    return ClassBatch(id: 0, batchName: '', );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'batch_name': batchName,
    };
  }

}

class ClassLevel {
  int id;
  String name;
  String status;
  bool isBachelorsClass;

  ClassLevel({
    required this.id,
    required this.name,
    required this.status,
    required this.isBachelorsClass,
  });

  factory ClassLevel.fromJson(Map<String, dynamic> json) {
    return ClassLevel(
      id: json['id'],
      name: json['class_name'],
      status: json['status'],
      isBachelorsClass: json['is_bachelors_class'],
    );
  }

  factory ClassLevel.empty(){
    return ClassLevel(id: 0, name: '', status: '', isBachelorsClass: false,);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'class_name': name,
      'status': status,
      'isBachelorsClass': isBachelorsClass,
    };
  }

}


class ClassWiseStudent {
  final String studentId;
  final String studentName;
  final String? studentPhoto;
  final int rollNo;

  ClassWiseStudent({
    required this.studentId,
    required this.studentName,
    required this.studentPhoto,
    required this.rollNo,
  });

  factory ClassWiseStudent.fromJson(Map<String, dynamic> json) {
    return ClassWiseStudent(
      studentId: json['student_id'],
      studentName: json['student_name'],
      studentPhoto: json['student_photo']??null,
      rollNo: json['roll_no'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'student_name': studentName,
      'student_photo':studentPhoto,
      'roll_no': rollNo,
    };
  }
}

