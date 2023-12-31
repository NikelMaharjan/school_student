import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';


import '../../api/api.dart';
import '../../authentication/providers/auth_provider.dart';
import '../model/notice.dart';

final noticeList = FutureProvider.family(
    (ref, String token) => NoticeService(token).getNotice());


final classNoticeProvider = FutureProvider.family<List<ClassNotice>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final classNotice = ClassNoticeService(token.user!.token, id);
  return await classNotice.getClassNotice();
});

final subNoticeList = FutureProvider.family(
    (ref, String token) => SubjectNoticeService(token: token).getSubjectNotice());


final subNoticeListNotification = FutureProvider.family<List<SubjectNotice>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final classNotice = SubjectNoticeService(token: token.user!.token, id: id);
  return await classNotice.getSubjectNoticeNotification();
});



class NoticeService {
  String token;

  NoticeService(this.token);

  final dio = Dio();

  Future<Either<String, dynamic>> addNotice({
    required String title,
    required String description,
    String? image,
    required bool for_only_class,
    required bool notification,
    // required int added_by,
    required int school_college,
    required int notice_type
  }) async {
    try {
      final response = await dio.post(Api.notices,
          data: {
            'title': title,
            'description': description,
            'school_college': school_college,
            'image': image ?? null,
            'for_only_class':for_only_class,
            'send_notification':notification,
            // 'added_by':added_by,
            'notice_type':notice_type

          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      return Right(response.data);
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Network error');
    }
  }


  Future<List<NoticeData>> getNotice() async {
    try {
      final response = await dio.get(Api.notices,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => NoticeData.fromJson(e))
          .toList();
      // print('success');
      return data;
    } on DioException catch (err) {
      print("ASdkasioasdjkas is ${err.response}");
      throw Exception('Unable to fetch data');
    }
  }
}



class ClassNoticeService {
  String token;
  int id;

  ClassNoticeService(this.token, this.id);

  final dio = Dio();

  Future<List<ClassNotice>> getClassNotice() async {
    try {
      final response = await dio.get('${Api.classNotices}$id', options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      if(response.statusCode == 204) {
       throw "No Notice at the moment";
      }



      final data = (response.data['navigation']['data'] as List).map((e) => ClassNotice.fromJson(e)).toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}



class SubjectNoticeService {
  String token;

  int? id;

    SubjectNoticeService({required this.token, this.id});

  final dio = Dio();

  Future<Either<String, dynamic>> addSubNotice({
    required String title,
    required String message,
    required int school_college,
    required int subjectName,
  }) async {
    try {
      final response = await dio.post(Api.subNotices,
          data: {
            'title': title,
            'message': message,
            'school_college': school_college,
            'subject_name': subjectName
          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      return Right(response.data);
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Network error');
    }
  }


  Future<List<SubjectNotice>> getSubjectNotice() async {


    try {


      final response = await dio.get(Api.subNotices,
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));



      if(response.statusCode == 204){
        throw "Nothing at the moment";
      }




      final data = (response.data['navigation']['data'] as List).map((e) => SubjectNotice.fromJson(e)).toList();


      return data;
    } on DioException catch (err) {
      throw Exception('Unable to fetch data');
    }
  }


  Future<List<SubjectNotice>> getSubjectNoticeNotification() async {




    try {


      final response = await dio.get("${Api.subNoticeNotification}$id/",
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));

    print("Response os $response");





      if(response.statusCode == 204){
        throw "Nothing at the moment";
      }




      final data = (response.data['data'] as List).map((e) => SubjectNotice.fromJson(e)).toList();


      return data;
    } on DioException catch (err) {
      throw Exception('Unable to fetch data');
    }
  }




}
