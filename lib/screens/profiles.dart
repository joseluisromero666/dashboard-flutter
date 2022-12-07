import 'dart:ui';
import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/models/userModel.dart';
import 'package:argon_flutter/widgets/button_widget.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart' as html;
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'PdfPreviewScreen.dart';
import 'package:flutter/painting.dart';

String texto = 'ningun valor seleccionado';
String valoractual = 'Administrador';
String texto2 = 'ningun valor seleccionado';
String valoractual2 = 'Tema Claro';

// ignore: must_be_immutable
class Profiles extends StatefulWidget {
  //List<String> organizations = ["NaN"];
  var mainState;
  final cardMargin;
  Profiles({this.mainState, this.cardMargin});

  @override
  State<Profiles> createState() => _ProfilesState();
}

var selectedCurrency;
var empty;
var pdfPro = pw.Document();
var pdfCont = pw.Document();
var pdfTime = pw.Document();
bool kIsWeb = identical(0, 0.0);

String paragraphPro = "";
var pagePro;
String paragraphCont = "";
var pageCont;
String paragraphTime = "";
var pageTime;
var a = ["NaN", "sss"];
String proyectoProvicional;
bool exitoT;

var pdf = pw.Document();
File file;
final bytes = pdf.save();
final blob = html.Blob([bytes], 'application/pdf');
String paragraph = "";
var page;

