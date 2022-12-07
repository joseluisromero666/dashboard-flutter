import 'package:flutter/widgets.dart';

class TimeTrackingModel {
  String id;
  bool active;
  String nomTarea;
  String proyecto;
  String from;
  String until;
  String descripcion;
  String comentario;
  String idUser;
  String idOrganization;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'active': active,
      'nomTarea': nomTarea,
      'proyecto': proyecto,
      'from': from,
      'until': until,
      'descripcion': descripcion,
      'comentario': comentario,
      'idUser': idUser,
      'idOrganization': idOrganization,
    };
  }

  TimeTrackingModel(
      {this.id,
      this.active,
      this.nomTarea,
      this.proyecto,
      this.from,
      this.until,
      this.descripcion,
      this.comentario,
      this.idUser,
      this.idOrganization});
}

String fromT;
String untilT;
List<String> projectsTmm = ["NaN"];
var taskT = TextEditingController();
var namesT = TextEditingController();
var descriptionT = TextEditingController();
TimeTrackingModel myTimeTrackingModel;
TimeTrackingModel myTimeTrackingModelD;
bool reports;
String fromTM;
String untilTM;
var taskTM = TextEditingController();
var namesTM = TextEditingController();
var commentTM = TextEditingController();
var descriptionTM = TextEditingController();
TimeTrackingModel myTimeTrackingModelM;
List<String> projectsTM = ["NaN"];
String oldTask;
TimeTrackingModel myTimeTrackingModelInitial;
bool regisTT;
bool editTT;

List<String> proyectostime;

String back;
