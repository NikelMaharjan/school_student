import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../api/api.dart';
import '../model/school.dart';

final schoolInfo = FutureProvider.family(
    (ref, String token) => SchoolService(token).getSchoolInfo());

final batchInfo = FutureProvider.family(
    (ref, String token) => BatchService(token).getBatchInfo());

final semInfo = FutureProvider.family(
    (ref, String token) => SemService(token).getSemInfo());

class SchoolService {
  String token;

  SchoolService(this.token);

  final dio = Dio();

  Future<List<School>> getSchoolInfo() async {
    try {
      final response = await dio.get(Api.school_college,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => School.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}

class BatchService {
  String token;

  BatchService(this.token);

  final dio = Dio();

  Future<List<Batch>> getBatchInfo() async {
    try {
      final response = await dio.get(Api.batchUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => Batch.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}

class SemService {
  String token;

  SemService(this.token);

  final dio = Dio();

  Future<List<Semester>> getSemInfo() async {
    try {
      final response = await dio.get(Api.semUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => Semester.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}
