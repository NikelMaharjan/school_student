import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eschool/features/updated_model/updated_class.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../api/api.dart';
import '../../authentication/providers/auth_provider.dart';
import '../model/class_model.dart';
import '../model/features.dart';
import '../model/student.dart';

final studentList = FutureProvider.family(
    (ref, String token) => StudentInfoService(token).getStudentInfo());

final studentClassList = FutureProvider.family(
    (ref, String token) => StudentClassService(token).getStudentClassInfo());

final secWiseSubjectProvider = FutureProvider.family<List<ClassSubject>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final SecWiseSubject = SecWiseSubjectService(token.user.token, id);
  return await SecWiseSubject.getSecWiseSubjectInfo();
});


final classsSubjectProvider = FutureProvider.family<List<UpdatedClass>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final classSubject = ClasssWiseSubjectService(token.user.token, id);
  return await classSubject.getClassWiseSubjectInfo();
});







class StudentInfoService {
  String token;

  StudentInfoService(this.token);

  final dio = Dio();

  Future<List<Student>> getStudentInfo() async {

    try {
      final response = await dio.get(Api.studentInfo,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => Student.fromJson(e))
          .toList();
      return data;
    } on DioException catch (err) {
      throw Exception('Unable to fetch data');
    }
  }
}

class StudentClassService {
  String token;

  StudentClassService(this.token);

  final dio = Dio();

  Future<List<StudentClass>> getStudentClassInfo() async {
    try {
      final response = await dio.get(Api.studentClassUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => StudentClass.fromJson(e))
          .toList();
      return data;
    } on DioException catch (err) {
      throw Exception('Unable to fetch data');
    }
  }
}


class SecWiseSubjectService {
  String token;
  int id;

  SecWiseSubjectService(this.token, this.id);

  final dio = Dio();

  Future<List<ClassSubject>> getSecWiseSubjectInfo() async {




    try {
      final response = await dio.get('${Api.sectionSubjectUrl}$id', options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));



      final data = (response.data['navigation']['data'] as List).map((e) => ClassSubject.fromJson(e)).toList();
      return data;

    } on DioException catch (err) {
      print(err);
      throw Exception('Unable to fetch data');
    }
  }
}


class ClasssWiseSubjectService {
  String token;
  int id;

  ClasssWiseSubjectService(this.token, this.id);

  final dio = Dio();

  Future<List<UpdatedClass>> getClassWiseSubjectInfo() async {


    print("NIkel");




    try {
      final response = await dio.get('${Api.clasSubjectUrl}$id', options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));



      final data = (response.data['navigation']['data'] as List).map((e) => UpdatedClass.fromJson(e)).toList();
      return data;

    } on DioException catch (err) {
      print("Nikel is $err");
      throw Exception('Unable to fetch data');
    }
  }
}
