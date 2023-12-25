




class ClassSecSubject {
  final int id;
  final String subjectName;


  ClassSecSubject({
    required this.id,
    required this.subjectName,
  });

  factory ClassSecSubject.fromJson(Map<String, dynamic> json) {
    return ClassSecSubject(
      id: json['id'],
      subjectName: json['subject_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject_name': subjectName,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return subjectName;
  }

}



class TeacherClass {
  final int id;
  final String section;
  final String classLevel;
  final bool classTeacher;


  TeacherClass({
    required this.id,
    required this.section,
    required this.classLevel,
    required this.classTeacher
  });

  factory TeacherClass.fromJson(Map<String, dynamic> json) {
    return TeacherClass(
      id: json['id'],
      section: json['section'],
      classLevel: json['class_level'],
      classTeacher: json['is_class_teacher']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'section': section,
      'class_level': classLevel,
      'is_class_teacher' : classTeacher
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return '${classLevel} ${section}';
  }


}