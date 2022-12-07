import 'package:argon_flutter/models/TimeTracking.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeTrackingServices extends ChangeNotifier {
  static var v;

  static CollectionReference timeTracking = FirebaseFirestore.instance.collection('timeTracking');

  static Future<String> addNewTimeTrackingModel(TimeTrackingModel myTimeTracking) async {
    v = await FirebaseFirestore.instance.collection('timeTracking').add(myTimeTracking.toMap());
    myTimeTracking.id = v.id;
    modifyTimeTracking(myTimeTracking, myTimeTracking.nomTarea);
    return v.id;
  }

  static Future<void> modifyTimeTracking(TimeTrackingModel myTimeTracking, String nomTarea) {
    return timeTracking.where('nomTarea', isEqualTo: nomTarea).get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({
          'id': myTimeTracking.id,
          'active': myTimeTracking.active,
          'nomTarea': myTimeTracking.nomTarea,
          'proyecto': myTimeTracking.proyecto,
          'from': myTimeTracking.from,
          'until': myTimeTracking.until,
          'descripcion': myTimeTracking.descripcion,
          'comentario': myTimeTracking.comentario
        });
      });
    }).catchError((err) => print("Failed to modify TimeTracking: $err"));
  }
}
