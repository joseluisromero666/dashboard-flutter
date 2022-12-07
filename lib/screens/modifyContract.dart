import 'dart:io';

import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/models/contractModel.dart';
import 'package:argon_flutter/services/contratosServices.dart';
import 'package:argon_flutter/services/projectServices.dart';
import 'package:argon_flutter/widgets/DatetimeRangePickerWidgetModifyContract.dart';
import 'package:argon_flutter/widgets/button_widget.dart';
import 'package:argon_flutter/widgets/expandable-fab.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;
import 'package:uuid/uuid.dart';

class ModifyContract extends StatefulWidget {
  @override
  _ModifyContractState createState() => _ModifyContractState();
}

class _ModifyContractState extends State<ModifyContract> {
  @override
  void initState() {
    super.initState();
  }

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

    urlMCMod.text = myContractModel.url;
    nombresMCMod.text = myContractModel.nombres;
    apellidosMCMod.text = myContractModel.apellidos;
    typeMCMod = myContractModel.type;
    fromMCMod = myContractModel.from;
    untilMCMod = myContractModel.until;
    valorMCMod.text = myContractModel.valor;
    proyectoMCMod = myContractModel.proyecto;
    idMC = myContractModel.id;
    activeMC = myContractModel.active;
    Future _showMyDialog(BuildContext context, String texto) async {
      return showCupertinoDialog(
        context: context,
        builder: (_) => _buildCupertinoAlertDialog(texto),
      );
    }

    // ignore: unused_element
    Widget _buildProjectField() {
      return FutureBuilder(
          future: ProjectServices.getProjects(),
          builder: (context, snapshot) {
            String selected;
            snapshot.hasData
                ? snapshot.data.forEach((v) {
                    if (v["name"] == proyectoMCMod) {
                      selected = v["id"];
                    }
                  })
                // ignore: unnecessary_statements
                : null;
            return snapshot.hasData
                ? DropdownButtonFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(FeatherIcons.bookmark),
                      hintText: "Project",
                    ),
                    value: selected,
                    items: snapshot.data
                        .map(
                          (project) => DropdownMenuItem<String>(
                            child: Text(
                              project["name"],
                              style: GoogleFonts.poppins(),
                            ),
                            value: project["id"],
                          ),
                        )
                        .toList()
                        .cast<DropdownMenuItem<String>>(),
                    onChanged: (value) {
                      setState(() {
                        selected = value;
                        snapshot.data.forEach((v) {
                          if (v["id"] == value) {
                            myContractModel.proyecto = v["name"];
                            selected = v["id"];
                          }
                        });
                      });
                    },
                    validator: (String value) {
                      if (value == null) {
                        return "You have not selected a project";
                      }
                      return null;
                    },
                  )
                : Text('');
          });
    }

    // ignore: unused_element
    Widget _buildTypeField({String type}) {
      List<String> types = [
        "Proveedor",
        "Empleado",
        "Cliente",
      ];
      String selected = types[types.indexOf(typeMCMod)];

      return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          prefixIcon: Icon(FeatherIcons.bookmark),
          hintText: "Type",
        ),
        value: selected,
        items: types
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
            myContractModel.type = value;
          });
        },
        validator: (String value) {
          if (value == null) {
            return "You have not selected a type";
          }
          return null;
        },
      );
    }

    return Scaffold(
        appBar: ResponsiveLayout.isPhone(context)
            ? Navbar(
                avatar: true,
                backPage: "contracts",
                title: "Modify Contract",
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
                  SizedBox(height: 20.0),
                  SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'OLD',
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 20),
                                  ),
                                  Center(
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(myContractModel.url,
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "NEW",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 20),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: imG == null
                                        ? Image.network(
                                            'https://i.ibb.co/jHZH3WN/file.png',
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.fill,
                                          )
                                        : Container(
                                            height: 60,
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Form(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 8.0),
                        typeMCMod == "Empleado"
                            ? _buildProjectField()
                            : SizedBox(),
                        SizedBox(height: 8.0),
                        _buildTypeField(),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextFormField(
                            controller: valorMCMod,
                            decoration: InputDecoration(
                              prefixIcon: Icon(FeatherIcons.dollarSign),
                              hintText: 'Value',
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        DatetimeRangePickerWidgetModifyContract(),
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
                            if (editCts == false)
                              {
                                _showMyDialog(context,
                                    "There is no consistency in the dates, please check. :)")
                              }
                            else
                              {
                                if (imG != null)
                                  {
                                    if (urlMCMod.text != "" &&
                                            typeMCMod != "" &&
                                            fromMCMod != "" &&
                                            untilMCMod != "" &&
                                            valorMCMod.text != "" ||
                                        (typeMCMod == "Empleado" &&
                                            proyectoMCMod != ""))
                                      {
                                        Navigator.pushNamed(
                                            context, '/animation'),
                                        await _downloadLink(),
                                        myContractModelMod = new ContractModel(
                                            id: idMC,
                                            active: activeMC,
                                            apellidos: apellidosMCMod.text,
                                            from: fromMCMod,
                                            nombres: nombresMCMod.text,
                                            proyecto: proyectoMCMod,
                                            type: typeMCMod,
                                            until: untilMCMod,
                                            url: urlMCMod.text,
                                            valor: valorMCMod.text),
                                        ContratosServices.modifyContract(
                                            myContractModelMod,
                                            myContractModel.id),
                                        Navigator.pushReplacementNamed(
                                            context, '/contracts'),
                                        projectsMC = ["NaN"],
                                      }
                                    else
                                      {
                                        Text("Hay datos vacios"),
                                      }
                                  }
                                else
                                  {
                                    if (urlMCMod.text != "" &&
                                            typeMCMod != "" &&
                                            fromMCMod != "" &&
                                            untilMCMod != "" &&
                                            valorMCMod.text != "" ||
                                        (typeMCMod == "Empleado" &&
                                            proyectoMCMod != ""))
                                      {
                                        Navigator.pushNamed(
                                            context, '/animation'),
                                        myContractModelMod = new ContractModel(
                                            id: idMC,
                                            active: activeMC,
                                            apellidos: apellidosMCMod.text,
                                            from: fromMCMod,
                                            nombres: nombresMCMod.text,
                                            proyecto: proyectoMCMod,
                                            type: typeMCMod,
                                            until: untilMCMod,
                                            url: urlMCMod.text,
                                            valor: valorMCMod.text),
                                        ContratosServices.modifyContract(
                                            myContractModelMod,
                                            myContractModel.id),
                                        Navigator.pushReplacementNamed(
                                            context, '/contracts'),
                                        projectsMC = ["NaN"],
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
                            projectsMC = ["NaN"],
                            if (ResponsiveLayout.isPhone(context))
                              Navigator.pushReplacementNamed(
                                  context, '/contracts')
                            else
                              Navigator.pushReplacementNamed(
                                  context, '/contracts')
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
                      color: ArgonColors.white,
                    ))
                : SizedBox(height: 20.0),
            ActionButton(
              onPressed: getImageGallery,
              icon: Icon(
                FeatherIcons.folderPlus,
                color: ArgonColors.white,
              ),
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
          .child("/contracts/$value.jpg")
          .putData(await pickedFile2.readAsBytes(), metadata);

      print("start web ");
    } else {
      await FirebaseStorage.instance
          .ref()
          .child("/contracts/$value.jpg")
          .putFile(io.File(pickedFile2.path), metadata);
      print("start movil");
    }

    final link = await FirebaseStorage.instance
        .ref("/contracts/$value.jpg")
        .getDownloadURL();
    urlMCMod.text = link;
  }
}
