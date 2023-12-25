// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
//
// import '../../api/api.dart';
// import '../model/class_model.dart';
// import '../model/school.dart';
//
// final allClassesInfo = FutureProvider.family(
//         (ref, String token) => AllClassService(token).getClassesInfo());
//
// final classInfo = FutureProvider.family(
//         (ref, String token) => ClassService(token).getOngoingClassInfo());
//
// final sectionsInfo = FutureProvider.family(
//         (ref, String token) => AllSections(token).getSectionsInfo());
//
// final classSecInfo = FutureProvider.family(
//         (ref, String token) => ClassSecService(token).getClassSectionInfo());
//
// final subjectInfo = FutureProvider.family(
//         (ref, String token) => SubjectService(token).getSubjectInfo());
//
// final classSubInfo = FutureProvider.family(
//         (ref, String token) => ClassSubService(token).getClassSubInfo());
//
// class AllClassService {
//   String token;
//
//   AllClassService(this.token);
//
//   final dio = Dio();
//
//   Future<List<MyClass>> getClassesInfo() async {
//     try {
//       final response = await dio.get(Api.allClassesUrl,
//           options: Options(
//               headers: {HttpHeaders.authorizationHeader: 'token $token'}));
//       final data = (response.data['navigation']['data'] as List)
//           .map((e) => MyClass.fromJson(e))
//           .toList();
//       print('classlist success');
//       return data;
//     } on DioError catch (err) {
//       print(err.response);
//       throw Exception('Unable to fetch data');
//     }
//   }
// }
//
// class ClassService {
//   String token;
//
//   ClassService(this.token);
//
//   final dio = Dio();
//
//   Future<List<ClassInfo>> getOngoingClassInfo() async {
//     try {
//       final response = await dio.get(Api.ongoingClasses,
//           options: Options(
//               headers: {HttpHeaders.authorizationHeader: 'token $token'}));
//       final data = (response.data['navigation']['data'] as List)
//           .map((e) => ClassInfo.fromJson(e))
//           .toList();
//       print('ongoing success');
//       return data;
//     } on DioError catch (err) {
//       print('ongoing failed');
//       print(err.response);
//       throw Exception('Unable to fetch data');
//     }
//   }
// }
//
// class AllSections {
//   String token;
//
//   AllSections(this.token);
//
//   final dio = Dio();
//
//   Future<List<Sections>> getSectionsInfo() async {
//     try {
//       final response = await dio.get(Api.allSections,
//           options: Options(
//               headers: {HttpHeaders.authorizationHeader: 'token $token'}));
//       final data = (response.data['navigation']['data'] as List)
//           .map((e) => Sections.fromJson(e))
//           .toList();
//       print('success');
//       return data;
//     } on DioError catch (err) {
//       print(err.response);
//       throw Exception('Unable to fetch data');
//     }
//   }
// }
//
// class ClassSecService {
//   String token;
//
//   ClassSecService(this.token);
//
//   final dio = Dio();
//
//   Future<List<ClassSection>> getClassSectionInfo() async {
//     try {
//       final response = await dio.get(Api.classSection,
//           options: Options(
//               headers: {HttpHeaders.authorizationHeader: 'token $token'}));
//       final data = (response.data['navigation']['data'] as List)
//           .map((e) => ClassSection.fromJson(e))
//           .toList();
//       print('success');
//       return data;
//     } on DioError catch (err) {
//       print(err.response);
//       throw Exception('Unable to fetch data');
//     }
//   }
// }
//
// class SubjectService {
//   String token;
//
//   SubjectService(this.token);
//
//   final dio = Dio();
//
//   Future<List<Subject>> getSubjectInfo() async {
//     try {
//       final response = await dio.get(Api.subjectUrl,
//           options: Options(
//               headers: {HttpHeaders.authorizationHeader: 'token $token'}));
//       final data = (response.data['navigation']['data'] as List)
//           .map((e) => Subject.fromJson(e))
//           .toList();
//       print('success');
//       return data;
//     } on DioError catch (err) {
//       print(err.response);
//       throw Exception('Unable to fetch data');
//     }
//   }
// }
//
// class ClassSubService {
//   String token;
//
//   ClassSubService(this.token);
//
//   final dio = Dio();
//
//   Future<List<ClassSubject>> getClassSubInfo() async {
//     try {
//       final response = await dio.get(Api.classSubjectUrl,
//           options: Options(
//               headers: {HttpHeaders.authorizationHeader: 'token $token'}));
//       final data = (response.data['navigation']['data'] as List)
//           .map((e) => ClassSubject.fromJson(e))
//           .toList();
//       print('success');
//       return data;
//     } on DioError catch (err) {
//       print(err.response);
//       throw Exception('Unable to fetch data');
//     }
//   }
// }
//
// class CourseService {
//   String token;
//
//   CourseService(this.token);
//
//   final dio = Dio();
//
//   Future<List<ClassSubject>> getClassSubInfo() async {
//     try {
//       final response = await dio.get(Api.classSubjectUrl,
//           options: Options(
//               headers: {HttpHeaders.authorizationHeader: 'token $token'}));
//       final data = (response.data['navigation']['data'] as List)
//           .map((e) => ClassSubject.fromJson(e))
//           .toList();
//       print('success');
//       return data;
//     } on DioError catch (err) {
//       print(err.response);
//       throw Exception('Unable to fetch data');
//     }
//   }
// }