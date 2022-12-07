import 'dart:io';
import 'dart:async';

import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/models/projectModel.dart';
import 'package:argon_flutter/models/userModel.dart';
import 'package:argon_flutter/screens/profiles.dart';
import 'package:argon_flutter/services/projectServices.dart';
import 'package:argon_flutter/widgets/DatetimeRangePickerWidgetProject.dart';
import 'package:argon_flutter/widgets/button_widget.dart';
import 'package:argon_flutter/widgets/expandable-fab.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;

class RegisterProject extends StatefulWidget {
  @override
  _RegisterProjectState createState() => _RegisterProjectState();
}

class _RegisterProjectState extends State<RegisterProject> {
  Color currentColor = Colors.limeAccent;
  void changeColor(Color color) => setState(() => currentColor = color);

  var textController = TextEditingController(text: '2F19DB');

  int diffDays;
  DateTime f;
  DateTime u;
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

  final _formKey = GlobalKey<FormState>();

  // ignore: unused_element
  Widget _buildCategoryField() {
    String selected;
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
          category.text = value;
          // selected = value;
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
    return Scaffold(
        appBar: ResponsiveLayout.isPhone(context)
            ? Navbar(
                avatar: true,
                backPage: "home",
                backButton: true,
                bgColor: ArgonColors.initial,
                prefferedHeight: 60,
              )
            : null,
        backgroundColor: Theme.of(context).primaryColor == Colors.green[500]
            ? Colors.grey[800]
            : Theme.of(context).primaryColor == Colors.indigo[500]
                ? ArgonColors.white
                : Colors.blue[800],
        body: Container(
            padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 8.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: imG == null
                              ? Image.network(
                                  'https://i.ibb.co/jHZH3WN/file.png',
                                  width: 140,
                                  height: 130,
                                  fit: BoxFit.fill,
                                )
                              : Container(
                                  width: (kIsWeb) ? 300 : 140,
                                  height: 130,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: imG,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextFormField(
                            controller: name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(FeatherIcons.zap),
                              hintText: 'Project Name',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextFormField(
                            controller: customer,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(FeatherIcons.user),
                              hintText: 'Customer',
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        _buildCategoryField(),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextFormField(
                            controller: budget,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(FeatherIcons.dollarSign),
                              hintText: 'Budget',
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        DatetimeRangePickerWidgetProject(),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: ButtonWidgett(
                          mColor: Color(0xFF8BC34A),
                          text: "save",
                          onClicked: () async => {
                            if (regsPr == false)
                              {
                                _showMyDialog(context,
                                    "There is no consistency in the dates, please check. :)")
                              }
                            else
                              {
                                if (imG != null &&
                                    customer.text != "" &&
                                    category.text != "" &&
                                    name.text != "" &&
                                    budget.text != "" &&
                                    textController.text != "" &&
                                    fromM != "" &&
                                    untilM != "")
                                  {
                                    Navigator.pushNamed(context, '/animation'),
                                    await _downloadLink(),
                                    myCreateProjectModel = new ProjectModel(
                                        id: "",
                                        idUser: [myUserModel.id],
                                        idOrganization: selectedCurrency,
                                        categoria: category.text,
                                        nombre: name.text,
                                        presupuesto: budget.text,
                                        url: url.text,
                                        cliente: customer.text,
                                        from: fromM,
                                        until: untilM,
                                        active: true),
                                    ProjectServices.addNewProjectModel(
                                        myCreateProjectModel),
                                    catergori = null,
                                    catergori = ["NaN"],
                                    misMaps = [],
                                    await FirebaseFirestore.instance
                                        .collection('projects')
                                        .where("active", isEqualTo: true)
                                        .where("idOrganization",
                                            isEqualTo: selectedCurrency)
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                      querySnapshot.docs.forEach((doc) {
                                        for (var i = 0;
                                            i < doc['idUser'].length;
                                            i++) {
                                          if (doc['idUser'][i] ==
                                              myUserModel.id) {
                                            misMaps.add(doc);
                                            catergori.add(doc.get("nombre"));
                                          }
                                        }
                                      });
                                    }),
                                    imG = null,
                                    fromM = "",
                                    untilM = "",
                                    category = TextEditingController(),
                                    name = TextEditingController(),
                                    budget = TextEditingController(),
                                    url = TextEditingController(),
                                    customer = TextEditingController(),
                                    Navigator.pushReplacementNamed(
                                        context, '/home'),
                                  }
                                else
                                  {
                                    _showMyDialog(context,
                                        "There are empty fields, please verify. :)")
                                  }
                              }
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
                            // Respond to button press
                            imG = null,
                            fromM = "",
                            untilM = "",
                            category = TextEditingController(),
                            name = TextEditingController(),
                            budget = TextEditingController(),
                            url = TextEditingController(),
                            customer = TextEditingController(),
                            ResponsiveLayout.isPhone(context)
                                ? Navigator.pushReplacementNamed(
                                    context, '/home')
                                : Navigator.pushReplacementNamed(
                                    context, '/home'),
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
                    icon: Icon(FeatherIcons.camera, color: ArgonColors.white))
                : SizedBox(height: 20.0),
            ActionButton(
              onPressed: getImageGallery,
              icon: Icon(FeatherIcons.folderPlus, color: ArgonColors.white),
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
    url.text = link;
  }
}
