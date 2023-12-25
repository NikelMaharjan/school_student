import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eschool/authentication/providers/auth_provider.dart';
import 'package:eschool/constants/colors.dart';
import 'package:eschool/features/view_page/student_page/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../model/bus_model.dart';

class BusLocationPage extends ConsumerStatefulWidget {
  final int id;
  BusLocationPage({required this.id});

  @override
  _BusLocationPageState createState() => _BusLocationPageState();
}

class _BusLocationPageState extends ConsumerState<BusLocationPage> {
  late StreamController<List<BusLocation>> _streamController;
  late Dio _dio;
  late Timer _timer;
  LatLng? busPosition;
  LatLng currentPosition = LatLng(0.0, 0.0);
  Set<Marker> marker = {};
  late GoogleMapController _controller ;
  late BitmapDescriptor _busIcon;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<BusLocation>>();
    _dio = Dio();
    _timer = Timer.periodic(Duration(seconds: 10), (_) => fetchBusLocations());
    trackPosition();
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(10.w, 10.h)), // Set the desired size of the marker icon
      'assets/images/bus3.png',
    ).then((descriptor) {
      setState(() {
        _busIcon = descriptor;
      });
    });
  }

  Future<void> trackPosition() async {

      final reqPermission = await Geolocator.requestPermission();
      final checkPermission = await Geolocator.checkPermission();
      if(checkPermission==LocationPermission.deniedForever||checkPermission==LocationPermission.denied){
        return showDialog(
          barrierDismissible: false,
            context: context,
            builder: (context){
              return AlertDialog(

                content: Text('Please give Access to location through settings'),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: primary,
                    ),
                      onPressed: ()async{
                      await Geolocator.openAppSettings();
                      },
                      child: Text('Go to settings',style: TextStyle(color: Colors.white),)
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: primary,
                      ),
                      onPressed: (){
                        Get.offAll(OverviewPage());
                      },
                      child: Text('No',style: TextStyle(color: Colors.white),)
                  )
                ],
              );
            }
        );
      }
      else{
        try{
          final position = await Geolocator.getCurrentPosition();
          setState(() {
            currentPosition = LatLng(position.latitude, position.longitude);
          });
        }catch (error) {
          if (error is PlatformException && error.code == 'PERMISSION_DENIED') {

            print("Location permission denied.");
          }
          else {
            print("Error retrieving location: $error");
          }

        }

      }

    }





  @override
  void dispose() {
    _streamController.close();
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchBusLocations() async {
    final auth = ref.watch(authProvider);
    try {
      final response = await _dio.get(
        'http://116.203.219.132:8080/api/bus_location/all/?bus=${widget.id}',
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token ${auth.user.token}'})
      );
      final List<dynamic> data = response.data['navigation']['data'];

      final List<BusLocation> busLocations = data
          .map((json) => BusLocation.fromJson(json))
          .toList();

      _streamController.add(busLocations);

      setState(() {
        busPosition = LatLng(busLocations.first.latitude, busLocations.first.longitude);
        marker.add(
            Marker(
                infoWindow: InfoWindow(title: 'Bus'),
                markerId: MarkerId('Bus'),
                position: LatLng(busPosition?.latitude??0, busPosition?.longitude??0) ,
                icon: _busIcon
            )
        );
      });


    } catch (error) {
      // Handle error
      print('Error fetching bus locations: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Bus Locations'),
      ),
      body: StreamBuilder<List<BusLocation>>(

        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<BusLocation>? busLocations = snapshot.data;

              // busPosition = LatLng(busLocations?.first.latitude?? 0, busLocations?.first.longitude??0);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('Bus ID: ${busLocations?.first.bus.toString()}',style: TextStyle(color: Colors.black),),
                  subtitle: Text(
                    'Latitude: ${busLocations?.first.latitude.toString()}, Longitude: ${busLocations?.first.longitude.toString()}',style: TextStyle(color: Colors.black)
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 500.h,
                  width: 350.w,
                  child: GoogleMap(
                    onMapCreated: (controller){
                     _controller = controller;
                    },
                    myLocationEnabled: true,
                    markers: marker,
                      initialCameraPosition: CameraPosition(
                        zoom: 15,
                          target: busPosition??LatLng(0, 0),
                      )
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: primary
                    ),
                      onPressed: (){
                        _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                            zoom: 15,
                            target: busPosition??LatLng(0.0, 0.0))));

                      },
                      child: Text('Track your bus',style:TextStyle(color:Colors.white))
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text(
              'Error fetching bus locations',
              style: TextStyle(color: Colors.red),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}





