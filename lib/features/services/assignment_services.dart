

import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../api/api.dart';
import '../../authentication/providers/auth_provider.dart';
import '../model/assignment_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';

final assignmentList = FutureProvider.family(
        (ref, String token) => AssignmentService(token).getAssignment());
final assignmentStatusList = FutureProvider.family(
        (ref, String token) => AssignmentService(token).getAssignmentStatus());
final studentAssignmentProvider = FutureProvider.family(
        (ref, String token) => StudentAssignmentService(token).getStudents());




final subAssignmentProvider = FutureProvider.family<List<Assignment>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final assignment = AssignmentTotalService(token.user!.token, id);
  return await assignment.getSubAssignment();
});




class AssignmentService {
  String token;

  AssignmentService(this.token);

  final dio = Dio();







  Future<List<Assignment>> getAssignment() async {
    try {


      final response = await dio.get(Api.assignmentUrl,
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List).map((e) => Assignment.fromJson(e)).toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }



  Future<List<StudentAssignmentStatus>> getAssignmentStatus() async {
    try {
      final response = await dio.get(Api.assignmentStatus,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => StudentAssignmentStatus.fromJson(e))
          .toList();
      // print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }


}

class StudentAssignmentService {
  String token;


  StudentAssignmentService(this.token);

  final dio = Dio();

  Future<List<StudentAssignment>> getStudents() async {



    try {
      final response = await dio.get('${Api.studentAssignmentUrl}',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));


      if(response.statusCode == 204) {
        return [];
      }



      final data = (response.data['navigation']['data'] as List).map((e) => StudentAssignment.fromJson(e)).toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

  Future<Either<String, dynamic>> addStudentAssignment({

    required int assignment,
    required int student,
    required File student_assignment,
  }) async {
    try {
      final formData = FormData.fromMap({
        'student': student,
        'assignment': assignment,
        'student_assignment': await MultipartFile.fromFile(
          student_assignment.path,
          filename: basename(student_assignment.path),

        ),
      });
      final response = await dio.post(
          Api.studentAssignmentUrl,
          data: formData,options: Options(
          headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      print('Response: ${response.statusCode} ${response.data}');
      return Right(true);
    } catch (e) {
      print('Error: $e');
      return Left('$e');
    }
  }


  Future<Either<String, bool>> delStudentAssignment({
    required int id,
  }) async {
    try {
      final response = await dio.delete(
        '${Api.delStudentAssignmentUrl}$id/',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'token $token'},
        ),
      );

      return Right(true);
    } on DioException catch (err) {
      // print(err.response);
      throw Exception('Unable to fetch data');
    }
  }


}


class AssignmentTotalService {
  String token;
  int id;

  AssignmentTotalService(this.token, this.id);

  final dio = Dio();

  Future<List<Assignment>> getSubAssignment() async {



    try {
      final response = await dio.get('${Api.assignmentTotalUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      

      if(response.statusCode == 204) {
        throw "No Assignment at the moment";
      }

      final data = (response.data['navigation']["data"] as List).map((e) => Assignment.fromJson(e)).toList();


    return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}