import 'dart:ui';
import 'package:argon_flutter/models/projectModel.dart';
import 'package:argon_flutter/models/userModel.dart';
import 'package:argon_flutter/screens/profiles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class Sign_in extends StatefulWidget {
  final cardMargin;
  Sign_in({Key key, this.cardMargin}) : super(key: key);

  @override
  _Sign_inState createState() => _Sign_inState();
}

// ignore: camel_case_types
class _Sign_inState extends State<Sign_in> {
  // ignore: unused_field
  bool _checkboxValue = false;
  final passwordFocusNode = FocusNode();
//controller
  var _email = "";
  var _id;
  var _password = "";
  bool skip;
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;
  final double height = window.physicalSize.height;
  String animationType = 'idle';
  int countAnimation = 1;
  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        setState(() {
          animationType = 'hands_up';
        });
      } else {
        setState(() {
          animationType = 'hands_down';
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    //final IconTheme iconTheme = IconTheme.of(context);
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/register-bg.png"),
                  fit: BoxFit.cover)),
        ),
        SafeArea(
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 16, left: 24.0, right: 24.0, bottom: 32),
              child: Card(
                  elevation: 5,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  margin: widget.cardMargin,
                  child: Column(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor ==
                                      Colors.indigo[500]
                                  ? ArgonColors.white
                                  : Theme.of(context).primaryColor ==
                                          Colors.green[500]
                                      ? ArgonColors.black
                                      : Colors.blue[600],
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5, color: ArgonColors.muted))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                //aqui se hacen las validaciones para el tipo
                                child: Text("Sign In ",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor ==
                                                Colors.green[500]
                                            ? ArgonColors.white
                                            : Theme.of(context).primaryColor ==
                                                    Colors.indigo[500]
                                                ? ArgonColors.text
                                                : ArgonColors.black,
                                        fontSize: 32.0)),
                              )),

                              // Divider()
                            ],
                          )),
                      Container(
                          color: Theme.of(context).primaryColor ==
                                  Colors.indigo[500]
                              ? ArgonColors.white
                              : Theme.of(context).primaryColor ==
                                      Colors.green[500]
                                  ? ArgonColors.black
                                  : Colors.blue[600],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    height: 200,
                                    width: 300,
                                    child: FlareActor(
                                      'assets/Teddy.flr',
                                      alignment: Alignment.bottomCenter,
                                      fit: BoxFit.contain,
                                      animation: animationType,
                                      callback: (animation) {
                                        setState(() {
                                          animationType = 'idle';
                                        });
                                      },
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: "Email",
                                            hintStyle: textTheme.bodyText2,
                                            prefixIcon: Icon(Icons.email),
                                          ),
                                          onChanged: (email) {
                                            this._email = email;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                            obscureText: true,
                                            decoration: InputDecoration(
                                                hintText: "Password",
                                                hintStyle: textTheme.bodyText2,
                                                prefixIcon: Icon(Icons.lock)),
                                            onChanged: (password) {
                                              this._password = password;
                                            },
                                            focusNode: passwordFocusNode),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Center(
                                      // ignore: deprecated_member_use
                                      child: FlatButton(
                                        textColor: ArgonColors.white,
                                        color: ArgonColors.primary,
                                        onPressed: () {
                                          if (_password == "" ||
                                              _email == "" ||
                                              EmailValidator.validate(_email) ==
                                                  false) {
                                            _showMyDialog(context,
                                                "There is no consistency in the Email or Pasword, please check. :)");
                                          } else {
                                            signInWithEmailAndPassword();
                                          }
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 16.0,
                                                right: 16.0,
                                                top: 12,
                                                bottom: 12),
                                            child: Text("Sign in",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0))),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ))
                    ],
                  )),
            ),
          ]),
        )
      ],
    ));
  }

  Future<void> getUserData(String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value) => {
                setState(() {
                  _email = value.data()['email'];
                  _id = value.data()['id'];
                })
              });
    } catch (e) {
      print(e.toString());
    }
  }

  var length;
  var count;
  Future<void> signInWithEmailAndPassword() async {
    bool exitoTime = false;
    bool exitoProject = false;
    bool exitoContract = false;
    Map<String, Map<String, bool>> time;
    Map<String, Map<String, bool>> pro;
    Map<String, Map<String, bool>> cont;
    organizationsTemp = [];
    myUserModel = null;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _email.toString(), password: _password.toString());
      await getUserData(userCredential.user.uid);
      selectedCurrency = "";
      if (userCredential.user.uid == _id) {
        setState(() {
          animationType = "success";
        });
      }
      Navigator.pushNamed(context, '/animation');
      await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: userCredential.user.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          for (int i = 0; i < doc["organizations"].length; i++) {
            var organization;
            var rol;
            await doc["organizations"][i]["organization"]
                .get()
                .then((org) => organization = org.id);
            await doc["organizations"][i]["rol"].get().then((r) => rol = r.id);
            organizationsTemp.add({"organization": organization, "rol": rol});
            if (i == doc["organizations"].length - 1) {
              exito = false;
              selectedCurrency = organizationsTemp[0]["organization"];
              for (var i = 0; i < organizationsTemp.length; i++) {
                if (organizationsTemp[i]["organization"] == selectedCurrency) {
                  await FirebaseFirestore.instance
                      .collection('roles')
                      .where("active", isEqualTo: true)
                      .where("id", isEqualTo: organizationsTemp[i]["rol"])
                      .where("name", isEqualTo: "Time Tracking")
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                    querySnapshot.docs.forEach((doc) {
                      exitoTime = true;
                      time = {
                        "time_tracking": {
                          "time_tracking_create":
                              doc.get("permissions")["time_tracking_create"],
                          "time_tracking_delete":
                              doc.get("permissions")["time_tracking_delete"],
                          "time_tracking_exports":
                              doc.get("permissions")["time_tracking_exports"],
                          "time_tracking_read":
                              doc.get("permissions")["time_tracking_read"],
                          "time_tracking_update":
                              doc.get("permissions")["time_tracking_update"]
                        }
                      };
                    });
                  });
                }
              }
              for (var i = 0; i < organizationsTemp.length; i++) {
                if (organizationsTemp[i]["organization"] == selectedCurrency) {
                  await FirebaseFirestore.instance
                      .collection('roles')
                      .where("active", isEqualTo: true)
                      .where("id", isEqualTo: organizationsTemp[i]["rol"])
                      .where("name", isEqualTo: "projects")
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                    querySnapshot.docs.forEach((doc) {
                      exitoProject = true;
                      pro = {
                        "projects": {
                          "projects_create":
                              doc.get("permissions")["projects_create"],
                          "projects_delete":
                              doc.get("permissions")["projects_delete"],
                          "projects_exports":
                              doc.get("permissions")["projects_exports"],
                          "projects_read":
                              doc.get("permissions")["projects_read"],
                          "projects_update":
                              doc.get("permissions")["projects_update"]
                        }
                      };
                    });
                  });
                }
              }
              for (var i = 0; i < organizationsTemp.length; i++) {
                if (organizationsTemp[i]["organization"] == selectedCurrency) {
                  await FirebaseFirestore.instance
                      .collection('roles')
                      .where("active", isEqualTo: true)
                      .where("id", isEqualTo: organizationsTemp[i]["rol"])
                      .where("name", isEqualTo: "contracts")
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                    querySnapshot.docs.forEach((doc) {
                      exitoContract = true;
                      cont = {
                        "contracts": {
                          "contracts_create":
                              doc.get("permissions")["contracts_create"],
                          "contracts_delete":
                              doc.get("permissions")["contracts_delete"],
                          "contracts_exports":
                              doc.get("permissions")["contracts_exports"],
                          "contracts_read":
                              doc.get("permissions")["contracts_read"],
                          "contracts_update":
                              doc.get("permissions")["contracts_update"]
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
              myUserModel = new UserModel(
                  id: doc["id"],
                  name: doc["name"],
                  lastname: doc["lastname"],
                  email: doc["email"],
                  manager: doc["manager"],
                  organizations: organizationsTemp,
                  roles: [time, pro, cont]);

              catergori = null;
              catergori = ["NaN"];
              misMaps = [];
              await FirebaseFirestore.instance
                  .collection('projects')
                  .where("active", isEqualTo: true)
                  .where("idOrganization", isEqualTo: selectedCurrency)
                  .get()
                  .then((QuerySnapshot querySnapshot) {
                querySnapshot.docs.forEach((doc) {
                  for (var i = 0; i < doc['idUser'].length; i++) {
                    if (doc['idUser'][i] == myUserModel.id) {
                      misMaps.add(doc);
                      catergori.add(doc.get("nombre"));
                      print(doc.get("id"));
                    }
                  }
                });
              });
              (myUserModel.manager == "")
                  ? Navigator.pushNamed(context, '/home')
                  : Navigator.pushNamed(context, '/TimeTracking');
            } else {}
          }
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          animationType = "fail";
        });
        _showMyDialog(context,
            "There is no consistency in the Email or Pasword, please check. :)");
      } else if (e.code == 'wrong-password') {
        setState(() {
          animationType = "fail";
        });
        _showMyDialog(context,
            "There is no consistency in the Email or Pasword, please check. :)");
      }
    }
  }

  Widget _buildCupertinoAlertDialog(String texto) {
    return CupertinoAlertDialog(
      title: Text('Error'),
      content: Text(texto),
      actions: [
        TextButton(
            child: Text("Aceptar"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }

  Future _showMyDialog(BuildContext context, String texto) async {
    return showCupertinoDialog(
      context: context,
      builder: (_) => _buildCupertinoAlertDialog(texto),
    );
  }
}
