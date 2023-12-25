


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Location{

  final double lat;
  final double long;
  final int id;

  Location({
    required this.lat,
    required this.long,
    required this.id
});

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
        lat: json['lat'],
        long: json['long'],
      id: json['driver_id']
    );
  }

  factory Location.empty(){
    return Location(
        lat: 0.0,
        long: 0.0,
        id: 0
    );
  }

}

final locationStream = StreamProvider((ref) => LocationService.getLocation(16));

class LocationService {
  static CollectionReference locationDb = FirebaseFirestore.instance.collection('Locations');

  static Stream<Location?> getLocation(int id) {
    return locationDb.snapshots().map((event) => getSome(event, id));
  }

  static Location? getSome(QuerySnapshot querySnapshot, int id) {
    final documents = querySnapshot.docs;
    if (documents.isNotEmpty) {
      final location = documents.first.data() as Map<String, dynamic>;
      if (location['driver_id'] == id) {
        return Location(
          lat: location['lat'],
          long: location['long'],
          id: location['driver_id'],
        );
      }
    }
    return null;
  }
}

