import 'package:eschool/features/model/student.dart';

import 'employee_info.dart';

class FeeType {
  int id;
  String name;
  bool isSubType;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int? type;

  FeeType({
    required this.id,
    required this.name,
    required this.isSubType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory FeeType.fromJson(Map<String, dynamic> json) => FeeType(
    id: json['id'],
    name: json['name'],
    isSubType: json['is_sub_type'],
    status: json['status'],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
    type: json['type']??null,
  );
  
}


class TotalFee {
  int id;
  Student2 student;
  String totalFee;
  String remainingFee;
  bool discountProvided;
  String? discount;
  bool hasDueDate;
  DateTime? dueDate;
  bool sendNotification;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  TotalFee({
    required this.id,
    required this.student,
    required this.totalFee,
    required this.remainingFee,
    required this.discountProvided,
    this.discount,
    required this.hasDueDate,
    this.dueDate,
    required this.sendNotification,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TotalFee.fromJson(Map<String, dynamic> json) => TotalFee(
    id: json['id'],
    student: Student2.fromJson(json['student']),
    totalFee: json['total_fee'],
    remainingFee: json['remaining_fee'],
    discountProvided: json['discount_provided'],
    discount: json['discount'],
    hasDueDate: json['has_due_date'],
    dueDate: json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
    sendNotification: json['send_notification'],
    status: json['status'],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );
  
}

class StudentFee {
  int id;
  TotalFee? studentTotalFee;
  FeeType? feeType;
  String? feeTitle;
  String? description;
  String? feeAmount;
  DateTime createdAt;
  DateTime updatedAt;

  StudentFee({
    required this.id,
    required this.studentTotalFee,
    required this.feeType,
    required this.feeTitle,
    required this.description,
    required this.feeAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentFee.fromJson(Map<String, dynamic> json) => StudentFee(
    id: json['id'],
    studentTotalFee:json['student_total_fee']!=null? TotalFee.fromJson(json['student_total_fee']):null,
    feeType: json['fee_type']!=null?FeeType.fromJson(json['fee_type']):null,
    feeTitle: json['fee_title']??null,
    description: json['description']??null,
    feeAmount: json['fee_amount']??null,
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );


}



class StudentFeePayment {
  int id;
  EmployeeData2 collectedBy;
  TotalFee totalFee;
  String paymentAmount;
  String paymentNote;
  String paymentMethod;
  DateTime paymentDate;
  DateTime createdAt;
  DateTime updatedAt;

  StudentFeePayment({
    required this.id,
    required this.collectedBy,
    required this.totalFee,
    required this.paymentAmount,
    required this.paymentNote,
    required this.paymentMethod,
    required this.paymentDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentFeePayment.fromJson(Map<String, dynamic> json) => StudentFeePayment(
    id: json['id'],
    collectedBy: EmployeeData2.fromJson(json['collected_by']),
    totalFee: TotalFee.fromJson(json['total_fee']),
    paymentAmount: json['payment_amount'],
    paymentNote: json['payment_note'],
    paymentMethod: json['payment_method'],
    paymentDate: DateTime.parse(json['payment_date']),
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );


}

