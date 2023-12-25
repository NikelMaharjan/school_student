//a profile for a schoolcollege using the system, every data of a schoolcollege revolves around this model.
class School {
  final int id;
  final String name;
  final String shortName;
  final String logo;
  final String schoolType;
  final String coverPhoto;
  final DateTime establishedDate;
  final String principalName;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  School({
    required this.id,
    required this.name,
    required this.shortName,
    required this.logo,
    required this.schoolType,
    required this.coverPhoto,
    required this.establishedDate,
    required this.principalName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      name: json['name'],
      shortName: json['short_name'],
      logo: json['logo'],
      schoolType: json['school_type'],
      coverPhoto: json['cover_photo'],
      establishedDate: DateTime.parse(json['established_date']),
      principalName: json['principal_name'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'short_name': shortName,
      'logo': logo,
      'school_type': schoolType,
      'cover_photo': coverPhoto,
      'established_date': establishedDate.toIso8601String(),
      'principal_name': principalName,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

//Batch model defines batch in a schoolcollege
class Batch {
  int id;
  String batchName;
  String createdAt;
  String updatedAt;
  int school;

  Batch({
    required this.id,
    required this.batchName,
    required this.createdAt,
    required this.updatedAt,
    required this.school,
  });

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
      id: json['id'],
      batchName: json['batch_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      school: json['school'],
    );
  }
}

//Year defines year(1st semester, 1st year) in a schoolcollege
class Semester {
  final int id;
  final String yearName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int school;

  Semester({
    required this.id,
    required this.yearName,
    required this.createdAt,
    required this.updatedAt,
    required this.school,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      id: json['id'],
      yearName: json['year_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      school: json['school'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'year_name': yearName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'school': school,
    };
  }
}

//ClassLevel defines class levels in the schoolcollege (BBA , Class1, BBS e.t.c)
class MyClass {
  int id;
  String className;
  String status;
  bool isBachelorsClass;
  DateTime createdAt;
  DateTime updatedAt;
  int schoolCollege;

  MyClass({
    required this.id,
    required this.className,
    required this.status,
    required this.isBachelorsClass,
    required this.createdAt,
    required this.updatedAt,
    required this.schoolCollege,
  });

  factory MyClass.fromJson(Map<String, dynamic> json) {
    return MyClass(
      id: json['id'],
      className: json['class_name'],
      status: json['status'],
      isBachelorsClass: json['is_bachelors_class'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      schoolCollege: json['school_college'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'class_name': className,
      'status': status,
      'is_bachelors_class': isBachelorsClass,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'school_college': schoolCollege,
    };
  }
}

//Class defines class with class level, batch and year (2079 BBS 1st semester)
class ClassInfo {
  int id;
  int batch;
  int? year; // Change type to String
  int classLevel;
  int schoolCollege;

  ClassInfo({
    required this.id,
    required this.batch,
    this.year,
    required this.classLevel,
    required this.schoolCollege,
  });

  factory ClassInfo.fromJson(Map<String, dynamic> json) {
    return ClassInfo(
      id: json['id'] ?? 0,
      batch: json['batch'] ?? 0,
      year: json['year'],
      // Cast to String
      classLevel: json['class_level'] ?? 0,
      schoolCollege: json['school_college'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['batch'] = this.batch;
    data['year'] = this.year; // Don't need to convert to string
    data['class_level'] = this.classLevel;
    data['school_college'] = this.schoolCollege;
    return data;
  }
}

//Section defines all the sections available in the schoolcollege (A, B , C)


//ClassSection defines sections in a class. (2079 BBS 1st semestar A)
class ClassSection {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int section;
  final int className;
  final int schoolCollege;
  final int classTeacher;

  ClassSection({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.section,
    required this.className,
    required this.schoolCollege,
    required this.classTeacher
  });

  factory ClassSection.fromJson(Map<String, dynamic> json) {
    return ClassSection(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      section: json['section'],
      className: json['class_name'],
      schoolCollege: json['school_college'],
      classTeacher: json['is_class_teacher']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'section': section,
      'class_name': className,
      'school_college': schoolCollege,
      'is_class_teacher': classTeacher
    };
  }
}

//Subject defines subject in a school college
class Subject {
  final int id;
  final String subjectName;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int schoolCollege;

  Subject({
    required this.id,
    required this.subjectName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.schoolCollege,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      subjectName: json['subject_name'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      schoolCollege: json['school_college'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject_name': subjectName,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'school_college': schoolCollege,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return subjectName;
  }

}

//ClassSubject defines subject taught in a class (2079 BBS 1st semester Accountancy)
class ClassSubject {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int subject;
  int classSection;
  dynamic teacher;

  ClassSubject({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.subject,
    required this.classSection,
    required this.teacher,
  });

  factory ClassSubject.fromJson(Map<String, dynamic> json) {
    return ClassSubject(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      subject: json['subject'],
      classSection: json['class_section'],
      teacher: json['teacher'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt.toIso8601String();
    data['updated_at'] = this.updatedAt.toIso8601String();
    data['subject'] = this.subject;
    data['class_section'] = this.classSection;
    data['teacher'] = this.teacher;
    return data;
  }
}




class Courses {
  int id;
  String courseName;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int schoolCollege;

  Courses({
    required this.id,
    required this.courseName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.schoolCollege,
  });

  factory Courses.fromJson(Map<String, dynamic> json) {
    return Courses(
      id: json['id'],
      courseName: json['course_name'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      schoolCollege: json['school_college'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_name'] = this.courseName;
    data['status'] = this.status;
    data['created_at'] = this.createdAt.toIso8601String();
    data['updated_at'] = this.updatedAt.toIso8601String();
    data['school_college'] = this.schoolCollege;
    return data;
  }
}
