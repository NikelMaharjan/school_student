





import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eschool/features/model/attendance_model.dart';
import 'package:eschool/features/model/student.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../authentication/providers/auth_provider.dart';


final studentAttendanceProvider = FutureProvider.family<List<StudentAttendance>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final studentStatus = StudentAttendanceService(token.user!.token, id);
  return await studentStatus.getStudentAttendance();
});

final studentLeaveNoteProvider = FutureProvider.family<List<StudentLeaveNote>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final studentStatus = StudentLeaveNoteService(token.user!.token, id);
  return await studentStatus.getStudentLeaveNote();
});


final attendanceList = FutureProvider.family(
        (ref, String token) => AttendanceService(token).getAttendanceInfo());



class AttendanceService {
  String token;

  AttendanceService(this.token);

  final dio = Dio();


  Future<List<Attendance>> getAttendanceInfo() async {
    try {
      final response = await dio.get(Api.attendanceUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => Attendance.fromJson(e))
          .toList();
      // print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class StudentAttendanceService {
  String token;
  int id;

  StudentAttendanceService(this.token, this.id);

  final dio = Dio();

  Future<List<StudentAttendance>> getStudentAttendance() async {





    try {
      final response = await dio.get('${Api.studentAttendanceInfo}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));


      if(response.statusCode == 204) {
        return [

        ];
      }





      final data = (response.data['navigation']['data'] as List).map((e) => StudentAttendance.fromJson(e)).toList();

      print("data is $data");

      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class StudentLeaveNoteService {
  String token;
  int id;

  StudentLeaveNoteService(this.token, this.id);

  final dio = Dio();

  Future<List<StudentLeaveNote>> getStudentLeaveNote() async {


    try {
      final response = await dio.get('${Api.studentLeaveNoteUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));




      final data = (response.data['navigation']['data'] as List).map((e) => StudentLeaveNote.fromJson(e)).toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}