import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/models/projectModel.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//widgets
class SpecificProject extends StatefulWidget {
  @override
  _SpecificProjectState createState() => _SpecificProjectState();
}

class _SpecificProjectState extends State<SpecificProject> {
  CollectionReference projects =
      FirebaseFirestore.instance.collection('projects');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveLayout.isPhone(context)
          ? Navbar(
              avatar: true,
              backPage: "home",
              rightOptions: false,
              prefferedHeight: 60,
              bgColor: ArgonColors.initial,
              backButton: true,
            )
          : null,
      backgroundColor: Theme.of(context).primaryColor == Colors.green[500]
          ? Colors.grey[900]
          : Theme.of(context).primaryColor == Colors.indigo[500]
              ? ArgonColors.white
              : Colors.blue[800],
      body: Stack(children: <Widget>[
        SafeArea(
            child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 170.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(children: <Widget>[
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(height: 50.0),
                              Align(
                                child: Text("Project",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor ==
                                                Colors.green[500]
                                            ? Colors.white
                                            : Theme.of(context).primaryColor ==
                                                    Colors.indigo[500]
                                                ? Colors.black
                                                : Colors.black,
                                        fontSize: 20.0)),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32.0, right: 32.0),
                                  child: Align(
                                    alignment: Alignment(-0.7, 0.0),
                                    child: Text(
                                        myProjectModel == null
                                            ? "[" +
                                                myProjectModelInitial.nombre +
                                                "]"
                                            : "[" + myProjectModel.nombre + "]",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                        .primaryColor ==
                                                    Colors.green[500]
                                                ? Colors.white
                                                : Theme.of(context)
                                                            .primaryColor ==
                                                        Colors.indigo[500]
                                                    ? Colors.black
                                                    : Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w200)),
                                  )),
                              Divider(
                                height: 40.0,
                                thickness: 1.5,
                                indent: 32.0,
                                endIndent: 32.0,
                              ),
                              Align(
                                child: Text("Customer",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor ==
                                                Colors.green[500]
                                            ? Colors.white
                                            : Theme.of(context).primaryColor ==
                                                    Colors.indigo[500]
                                                ? Colors.black
                                                : Colors.black,
                                        fontSize: 20.0)),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32.0, right: 32.0),
                                  child: Align(
                                    alignment: Alignment(-0.7, 0.0),
                                    child: Text(
                                        myProjectModel == null
                                            ? "[" +
                                                myProjectModelInitial.cliente +
                                                "]"
                                            : "[" +
                                                myProjectModel.cliente +
                                                "]",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                        .primaryColor ==
                                                    Colors.green[500]
                                                ? Colors.white
                                                : Theme.of(context)
                                                            .primaryColor ==
                                                        Colors.indigo[500]
                                                    ? Colors.black
                                                    : Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w200)),
                                  )),
                              Divider(
                                height: 40.0,
                                thickness: 1.5,
                                indent: 32.0,
                                endIndent: 32.0,
                              ),
                              Align(
                                child: Text("Category",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor ==
                                                Colors.green[500]
                                            ? Colors.white
                                            : Theme.of(context).primaryColor ==
                                                    Colors.indigo[500]
                                                ? Colors.black
                                                : Colors.black,
                                        fontSize: 20.0)),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 32.0, right: 32.0),
                                child: Align(
                                  alignment: Alignment(-0.7, 0.0),
                                  child: Text(
                                      myProjectModel == null
                                          ? "[" +
                                              myProjectModelInitial.categoria +
                                              "]"
                                          : "[" +
                                              myProjectModel.categoria +
                                              "]",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor ==
                                                      Colors.green[500]
                                                  ? Colors.white
                                                  : Theme.of(context)
                                                              .primaryColor ==
                                                          Colors.indigo[500]
                                                      ? Colors.black
                                                      : Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w200)),
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Divider(
                                height: 40.0,
                                thickness: 1.5,
                                indent: 32.0,
                                endIndent: 32.0,
                              ),
                              SizedBox(height: 10.0),
                              Align(
                                child: Text("From",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor ==
                                                Colors.green[500]
                                            ? Colors.white
                                            : Theme.of(context).primaryColor ==
                                                    Colors.indigo[500]
                                                ? Colors.black
                                                : Colors.black,
                                        fontSize: 20.0)),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32.0, right: 32.0),
                                  child: Align(
                                    alignment: Alignment(-0.7, 0.0),
                                    child: Text(
                                        myProjectModel == null
                                            ? "[" +
                                                myProjectModelInitial.from +
                                                "]"
                                            : "[" + myProjectModel.from + "]",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                        .primaryColor ==
                                                    Colors.green[500]
                                                ? Colors.white
                                                : Theme.of(context)
                                                            .primaryColor ==
                                                        Colors.indigo[500]
                                                    ? Colors.black
                                                    : Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w200)),
                                  )),
                              SizedBox(height: 10.0),
                              Divider(
                                height: 40.0,
                                thickness: 1.5,
                                indent: 32.0,
                                endIndent: 32.0,
                              ),
                              Align(
                                child: Text("Until",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor ==
                                                Colors.green[500]
                                            ? Colors.white
                                            : Theme.of(context).primaryColor ==
                                                    Colors.indigo[500]
                                                ? Colors.black
                                                : Colors.black,
                                        fontSize: 20.0)),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32.0, right: 32.0),
                                  child: Align(
                                    alignment: Alignment(-0.7, 0.0),
                                    child: Text(
                                        myProjectModel == null
                                            ? "[" +
                                                myProjectModelInitial.until +
                                                "]"
                                            : "[" + myProjectModel.until + "]",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                        .primaryColor ==
                                                    Colors.green[500]
                                                ? Colors.white
                                                : Theme.of(context)
                                                            .primaryColor ==
                                                        Colors.indigo[500]
                                                    ? Colors.black
                                                    : Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w200)),
                                  )),
                              SizedBox(height: 10.0),
                              Divider(
                                height: 40.0,
                                thickness: 1.5,
                                indent: 32.0,
                                endIndent: 32.0,
                              ),
                              Align(
                                child: Text("Budget",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor ==
                                                Colors.green[500]
                                            ? Colors.white
                                            : Theme.of(context).primaryColor ==
                                                    Colors.indigo[500]
                                                ? Colors.black
                                                : Colors.black,
                                        fontSize: 20.0)),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32.0, right: 32.0),
                                  child: Align(
                                    alignment: Alignment(-0.7, 0.0),
                                    child: Text(
                                        myProjectModel == null
                                            ? "[" +
                                                myProjectModelInitial
                                                    .presupuesto +
                                                "]"
                                            : "[" +
                                                myProjectModel.presupuesto +
                                                "]",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                        .primaryColor ==
                                                    Colors.green[500]
                                                ? Colors.white
                                                : Theme.of(context)
                                                            .primaryColor ==
                                                        Colors.indigo[500]
                                                    ? Colors.black
                                                    : Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w200)),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  FractionalTranslation(
                      translation: Offset(0.0, -0.8),
                      child: Align(
                        child: Container(
                          width: 160,
                          height: 160,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                              myProjectModel == null
                                  ? myProjectModelInitial.url
                                  : myProjectModel.url,
                              fit: BoxFit.fill),
                        ),
                      ))
                ]),
              ],
            ),
          ),
        ])),
      ]),
    );
  }
}
