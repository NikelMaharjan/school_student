import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../api/api.dart';
import '../../constants/snackshow.dart';
import '../../exceptions/api_exception.dart';
import '../../features/model/user.dart';

class AuthService {
  static final dio = Dio();

  static Future<Either<String, User>> userLogin(
      {required String email, required String password}) async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      print('notification token : $token');
      final response = await dio.post(
        Api.userLogin,
        data: {'email': email, 'password': password, 'notification_token':token},
      );
      final box = Hive.box<String>('user');
      box.put('userData', jsonEncode(response.data));
      print('success');

      return Right(User.fromJson(response.data));
    } on DioException catch (err) {
    //  String message = DioException.getDioError(err);
      return Left(err.response?.data['data']);
    } on FirebaseException catch (err){
      print('notification error : $err');
      return Left('$err');
    }
  }

  static Future<Either<String, bool>> userLogout(String token) async {
    print('userLogout function started');
    try {
      final response = await dio.get(
          'http://116.203.219.132:8080/api/logout/',
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final box = Hive.box<String>('user');
      box.delete('userData');
      print('userLogout function success');
      return Right(true);
    } on DioException catch (err) {
      print('userLogout function failed with error: $err');
      return Left(err.response?.data['message'] ?? 'Unknown error occurred');
    }
  }



}