class _ProfilesState extends State<Profiles> {
  @override
  Widget build(BuildContext context) {
    //var firestore = Firestore;
    //var firestore2 = Firestore;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: ResponsiveLayout.isPhone(context)
            ? Navbar(
                avatar: true,
                rightOptions: false,
                bgColor: ArgonColors.initial,
                prefferedHeight: 60,
              )
            : ResponsiveLayout.isTablet(context)
                ? Navbar(
                    avatar: true,
                    rightOptions: false,
                    bgColor: ArgonColors.initial,
                    prefferedHeight: 60,
                  )
                : null,
        backgroundColor: Theme.of(context).primaryColor == Colors.green[500]
            ? Colors.grey[800]
            : Theme.of(context).primaryColor == Colors.indigo[500]
                ? ArgonColors.white
                : Colors.blue[800],
        drawer: ArgonDrawer(currentPage: "Profile"),
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage("assets/img/profile-screen-bg.png"),
                      fit: BoxFit.fitWidth))),
          SafeArea(
            child: ListView(children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 74.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Card(
                            margin: widget.cardMargin,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 85.0, bottom: 20.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  (kIsWeb) ? 80 : 20,
                                                  0,
                                                  (kIsWeb) ? 80 : 20,
                                                  0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                      misMaps.length.toString(),
                                                      style: TextStyle(
                                                          color: Theme.of(context)
                                                                      .primaryColor ==
                                                                  Colors.green[
                                                                      500]
                                                              ? Colors.white
                                                              : Theme.of(context)
                                                                          .primaryColor ==
                                                                      Colors.indigo[
                                                                          500]
                                                                  ? ArgonColors
                                                                      .black
                                                                  : Colors
                                                                      .black,
                                                          fontSize: 20.0)),
                                                  Text("Proyectos",
                                                      style: TextStyle(
                                                          color: Theme.of(context)
                                                                      .primaryColor ==
                                                                  Colors.green[
                                                                      500]
                                                              ? Colors.grey[350]
                                                              : Theme.of(context)
                                                                          .primaryColor ==
                                                                      Colors.indigo[
                                                                          500]
                                                                  ? ArgonColors
                                                                      .black
                                                                  : Colors
                                                                      .black,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w200)),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await projects();
                                                      (kIsWeb)
                                                          ? webDownloadPro(
                                                              context)
                                                          : movilWatch(context,
                                                              "projects");
                                                    },
                                                    child: Icon(
                                                      FeatherIcons.download,
                                                      color: Theme.of(context)
                                                                  .primaryColor ==
                                                              Colors.green[500]
                                                          ? Colors.grey[350]
                                                          : Theme.of(context)
                                                                      .primaryColor ==
                                                                  Colors.indigo[
                                                                      500]
                                                              ? ArgonColors
                                                                  .black
                                                              : Colors
                                                                  .blue[800],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'contracts')
                                                          .where("active",
                                                              isEqualTo: true)
                                                          .where("idUser",
                                                              isEqualTo:
                                                                  myUserModel
                                                                      .id)
                                                          .where(
                                                              "idOrganization",
                                                              isEqualTo:
                                                                  selectedCurrency)
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        return snapshot.hasData
                                                            ? (snapshot
                                                                        .data
                                                                        .docs
                                                                        .length !=
                                                                    0
                                                                ? Text(
                                                                    snapshot
                                                                        .data
                                                                        .docs
                                                                        .length
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Theme.of(context).primaryColor == Colors.green[500]
                                                                            ? Colors.white
                                                                            : Theme.of(context).primaryColor == Colors.indigo[500]
                                                                                ? ArgonColors.black
                                                                                : Colors.black,
                                                                        fontSize: 20.0))
                                                                : Center(
                                                                    child: Text(
                                                                        '0',
                                                                        style: TextStyle(
                                                                            color: Theme.of(context).primaryColor == Colors.green[500]
                                                                                ? Colors.white
                                                                                : Theme.of(context).primaryColor == Colors.indigo[500]
                                                                                    ? ArgonColors.black
                                                                                    : Colors.black,
                                                                            fontSize: 20.0)),
                                                                  ))
                                                            : Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                      }),
                                                  Text("Contratos",
                                                      style: TextStyle(
                                                          color: Theme.of(context)
                                                                      .primaryColor ==
                                                                  Colors.green[
                                                                      500]
                                                              ? Colors.grey[350]
                                                              : Theme.of(context)
                                                                          .primaryColor ==
                                                                      Colors.indigo[
                                                                          500]
                                                                  ? ArgonColors
                                                                      .black
                                                                  : Colors
                                                                      .black,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w200)),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await contracts();
                                                      (kIsWeb)
                                                          ? webDownloadCont(
                                                              context)
                                                          : movilWatch(context,
                                                              "contracts");
                                                    },
                                                    child: Icon(
                                                      FeatherIcons.download,
                                                      color: Theme.of(context)
                                                                  .primaryColor ==
                                                              Colors.green[500]
                                                          ? Colors.grey[350]
                                                          : Theme.of(context)
                                                                      .primaryColor ==
                                                                  Colors.indigo[
                                                                      500]
                                                              ? ArgonColors
                                                                  .black
                                                              : Colors
                                                                  .blue[800],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'timeTracking')
                                                          .where("active",
                                                              isEqualTo: true)
                                                          .where("idUser",
                                                              isEqualTo:
                                                                  myUserModel
                                                                      .id)
                                                          .where(
                                                              "idOrganization",
                                                              isEqualTo:
                                                                  selectedCurrency)
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        return snapshot.hasData
                                                            ? (snapshot
                                                                        .data
                                                                        .docs
                                                                        .length !=
                                                                    0
                                                                ? Text(
                                                                    snapshot
                                                                        .data
                                                                        .docs
                                                                        .length
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Theme.of(context).primaryColor == Colors.green[500]
                                                                            ? Colors.white
                                                                            : Theme.of(context).primaryColor == Colors.indigo[500]
                                                                                ? ArgonColors.black
                                                                                : Colors.black,
                                                                        fontSize: 20.0))
                                                                : Center(
                                                                    child: Text(
                                                                        '0',
                                                                        style: TextStyle(
                                                                            color: Theme.of(context).primaryColor == Colors.green[500]
                                                                                ? Colors.white
                                                                                : Theme.of(context).primaryColor == Colors.indigo[500]
                                                                                    ? ArgonColors.black
                                                                                    : Colors.black,
                                                                            fontSize: 20.0)),
                                                                  ))
                                                            : Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                      }),
                                                  Text("Time Tracking",
                                                      style: TextStyle(
                                                          color: Theme.of(context)
                                                                      .primaryColor ==
                                                                  Colors.green[
                                                                      500]
                                                              ? Colors.grey[350]
                                                              : Theme.of(context)
                                                                          .primaryColor ==
                                                                      Colors.indigo[
                                                                          500]
                                                                  ? ArgonColors
                                                                      .black
                                                                  : Colors
                                                                      .black,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w200)),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await time();
                                                      (kIsWeb)
                                                          ? webDownloadTime(
                                                              context)
                                                          : movilWatch(
                                                              context, "time");
                                                    },
                                                    child: Icon(
                                                      FeatherIcons.download,
                                                      color: Theme.of(context)
                                                                  .primaryColor ==
                                                              Colors.green[500]
                                                          ? Colors.grey[350]
                                                          : Theme.of(context)
                                                                      .primaryColor ==
                                                                  Colors.indigo[
                                                                      500]
                                                              ? ArgonColors
                                                                  .black
                                                              : Colors
                                                                  .blue[800],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Align(
                                          child: Text(
                                              FirebaseAuth.instance.currentUser
                                                  .displayName,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                              .primaryColor ==
                                                          Colors.green[500]
                                                      ? Colors.white
                                                      : Theme.of(context)
                                                                  .primaryColor ==
                                                              Colors.indigo[500]
                                                          ? ArgonColors.black
                                                          : Colors.black,
                                                  fontSize: 20.0)),
                                        ),
                                        Align(
                                          child: Text(
                                              FirebaseAuth
                                                  .instance.currentUser.email,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                              .primaryColor ==
                                                          Colors.green[500]
                                                      ? Colors.grey[350]
                                                      : Theme.of(context)
                                                                  .primaryColor ==
                                                              Colors.indigo[500]
                                                          ? ArgonColors.black
                                                          : Colors.black,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w200)),
                                        ),
                                        Divider(
                                          height: 40.0,
                                          thickness: 1.5,
                                          indent: 32.0,
                                          endIndent: 32.0,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  (kIsWeb) ? 160 : 100,
                                                  0,
                                                  (kIsWeb) ? 160 : 100,
                                                  0),
                                          child: ButtonWidgettLogOut(
                                            mColor: Color(0xFFC62626),
                                            text: "Log Out",
                                            onClicked: () => {
                                              FirebaseAuth.instance.signOut(),
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  "/account",
                                                  (route) => false),
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      FractionalTranslation(
                          translation: Offset(0.0, -0.5),
                          child: Align(
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  FirebaseAuth.instance.currentUser.photoURL),
                              radius: 70.0,
                              // maxRadius: 200.0,
                            ),
                            alignment: FractionalOffset(0.5, 0.0),
                          ))
                    ]),
                    Card(
                      margin: widget.cardMargin,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("organizations")
                                .where("active", isEqualTo: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("Loading");
                              } else {
                                List<DropdownMenuItem> currencyItems = [];
                                for (int i = 0;
                                    i < snapshot.data.docs.length;
                                    i++) {
                                  DocumentSnapshot snap = snapshot.data.docs[i];
                                  currencyItems.add(DropdownMenuItem(
                                    child: Text(snap.get('name')),
                                    value: snap.id,
                                  ));
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    DropdownButton(
                                      value: selectedCurrency,
                                      items: currencyItems,
                                      onChanged: (currencyValue) async {
                                        setState(() {
                                          selectedCurrency = currencyValue;
                                        });

                                        bool exitoTime = false;
                                        bool exitoProject = false;
                                        bool exitoContract = false;
                                        Map<String, Map<String, bool>> time;
                                        Map<String, Map<String, bool>> pro;
                                        Map<String, Map<String, bool>> cont;

                                        Navigator.pushNamed(
                                            context, '/animation');
                                        for (var i = 0;
                                            i <
                                                myUserModel
                                                    .organizations.length;
                                            i++) {
                                          if (myUserModel.organizations[i]
                                                  ["organization"] ==
                                              selectedCurrency) {
                                            await FirebaseFirestore.instance
                                                .collection('roles')
                                                .where("active",
                                                    isEqualTo: true)
                                                .where("id",
                                                    isEqualTo: myUserModel
                                                            .organizations[i]
                                                        ["rol"])
                                                .where("name",
                                                    isEqualTo: "Time Tracking")
                                                .get()
                                                .then((QuerySnapshot
                                                    querySnapshot) {
                                              querySnapshot.docs.forEach((doc) {
                                                exitoTime = true;
                                                time = {
                                                  "time_tracking": {
                                                    "time_tracking_create": doc
                                                            .get("permissions")[
                                                        "time_tracking_create"],
                                                    "time_tracking_delete": doc
                                                            .get("permissions")[
                                                        "time_tracking_delete"],
                                                    "time_tracking_exports": doc
                                                            .get("permissions")[
                                                        "time_tracking_exports"],
                                                    "time_tracking_read": doc
                                                            .get("permissions")[
                                                        "time_tracking_read"],
                                                    "time_tracking_update": doc
                                                            .get("permissions")[
                                                        "time_tracking_update"]
                                                  }
                                                };
                                              });
                                            });
                                          }
                                        }
                                        for (var i = 0;
                                            i <
                                                myUserModel
                                                    .organizations.length;
                                            i++) {
                                          if (myUserModel.organizations[i]
                                                  ["organization"] ==
                                              selectedCurrency) {
                                            await FirebaseFirestore.instance
                                                .collection('roles')
                                                .where("active",
                                                    isEqualTo: true)
                                                .where("id",
                                                    isEqualTo: myUserModel
                                                            .organizations[i]
                                                        ["rol"])
                                                .where("name",
                                                    isEqualTo: "projects")
                                                .get()
                                                .then((QuerySnapshot
                                                    querySnapshot) {
                                              querySnapshot.docs.forEach((doc) {
                                                exitoProject = true;
                                                pro = {
                                                  "projects": {
                                                    "projects_create":
                                                        doc.get("permissions")[
                                                            "projects_create"],
                                                    "projects_delete":
                                                        doc.get("permissions")[
                                                            "projects_delete"],
                                                    "projects_exports":
                                                        doc.get("permissions")[
                                                            "projects_exports"],
                                                    "projects_read":
                                                        doc.get("permissions")[
                                                            "projects_read"],
                                                    "projects_update":
                                                        doc.get("permissions")[
                                                            "projects_update"]
                                                  }
                                                };
                                              });
                                            });
                                          }
                                        }
                                        for (var i = 0;
                                            i <
                                                myUserModel
                                                    .organizations.length;
                                            i++) {
                                          if (myUserModel.organizations[i]
                                                  ["organization"] ==
                                              selectedCurrency) {
                                            await FirebaseFirestore.instance
                                                .collection('roles')
                                                .where("active",
                                                    isEqualTo: true)
                                                .where("id",
                                                    isEqualTo: myUserModel
                                                            .organizations[i]
                                                        ["rol"])
                                                .where("name",
                                                    isEqualTo: "contracts")
                                                .get()
                                                .then((QuerySnapshot
                                                    querySnapshot) {
                                              querySnapshot.docs.forEach((doc) {
                                                exitoContract = true;
                                                cont = {
                                                  "contracts": {
                                                    "contracts_create":
                                                        doc.get("permissions")[
                                                            "contracts_create"],
                                                    "contracts_delete":
                                                        doc.get("permissions")[
                                                            "contracts_delete"],
                                                    "contracts_exports": doc
                                                            .get("permissions")[
                                                        "contracts_exports"],
                                                    "contracts_read":
                                                        doc.get("permissions")[
                                                            "contracts_read"],
                                                    "contracts_update":
                                                        doc.get("permissions")[
                                                            "contracts_update"]
                                                  }
                                                };
                                              });
                                            });
                                          }
                                        }
                                        if (exitoTime == false) {
                                          time = {
                                            "time_tracking": {
                                              "time_tracking_create": false,
                                              "time_tracking_delete": false,
                                              "time_tracking_exports": false,
                                              "time_tracking_read": false,
                                              "time_tracking_update": false
                                            }
                                          };
                                        }
                                        if (exitoProject == false) {
                                          pro = {
                                            "projects": {
                                              "projects_create": false,
                                              "projects_delete": false,
                                              "projects_exports": false,
                                              "projects_read": false,
                                              "projects_update": false
                                            }
                                          };
                                        }
                                        if (exitoContract == false) {
                                          cont = {
                                            "contracts": {
                                              "contracts_create": false,
                                              "contracts_delete": false,
                                              "contracts_exports": false,
                                              "contracts_read": false,
                                              "contracts_update": false
                                            }
                                          };
                                        }
                                        catergori = null;
                                        catergori = ["NaN"];
                                        await FirebaseFirestore.instance
                                            .collection('projects')
                                            .where("active", isEqualTo: true)
                                            .where("idUser",
                                                isEqualTo: myUserModel.id)
                                            .where("idOrganization",
                                                isEqualTo: selectedCurrency)
                                            .get()
                                            .then(
                                                (QuerySnapshot querySnapshot) {
                                          querySnapshot.docs.forEach((doc) {
                                            catergori.add(doc["nombre"]);
                                          });
                                        });
                                        myUserModel.roles = [time, pro, cont];
                                        catergori = null;
                                        catergori = ["NaN"];
                                        misMaps = [];
                                        await FirebaseFirestore.instance
                                            .collection('projects')
                                            .where("active", isEqualTo: true)
                                            .where("idOrganization",
                                                isEqualTo: selectedCurrency)
                                            .get()
                                            .then(
                                                (QuerySnapshot querySnapshot) {
                                          querySnapshot.docs.forEach((doc) {
                                            for (var i = 0;
                                                i < doc['idUser'].length;
                                                i++) {
                                              if (doc['idUser'][i] ==
                                                  myUserModel.id) {
                                                misMaps.add(doc);
                                                catergori
                                                    .add(doc.get("nombre"));
                                              }
                                            }
                                          });
                                        });
                                        (myUserModel.manager == "")
                                            ? Navigator.pushNamed(
                                                context, '/home')
                                            : Navigator.pushNamed(
                                                context, '/TimeTracking');
                                      },
                                      isExpanded: false,
                                      hint: new Text("Organizations"),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButton<String>(
                              value: valoractual2,
                              items: [
                                DropdownMenuItem(
                                  child: Text('Tema Oscuro'),
                                  value: 'Tema Oscuro',
                                ),
                                DropdownMenuItem(
                                  child: Text('Tema Claro'),
                                  value: 'Tema Claro',
                                ),
                                DropdownMenuItem(
                                  child: Text('Tema Personalizado'),
                                  value: 'Tema Personalizado',
                                ),
                              ],
                              onChanged: (valor) {
                                setState(() {
                                  texto2 = valor;
                                  valoractual2 = valor;
                                  print(valor);
                                  if (valor == "Tema Oscuro") {
                                    widget.mainState(1);
                                  }
                                  if (valor == "Tema Claro") {
                                    widget.mainState(0);
                                  }
                                  if (valor == "Tema Personalizado") {
                                    widget.mainState(2);
                                  }
                                });
                              }),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ]));
  }

  String espacios(int numero, String valor) {
    String t = "";
    int one = (30 - numero);
    for (var i = 0; i < one; i++) {
      t += " ";
    }
    return valor + t;
  }

  projects() async {
    paragraphPro = "";
    pagePro = empty;
    pdfPro = new pw.Document();
    for (var i = 0; i < misMaps.length; i++) {
      String temp = espacios(
              misMaps[i].get("from").length, misMaps[i].get("from")) +
          espacios(misMaps[i].get("until").length, misMaps[i].get("until")) +
          espacios(misMaps[i].get("nombre").length, misMaps[i].get("nombre")) +
          "\n\n";
      paragraphPro += temp;
    }
  }

  writeOnPdfPro(String a) {
    pagePro = pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(level: 0, child: pw.Text("Proyects")),
          pw.Paragraph(
              text:
                  " From                                       Until                             Name"),
          pw.Paragraph(text: a)
        ];
      },
    );
  }

  webDownloadPro(context) async {
    writeOnPdfPro(paragraphPro);
    pdfPro.addPage(pagePro);
    final bytes = await pdfPro.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement()
      ..href = url
      ..style.display = 'none'
      ..download = 'proyects.pdf';
    html.document.body?.children?.add(anchor);
    anchor.click();
    html.document.body?.children?.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  contracts() async {
    paragraphCont = "";
    pageCont = empty;
    pdfCont = new pw.Document();
    await FirebaseFirestore.instance
        .collection('contracts')
        .where("active", isEqualTo: true)
        .where("idUser", isEqualTo: myUserModel.id)
        .where("idOrganization", isEqualTo: selectedCurrency)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        String temp = espacios(doc.get("from").length, doc.get("from")) +
            espacios(doc.get("until").length, doc.get("until")) +
            espacios(doc.get("type").length, doc.get("type")) +
            "\n\n";
        paragraphCont += temp;
      });
    });
  }

  writeOnPdfCont(String a) {
    pageCont = pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(level: 0, child: pw.Text("Contratos")),
          pw.Paragraph(
              text:
                  " From                                       Until                             Type"),
          pw.Paragraph(text: a)
        ];
      },
    );
  }

  webDownloadCont(context) async {
    writeOnPdfCont(paragraphCont);
    pdfCont.addPage(pageCont);
    final bytes = await pdfCont.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement()
      ..href = url
      ..style.display = 'none'
      ..download = 'contracts.pdf';
    html.document.body?.children?.add(anchor);
    anchor.click();
    html.document.body?.children?.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  time() async {
    paragraphTime = "";
    pageTime = empty;
    pdfTime = new pw.Document();
    await FirebaseFirestore.instance
        .collection('timeTracking')
        .where("active", isEqualTo: true)
        .where("idUser", isEqualTo: myUserModel.id)
        .where("idOrganization", isEqualTo: selectedCurrency)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        String temp = espacios(doc.get("from").length, doc.get("from")) +
            espacios(doc.get("until").length, doc.get("until")) +
            espacios(doc.get("nomTarea").length, doc.get("nomTarea")) +
            "\n\n";
        paragraphTime += temp;
      });
    });
  }

  writeOnPdfTime(String a) async {
    pageTime = pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(level: 0, child: pw.Text("Time Tracking")),
          pw.Paragraph(
              text:
                  " From                                       Until                             Task"),
          pw.Paragraph(text: a)
        ];
      },
    );
  }

  webDownloadTime(context) async {
    writeOnPdfTime(paragraphTime);
    pdfTime.addPage(pageTime);
    final bytes = await pdfTime.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement()
      ..href = url
      ..style.display = 'none'
      ..download = 'timeTraking.pdf';
    html.document.body?.children?.add(anchor);
    anchor.click();
    html.document.body?.children?.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  movilWatch(context, String categoria) async {
    if (categoria == "projects") {
      writeOnPdfPro(paragraphPro);
      pdfPro.addPage(pagePro);
      Directory documentDirectory = await getApplicationDocumentsDirectory();

      String documentPath = documentDirectory.path;

      file = File("$documentPath/example.pdf");
      file.writeAsBytesSync(await pdfPro.save());
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdfPro.save());
    }
    if (categoria == "contracts") {
      writeOnPdfCont(paragraphCont);
      pdfCont.addPage(pageCont);
      Directory documentDirectory = await getApplicationDocumentsDirectory();

      String documentPath = documentDirectory.path;

      file = File("$documentPath/example.pdf");

      file.writeAsBytesSync(await pdfCont.save());
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdfCont.save());
    }
    if (categoria == "time") {
      writeOnPdfTime(paragraphTime);
      pdfTime.addPage(pageTime);
      Directory documentDirectory = await getApplicationDocumentsDirectory();

      String documentPath = documentDirectory.path;

      file = File("$documentPath/example.pdf");

      file.writeAsBytesSync(await pdfTime.save());
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdfTime.save());
    }
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    String fullPath = "$documentPath/example.pdf";

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PdfPreviewScreen(
                  path: fullPath,
                )));
  }
}
