





import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eschool/features/model/class_model.dart';
import 'package:eschool/features/model/routine_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../authentication/providers/auth_provider.dart';



final classRoutineProvider = FutureProvider.family<List<RoutineData>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final classRoutine = classRoutineService(token.user.token, id);
  return await classRoutine.getClassRoutine();
});




class classRoutineService {
  String token;
  int id;

  classRoutineService(this.token, this.id);

  final dio = Dio();

  Future<List<RoutineData>> getClassRoutine() async {
    try {
      final response = await dio.get('${Api.classRoutineUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      if(response.statusCode == 204){


        return[

        ];

      }






      final data = (response.data['navigation']['data'] as List).map((e) => RoutineData.fromJson(e)).toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}