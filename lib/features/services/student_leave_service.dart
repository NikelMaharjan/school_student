





import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eschool/features/model/attendance_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../authentication/providers/auth_provider.dart';



final studentLeaveNoteProvider = FutureProvider.family<List<StudentLeaveNote>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final leaveService = StudentLeaveNoteService(token.user.token, id);
  return await leaveService.getLeaveNote();
});



class StudentLeaveService {
  String token;

  StudentLeaveService(this.token);

  final dio = Dio();


  Future<Either<String, dynamic>> addNote({
    required String reason,
    required int student,
    required bool longLeave,
    required String startDate,
    String? endDate
  }) async {
    try {
      final response = await dio.post(Api.leaveNoteUrl,
          data: {
              "reason": reason,
              "long_leave": longLeave,
              "start_date": startDate,
              "end_date": endDate,
              "student": student
          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      return Right(response.data);
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Network error');
    }
  }

  Future<Either<String, bool>> delLeaveNote({
    required int id,
  }) async {
    try {
      final response = await dio.delete(
        '${Api.delLeaveNoteUrl}$id/',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'token $token'},
        ),
      );

      return Right(true);
    } on DioError catch (err) {
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

  Future<List<StudentLeaveNote>> getLeaveNote() async {
    try {
      final response = await dio.get('${Api.studentLeaveNoteUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => StudentLeaveNote.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}