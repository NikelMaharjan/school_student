





import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eschool/features/model/fee_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../authentication/providers/auth_provider.dart';





final totalFeeProvider = FutureProvider.family<List<TotalFee>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final totalFee = TotalFeeServices(token.user.token, id);
  return await totalFee.getTotalFeeInfo();
});


final studentFeeProvider = FutureProvider.family<List<StudentFee>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final studentFee = StudentFeeService(token.user.token, id);
  return await studentFee.getStudentFeeInfo();
});


final studentFeePaymentProvider = FutureProvider.family<List<StudentFeePayment>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final studentFeePayment = StudentFeePaymentService(token.user.token, id);
  return await studentFeePayment.getStudentFeePaymentInfo();
});

final studentAllFeePaymentProvider = FutureProvider.family<List<StudentFeePayment>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final studentAllFeePayment = StudentFeePaymentService(token.user.token, id);
  return await studentAllFeePayment.getStudentAllFeePaymentInfo();
});





class TotalFeeServices {
  String token;
  int id;

  TotalFeeServices(this.token, this.id);

  final dio = Dio();

  Future<List<TotalFee>> getTotalFeeInfo() async {
    try {
      final response = await dio.get('${Api.studentTotalFeeUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => TotalFee.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class StudentFeeService {
  String token;
  int id;

  StudentFeeService(this.token, this.id);

  final dio = Dio();

  Future<List<StudentFee>> getStudentFeeInfo() async {
    try {
      final response = await dio.get('${Api.studentFeeUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => StudentFee.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class StudentFeePaymentService {
  String token;
  int id;

  StudentFeePaymentService(this.token, this.id);

  final dio = Dio();

  Future<List<StudentFeePayment>> getStudentFeePaymentInfo() async {
    try {
      final response = await dio.get('${Api.studentFeePaymentUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => StudentFeePayment.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

  Future<List<StudentFeePayment>> getStudentAllFeePaymentInfo() async {
    try {
      final response = await dio.get('${Api.studentAllFeePaymentUrl}',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => StudentFeePayment.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }




}


class FeePaymentService{

  String token;

  FeePaymentService(this.token);

  final dio = Dio();

  Future<Either<String, dynamic>> feePayment({
    required int collectedBy,
    required int totalFee,
    required String paymentAmount,
    required String paymentNote,
    required String paymentMethod,
    required String paymentDate,

  }) async {
    try {
      final response = await dio.post(Api.studentAllFeePaymentUrl,
          data: {
            "collected_by": collectedBy,
            "total_fee": totalFee,
            "payment_amount": paymentAmount,
            "payment_note": paymentNote,
            "payment_method": paymentMethod,
            "payment_date": paymentDate

          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      return Right(response.data);
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Network error');
    }
  }


}

