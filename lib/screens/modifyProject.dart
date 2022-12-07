import 'dart:io';

import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/models/projectModel.dart';
import 'package:argon_flutter/models/userModel.dart';
import 'package:argon_flutter/screens/profiles.dart';
import 'package:argon_flutter/services/projectServices.dart';
import 'package:argon_flutter/widgets/DatetimeRangePickerWidgetModifyProject.dart';
import 'package:argon_flutter/widgets/button_widget.dart';
import 'package:argon_flutter/widgets/expandable-fab.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' as io;

import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ModifyProject extends StatefulWidget {
  @override
  _ModifyProjectState createState() => _ModifyProjectState();
}

bool kIsWeb = identical(0, 0.0);
String prueba;
String prueba2;

class _ModifyProjectState extends State<ModifyProject> {
  Widget _buildCategoryField() {
    String selected = catergory[catergory.indexOf(myProjectModel.categoria)];

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        prefixIcon: Icon(FeatherIcons.bookOpen),
        hintText: "Category",
      ),
      value: selected,
      items: catergory
          .map(
            (label) => DropdownMenuItem(
              child: Text(
                label,
                style: GoogleFonts.poppins(),
              ),
              value: label,
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          selected = value;
          categoryMo.text = value;
          prueba2 = value;
        });
      },
      validator: (String value) {
        if (value == null) {
          return "You have not selected a project";
        }
        return null;
      },
    );
  }

  List<String> catergory = [
    "Software",
    "Construction",
    "Energy",
    "Mining",
    "Transformation",
    "Environment",
    "Industrial",
    "Services",
    "Finance",
  ];
  @override
  Widget build(BuildContext context) {
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

    //   void changeUrl(var url) => setState(() => urlMo.text = url);
    nameMo.text = myProjectModel.nombre;
    categoryMo.text = myProjectModel.categoria;
    budgetMo.text = myProjectModel.presupuesto;
    fromMo = myProjectModel.from;
    untilMo = myProjectModel.until;
    idMo = myProjectModel.id;
    oldNam = myProjectModel.nombre;
    urlMo.text = myProjectModel.url;
    customerMo.text = myProjectModel.cliente;
    prueba = myProjectModel.categoria;
    return Scaffold(
        appBar: ResponsiveLayout.isPhone(context)
            ? Navbar(
                avatar: true,
                backPage: "home",
                title: "Modify Project",
                backButton: true,
                bgColor: ArgonColors.initial,
                prefferedHeight: 60,
              )
            : null,
        backgroundColor: Theme.of(context).primaryColor == Colors.green[500]
            ? Colors.grey[900]
            : Theme.of(context).primaryColor == Colors.indigo[500]
                ? ArgonColors.white
                : Colors.blue[800],
        body: Container(
            padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'OLD',
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 20),
                          ),
                          Center(
                            child: Container(
                              width: 70,
                              height: 70,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(myProjectModel.url,
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "NEW",
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 20),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: imG == null
                                ? Image.network(
                                    'https://i.ibb.co/jHZH3WN/file.png',
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.fill,
                                  )
                                : Container(
                                    height: 70,
                                    width: 70,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: imG,
                                  ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Form(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextField(
                            controller: nameMo,
                            decoration: InputDecoration(
                              prefixIcon: Icon(FeatherIcons.zap),
                              hintText: "Name",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextField(
                            controller: customerMo,
                            decoration: InputDecoration(
                              prefixIcon: Icon(FeatherIcons.user),
                              hintText: "Customer",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: _buildCategoryField(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextField(
                            controller: budgetMo,
                            decoration: InputDecoration(
                              prefixIcon: Icon(FeatherIcons.dollarSign),
                              hintText: "Budget",
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        DatetimeRangePickerWidgetModifyProject(),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: ButtonWidgett(
                          mColor: Color(0xFF8BC34A),
                          text: "Save",
                          onClicked: () async => {
                            if (editPr == false)
                              {
                                _showMyDialog(context,
                                    "There is no consistency in the dates, please check. :)")
                              }
                            else
                              {
                                if (imG != null)
                                  {
                                    if (urlMo.text != "" &&
                                        customerMo.text != "" &&
                                        fromMo != "" &&
                                        untilMo != "" &&
                                        categoryMo.text != "" &&
                                        nameMo.text != "" &&
                                        budgetMo.text != "")
                                      {
                                        Navigator.pushNamed(
                                            context, '/animation'),
                                        await _downloadLink(),
                                        myModifyProjectModel = new ProjectModel(
                                            id: myProjectModel.id,
                                            from: fromMo,
                                            until: untilMo,
                                            idOrganization:
                                                myProjectModel.idOrganization,
                                            idUser: myProjectModel.idUser,
                                            categoria: prueba2 == null
                                                ? categoryMo.text
                                                : prueba2,
                                            nombre: nameMo.text,
                                            presupuesto: budgetMo.text,
                                            url: urlMo.text,
                                            cliente: customerMo.text,
                                            active: myProjectModel.active),
                                        await ProjectServices.modifyProject(
                                            myModifyProjectModel, oldNam),
                                        catergori = null,
                                        prueba2 = null,
                                        catergori = ["NaN"],
                                        misMaps = [],
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
                                        }),
                                        Navigator.pushReplacementNamed(
                                            context, '/home')
                                      }
                                    else
                                      {
                                        _showMyDialog(context,
                                            "There are empty fields, please verify. :)")
                                      }
                                  }
                                else
                                  {
                                    if (urlMo.text != "" &&
                                        customerMo.text != "" &&
                                        fromMo != "" &&
                                        untilMo != "" &&
                                        categoryMo.text != "" &&
                                        nameMo.text != "" &&
                                        budgetMo.text != "")
                                      {
                                        Navigator.pushNamed(
                                            context, '/animation'),
                                        myModifyProjectModel = new ProjectModel(
                                            id: myProjectModel.id,
                                            from: fromMo,
                                            until: untilMo,
                                            categoria: prueba2 == null
                                                ? categoryMo.text
                                                : prueba2,
                                            idOrganization:
                                                myProjectModel.idOrganization,
                                            idUser: myProjectModel.idUser,
                                            nombre: nameMo.text,
                                            presupuesto: budgetMo.text,
                                            url: urlMo.text,
                                            cliente: customerMo.text,
                                            active: myProjectModel.active),
                                        await ProjectServices.modifyProject(
                                            myModifyProjectModel,
                                            myProjectModel.nombre),
                                        catergori = null,
                                        prueba2 = null,
                                        catergori = ["NaN"],
                                        misMaps = [],
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
                                                catergori.add(
                                                    misMaps[i].get("nombre"));
                                                print(doc.get("id"));
                                              }
                                            }
                                          });
                                        }),
                                        Navigator.pushReplacementNamed(
                                            context, '/home')
                                      }
                                    else
                                      {
                                        _showMyDialog(context,
                                            "There are empty fields, please verify. :)")
                                      }
                                  }
                              },
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text("      "),
                      const SizedBox(width: 5),
                      Expanded(
                        child: ButtonWidgett(
                          mColor: Color(0xFFC62626),
                          text: "Cancel",
                          onClicked: () => {
                            ResponsiveLayout.isPhone(context)
                                ? Navigator.pushReplacementNamed(
                                    context, '/home')
                                : Navigator.pushReplacementNamed(
                                    context, '/home')
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        floatingActionButton: ExpandableFab(
          distance: 50,
          children: [
            !(kIsWeb)
                ? ActionButton(
                    onPressed: getImageCamera,
                    icon: Icon(
                      FeatherIcons.camera,
                      color: Theme.of(context).primaryColor == Colors.green[500]
                          ? Colors.grey[800]
                          : Theme.of(context).primaryColor == Colors.indigo[500]
                              ? ArgonColors.white
                              : Colors.purple[300],
                    ))
                : SizedBox(height: 20.0),
            ActionButton(
              onPressed: getImageGallery,
              icon: Icon(FeatherIcons.folderPlus,
                  color: Theme.of(context).primaryColor == Colors.green[500]
                      ? Colors.white
                      : Theme.of(context).primaryColor == Colors.indigo[500]
                          ? ArgonColors.white
                          : Colors.white),
            )
          ],
        ));
  }

  bool kIsWeb = identical(0, 0.0);
  String uuid;
  Image imG;
  File image;
  final picker = ImagePicker();
  var pickedFile2;
  Future getImageCamera() async {
    try {
      // ignore: deprecated_member_use
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      pickedFile2 = pickedFile;
      if (kIsWeb) {
        setState(() {
          if (pickedFile != null) {
            imG = Image.network(pickedFile.path);
            print("web");
          } else {
            print('No image selected.');
          }
        });
      } else {
        setState(() {
          if (pickedFile != null) {
            imG = Image.file(File(pickedFile.path));
            print("movil");
          } else {}
        });
      }
    } catch (e) {
      print('No image camera.');
    }
  }

  Future getImageGallery() async {
    try {
      // ignore: deprecated_member_use
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      pickedFile2 = pickedFile;
      if (kIsWeb) {
        setState(() {
          if (pickedFile != null) {
            imG = Image.network(pickedFile.path);
            print("web");
          } else {
            print('No image selected.');
          }
        });
      } else {
        setState(() {
          if (pickedFile != null) {
            imG = Image.file(File(pickedFile.path));
            print("movil");
          } else {}
        });
      }
    } catch (e) {
      print('No image camera.');
    }
  }

  var archivo;
  Reference ref;
  Future<void> _downloadLink() async {
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': pickedFile2.path});
    print("start");
    var value = Uuid().v1();
    if (kIsWeb) {
      archivo = await FirebaseStorage.instance
          .ref()
          .child("/projects/$value.jpg")
          .putData(await pickedFile2.readAsBytes(), metadata);

      print("start web ");
    } else {
      await FirebaseStorage.instance
          .ref()
          .child("/projects/$value.jpg")
          .putFile(io.File(pickedFile2.path), metadata);
      print("start movil");
    }

    final link = await FirebaseStorage.instance
        .ref("/projects/$value.jpg")
        .getDownloadURL();
    urlMo.text = link;
  }
}
