import 'package:flutter/widgets.dart';

class ProjectModel {
  String categoria;
  String from;
  String id;
  String nombre;
  String presupuesto;
  String until;
  String url;
  String cliente;
  bool active;
  List<String> idUser;
  String idOrganization;

  Map<String, dynamic> toMap() {
    return {
      'categoria': categoria,
      'from': from,
      'id': id,
      'nombre': nombre,
      'presupuesto': presupuesto,
      'until': until,
      'url': url,
      'cliente': cliente,
      'active': active,
      'idUser': idUser,
      'idOrganization': idOrganization,
    };
  }

  ProjectModel(
      {this.categoria,
      this.from,
      this.id,
      this.nombre,
      this.presupuesto,
      this.until,
      this.url,
      this.cliente,
      this.active,
      this.idUser,
      this.idOrganization});
}

var name = TextEditingController();
var category = TextEditingController();
var budget = TextEditingController();
var url = TextEditingController();
var customer = TextEditingController();

String fromM;
String untilM;
String urlM;
String clienteM;

String clienteMo;
var nameMo = TextEditingController();
var categoryMo = TextEditingController();
var budgetMo = TextEditingController();
var urlMo = TextEditingController();
var customerMo = TextEditingController();
String fromMo;
String untilMo;
String idMo;
String oldNam;

ProjectModel myProjectModel;
ProjectModel myProjectModel2;

ProjectModel myCreateProjectModel;
ProjectModel myModifyProjectModel;
String role = roles[1];
List<String> roles = ['User', 'Admin'];
String path;
ProjectModel myProjectModelInitial;
bool regsPr;
bool editPr = true;
List organizationsTemp = [];
ProjectModel contractProjectModel;
