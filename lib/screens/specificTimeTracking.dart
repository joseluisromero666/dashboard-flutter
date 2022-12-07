import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/models/TimeTracking.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';

//widgets
// ignore: must_be_immutable
class SpecificTimeTracking extends StatefulWidget {
  @override
  _SpecificTimeTrackingState createState() => _SpecificTimeTrackingState();
}

class _SpecificTimeTrackingState extends State<SpecificTimeTracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveLayout.isPhone(context)
          ? Navbar(
              avatar: true,
              backPage: back,
              rightOptions: false,
              bgColor: ArgonColors.initial,
              prefferedHeight: 60,
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
            padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0),
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
                                child: Text("Task",
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
                                        myTimeTrackingModel == null
                                            ? "[" +
                                                myTimeTrackingModelInitial
                                                    .nomTarea +
                                                "]"
                                            : "[" +
                                                myTimeTrackingModel.nomTarea +
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
                                            fontSize: 20.0)),
                                  )),
                              Divider(
                                height: 40.0,
                                thickness: 1.5,
                                indent: 32.0,
                                endIndent: 32.0,
                              ),
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
                                      myTimeTrackingModel == null
                                          ? "[" +
                                              myTimeTrackingModelInitial
                                                  .proyecto +
                                              "]"
                                          : "[" +
                                              myTimeTrackingModel.proyecto +
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
                                          fontSize: 20.0)),
                                ),
                              ),
                              Divider(
                                height: 40.0,
                                thickness: 1.5,
                                indent: 32.0,
                                endIndent: 32.0,
                              ),
                              Align(
                                child: Text("Description",
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
                                      myTimeTrackingModel == null
                                          ? "[" +
                                              myTimeTrackingModelInitial
                                                  .descripcion +
                                              "]"
                                          : "[" +
                                              myTimeTrackingModel.descripcion +
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
                                          fontSize: 20.0)),
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
                                        myTimeTrackingModel == null
                                            ? "[" +
                                                myTimeTrackingModelInitial
                                                    .from +
                                                "]"
                                            : "[" +
                                                myTimeTrackingModel.from +
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
                                            fontSize: 20.0)),
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
                                        myTimeTrackingModel == null
                                            ? "[" +
                                                myTimeTrackingModelInitial
                                                    .until +
                                                "]"
                                            : "[" +
                                                myTimeTrackingModel.until +
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
                                            fontSize: 20.0)),
                                  )),
                              SizedBox(height: 10.0),
                              Divider(
                                height: 40.0,
                                thickness: 1.5,
                                indent: 32.0,
                                endIndent: 32.0,
                              ),
                              Align(
                                child: Text("Comment",
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
                                        myTimeTrackingModel == null
                                            ? "[" +
                                                myTimeTrackingModelInitial
                                                    .comentario +
                                                "]"
                                            : "[" +
                                                myTimeTrackingModel.comentario +
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
                                            fontSize: 20.0)),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ])),
      ]),
    );
  }
}
