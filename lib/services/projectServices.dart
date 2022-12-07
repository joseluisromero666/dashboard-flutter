import 'package:argon_flutter/models/projectModel.dart';
import 'package:argon_flutter/screens/profiles.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectServices extends ChangeNotifier {
  static var v;
  static CollectionReference projects = FirebaseFirestore.instance.collection('projects');

  static Future<String> addNewProjectModel(ProjectModel myProject) async {
    v = await FirebaseFirestore.instance.collection('projects').add(myProject.toMap());
    myProject.id = v.id;
    modifyProject(myProject, myProject.nombre);
    return v.id;
  }

  static Future<void> modifyProject(ProjectModel myProject, String oldName) async {
    return projects.where('nombre', isEqualTo: oldName).get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({
          'id': myProject.id,
          'from': myProject.from,
          'until': myProject.until,
          'categoria': myProject.categoria,
          'nombre': myProject.nombre,
          'presupuesto': myProject.presupuesto,
          'url': myProject.url,
          'cliente': myProject.cliente,
          'active': myProject.active,
          'idOrganization': myProject.idOrganization,
          'idUser': myProject.idUser,
        });
      });
    }).catchError((err) => print("Failed to modify project: $err"));
  }

  static Future<List<Map<String, String>>> getProjects() async {
    List<Map<String, String>> projectsList = [];
    await projects.where("idOrganization", isEqualTo: selectedCurrency).where("active", isEqualTo: true).get().then(
        (querySnapshot) =>
            querySnapshot.docs.forEach((doc) => projectsList.add({"name": doc.get("nombre"), "id": doc.get("id")})));
    return projectsList;
  }
}
