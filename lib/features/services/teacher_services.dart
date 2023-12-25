




import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../model/information.dart';



final teacherSubList = FutureProvider.family(
        (ref, String token) => TeacherClassService(token).getTeacherSubInfo());


class TeacherClassService {
  String token;

  TeacherClassService(this.token);

  final dio = Dio();

  Future<List<TeacherClass>> getTeacherSubInfo() async {
    try {
      final response = await dio.get(Api.teacherClass,
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['data'] as List)
          .map((e) => TeacherClass.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}