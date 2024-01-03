






import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eschool/features/model/features.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../authentication/providers/auth_provider.dart';
import '../model/class_model.dart';





final classSecSubjectProvider = FutureProvider.family<List<ClassSecSubject>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final classSecSubjectService = ClassSecSubjectService(token.user!.token, id);
  return await classSecSubjectService.getClassSubjectInfo();
});



final studentClassInfo = FutureProvider.family(
        (ref, String token) => StudentClassService(token).getStudentClass());





class ClassSecSubjectService {
  String token;
  int id;

  ClassSecSubjectService(this.token, this.id);

  final dio = Dio();

  Future<List<ClassSecSubject>> getClassSubjectInfo() async {
    try {
      final response = await dio.get('${Api.classSecSubUrl}$id/',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['data'] as List)
          .map((e) => ClassSecSubject.fromJson(e))
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

  Future<List<StudentClass>> getStudentClass() async {
    try {
      final response = await dio.get(Api.studentClassUrl, options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));



      if(response.statusCode == 204) {
       throw "Nothing at the moment";
      }








      final data = (response.data['navigation']['data'] as List).map((e) => StudentClass.fromJson(e)).toList();




      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}



