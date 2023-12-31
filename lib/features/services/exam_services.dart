import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../authentication/providers/auth_provider.dart';
import '../model/class_model.dart';
import '../model/exam_model.dart';


final examClassProvider = FutureProvider.family<List<ExamClass>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final examClassList = ExamClassService(token.user.token, id);
  return await examClassList.getExamClass();
});


final examRoutineProvider = FutureProvider.family(
        (ref, String token) => ExamService(token).getRoutineInfo());


final classWiseExamProvider = FutureProvider.family<List<ExamRoutine>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final classExam = ClassWiseExamRoutineService(token.user.token, id);
  return await classExam.getExamClassRoutine();
});


final subjectInfo = FutureProvider.family(
        (ref, String token) => SubjectService(token).getSubject());



final marksInfo = FutureProvider.family(
        (ref, String token) => ExamService(token).getSubMarks());


final totalMarksProvider = FutureProvider.family<List<TotalMarks>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final totalMarks = TotalMarksService(token.user.token, id);
  return await totalMarks.getTotalInfo();
});


final subExamMarksProvider = FutureProvider.family<List<ExamMarks>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final subMarks = SubMarksService(token.user.token, id);
  return await subMarks.getSubInfo();
});




class ExamService {
  String token;

  ExamService(this.token);

  final dio = Dio();


  Future<List<ExamDetail>> getExamInfo() async {
    try {
      final response = await dio.get(Api.examDetailUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => ExamDetail.fromJson(e))
          .toList();
      print('exam success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

  Future<List<ExamClass>> getClassInfo() async {
    try {
      final response = await dio.get(Api.examClassDetailUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => ExamClass.fromJson(e))
          .toList();
      print('exam success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

  Future<List<ExamRoutine>> getRoutineInfo() async {
    try {
      final response = await dio.get(Api.examRoutineUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => ExamRoutine.fromJson(e))
          .toList();
      print('exam success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

  Future<List<ExamMarks>> getSubMarks() async {
    try {
      final response = await dio.get(Api.examMarksUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => ExamMarks.fromJson(e))
          .toList();
      print('exam success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }


}



class ExamClassService {
  String token;
  int id;

  ExamClassService(this.token, this.id);

  final dio = Dio();

  Future<List<ExamClass>> getExamClass() async {





    try {
      final response = await dio.get('${Api.examClassUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      if(response.statusCode == 204){
        throw "Nothing at the moment";
      }


      final data = (response.data['navigation']['data'] as List).map((e) => ExamClass.fromJson(e)).toList();



      return data;
    } on DioException catch (err) {
      throw Exception('Unable to fetch data');
    }
  }
}

class ClassWiseExamRoutineService {
  String token;
  int id;

  ClassWiseExamRoutineService(this.token, this.id);



  final dio = Dio();

  Future<List<ExamRoutine>> getExamClassRoutine() async {



    try {
      final response = await dio.get('${Api.classExamRoutineUrl}$id', options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      if(response.statusCode == 204){

        throw "No Exam Routine at the moment";
      }






      final data = (response.data['navigation']['data'] as List).map((e) => ExamRoutine.fromJson(e)).toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class SubjectService {
  String token;

  SubjectService(this.token);

  final dio = Dio();

  Future<List<Subject>> getSubject() async {
    try {
      final response = await dio.get(Api.subjectUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => Subject.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class TotalMarksService {
  String token;
  int id;

  TotalMarksService(this.token, this.id);

  final dio = Dio();

  Future<List<TotalMarks>> getTotalInfo() async {
    try {
      final response = await dio.get('${Api.totalMarksUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => TotalMarks.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}

class SubMarksService {
  String token;
  int id;

  SubMarksService(this.token, this.id);

  final dio = Dio();

  Future<List<ExamMarks>> getSubInfo() async {
    try {
      final response = await dio.get('${Api.subExamMarksUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));


      if(response.statusCode == 204) {

        return [

        ];

      }




      final data = (response.data['navigation']['data'] as List).map((e) => ExamMarks.fromJson(e)).toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}