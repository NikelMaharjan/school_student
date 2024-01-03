





import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eschool/features/model/parent_model.dart';
import 'package:eschool/features/model/student.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../authentication/providers/auth_provider.dart';
import '../model/features.dart';


final parentList = FutureProvider.family(
        (ref, String token) => ParentInfoService(token).getParentInfo());

final parentStudentList = FutureProvider.family(
        (ref, String token) => ParentInfoService(token).getStudentList());

final studentClassListProvider = FutureProvider.family<List<StudentClass>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final studentClass = StudentClassListService(token.user!.token, id);
  return await studentClass.getClassInfo();
});



class ParentInfoService {
  String token;

  ParentInfoService(this.token);

  final dio = Dio();

  Future<List<ParentDetail>> getParentInfo() async {
    try {
      final response = await dio.get(Api.parentInfo,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List).map((e) => ParentDetail.fromJson(e)).toList();
      print('parent success');
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

  Future<List<ParentStudent>> getStudentList() async {
    try {
      final response = await dio.get(Api.parentStudentInfo,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      if(response.statusCode == 204){
        throw "Nothing at the moment";
      }

      final data = (response.data['navigation']['data'] as List)
          .map((e) => ParentStudent.fromJson(e))
          .toList();
      return data;
    } on DioException catch (err) {
      throw Exception('Unable to fetch data');
    }
  }

}

class StudentClassListService {
  String token;
  int id;

  StudentClassListService(this.token, this.id);

  final dio = Dio();

  Future<List<StudentClass>> getClassInfo() async {
    try {
      final response = await dio.get('${Api.studentClassListUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => StudentClass.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}