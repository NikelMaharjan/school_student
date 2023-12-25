import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../api/api.dart';
import '../model/employee_info.dart';
import '../model/information.dart';
import '../model/user.dart';

final employeeList = FutureProvider.family(
    (ref, String token) => InfoService(token).getEmployeeInfo());

final userList = FutureProvider.family(
    (ref, String token) => UserService(token).getUserInfo());




class InfoService {
  String token;

  InfoService(this.token);

  final dio = Dio();

  Future<List<EmployeeData>> getEmployeeInfo() async {
    try {
      final response = await dio.get(Api.employeeInfo,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => EmployeeData.fromJson(e))
          .toList();
      print('teacher success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}

class UserService {
  String token;

  UserService(this.token);

  final dio = Dio();

  Future<List<UserInfo>> getUserInfo() async {
    try {
      final response = await dio.get(Api.usersAll,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => UserInfo.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}






