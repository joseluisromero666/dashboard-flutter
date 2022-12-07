import 'package:flutter/material.dart';

class UserModel {
  String id;
  String name;
  String lastname;
  String email;
  List organizations;
  String manager;
  List<Map<String, Map<String, bool>>> roles;
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastname': lastname,
      'email': email,
      'organizations': organizations,
      'manager': manager,
      'roles': roles
    };
  }

  UserModel({this.id, this.name, this.lastname, this.email, this.organizations, this.manager, this.roles});
}

ThemeData oscuro = new ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green[500],
    fontFamily: 'Lato-Bold',
    textTheme: TextTheme(
        bodyText1: TextStyle(fontFamily: 'Lato-Black', color: Colors.white),
        bodyText2: TextStyle(fontFamily: 'Lato-Black', color: Colors.grey[400])),
    iconTheme: IconThemeData.fallback());

ThemeData claro = new ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.indigo[500],
    fontFamily: 'OpenSans',
    textTheme: TextTheme(bodyText1: TextStyle(fontFamily: 'FestiveRegular')));

ThemeData personalizado = new ThemeData(primaryColor: Colors.amberAccent);
UserModel myUserModel;
List organizaciones;

List temas = [claro, oscuro, personalizado];
bool exito;
Map<String, Map<String, bool>> time;
Map<String, Map<String, bool>> pro;
Map<String, Map<String, bool>> cont;
List<String> catergori = ["NaN"];
List misMaps;
String idi;
