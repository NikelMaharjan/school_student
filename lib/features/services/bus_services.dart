







import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:eschool/features/model/bus_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../authentication/providers/auth_provider.dart';

class Test extends Equatable {
  final int id;
  final String token;

  Test({required this.id, required this.token});

  @override
  List<Object?> get props => [id, token];




}







final studentBusProvider = FutureProvider.family<List<StudentBusRoute>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final busProvider = BusService(token.user.token, id);
  return await busProvider.getStudentRoute();
});


final locationProvider = FutureProvider.family<List<BusLocation>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final busProvider = LocationService(token.user.token, id);
  return await busProvider.getBusLocation();
});








class BusService {
  String token;
  int id;

  BusService(this.token, this.id);

  final dio = Dio();

  Future<List<StudentBusRoute>> getStudentRoute() async {


    print("OK is $id");



    try {
      final response = await dio.get('${Api.studentBusRouteUrl}$id',
          options: Options(
              headers: {
                "Content-Type" : "application/json",
               // "Authorization" : 'token $token',
                "Accept-Encoding" : "gzip, deflate, br",
                'Connection' : "keep-alive",
                'Accept' : "*/*",




                HttpHeaders.authorizationHeader: 'token $token'
              }));





      final data = (response.data['navigation']['data'] as List).map((e) => StudentBusRoute.fromJson(e)).toList();


      return data;
    } on DioException catch (err) {
      print("Nikel Maharjan is ${err.response}");
      throw Exception('Unable to fetch data');
    }
  }
}


class LocationService{
  String token;
  int id;

  LocationService(this.token, this.id);

  final dio = Dio();

  Future<List<BusLocation>> getBusLocation() async {



    try {
      final response = await dio.get('${Api.busLocationUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => BusLocation.fromJson(e))
          .toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

}
