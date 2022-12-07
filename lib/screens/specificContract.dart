import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/models/contractModel.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';

class SpecificContract extends StatefulWidget {
  @override
  _SpecificContractState createState() => _SpecificContractState();
}

class _SpecificContractState extends State<SpecificContract> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveLayout.isPhone(context)
          ? Navbar(
              avatar: true,
              backPage: "contracts",
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
                              Align(
                                child: Text("Type",
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
                                        "[" + myContractModel.type + "]",
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
                                child: Text("Contractor",
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
                                      myContractModel.type == "Empleado"
                                          ? "[" +
                                              myContractModelInitial.proyecto +
                                              "]"
                                          : "[" + myContractModel.nombres + "]",
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
                                        myContractModel == null
                                            ? "[" +
                                                myContractModelInitial.from +
                                                "]"
                                            : "[" + myContractModel.from + "]",
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
                                        myContractModel == null
                                            ? "[" +
                                                myContractModelInitial.until +
                                                "]"
                                            : "[" + myContractModel.until + "]",
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
                                child: Text("Value",
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
                                        myContractModel == null
                                            ? "[" +
                                                myContractModelInitial.valor +
                                                "]"
                                            : "[" + myContractModel.valor + "]",
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
                              myContractModel == null
                                  ? myContractModelInitial.url
                                  : myContractModel.url,
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
