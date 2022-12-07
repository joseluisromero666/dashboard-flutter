//import 'package:argon_flutter/widgets/date_picker_widget.dart';
import 'dart:io';

import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/models/contractModel.dart';
import 'package:argon_flutter/models/projectModel.dart';
import 'package:argon_flutter/models/userModel.dart';
import 'package:argon_flutter/screens/profiles.dart';
import 'package:argon_flutter/services/accountService.dart';
import 'package:argon_flutter/services/contratosServices.dart';
import 'package:argon_flutter/services/projectServices.dart';
import 'package:argon_flutter/widgets/DatetimeRangePickerWidgetContract.dart';
import 'package:argon_flutter/widgets/button_widget.dart';
import 'package:argon_flutter/widgets/expandable-fab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;

import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class RegisterContracts extends StatefulWidget {
  @override
  _RegisterContractsState createState() => _RegisterContractsState();
}

final url = TextEditingController();
String proyecto;

class _RegisterContractsState extends State<RegisterContracts> {
  @override
  void initState() {
    typeMC = "Cliente";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
    Widget _buildProjectField() {
      String selected;
      return FutureBuilder(
          future: ProjectServices.getProjects(),
          builder: (context, snapshot) => snapshot.hasData
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
                          proyecto = v["name"];
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
              : Text(''));
    }

    Widget _buildContractorField() {
      String selected;
      return FutureBuilder(
          future: AccountService.getUsers(),
          builder: (context, snapshot) => snapshot.hasData
              ? DropdownButtonFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(FeatherIcons.bookmark),
                    hintText: "Contractor",
                  ),
                  value: selected,
                  items: snapshot.data
                      .map(
                        (user) => DropdownMenuItem<String>(
                          child: Text(
                            user["name"] + user["lastname"],
                            style: GoogleFonts.poppins(),
                          ),
                          value: user["id"],
                        ),
                      )
                      .toList()
                      .cast<DropdownMenuItem<String>>(),
                  onChanged: (value) {
                    setState(() {
                      selected = value;
                      snapshot.data.forEach((v) {
                        if (v["id"] == value) contractorMC = v;
                      });
                    });
                  },
                  validator: (String value) {
                    if (value == null) {
                      return "You have not selected a user";
                    }
                    return null;
                  },
                )
              : Text(''));
    }

    Widget _buildHiredField() {
      String selected;
      return FutureBuilder(
          future: AccountService.getUsers(),
          builder: (context, snapshot) => snapshot.hasData
              ? DropdownButtonFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(FeatherIcons.bookmark),
                    hintText: "Hired",
                  ),
                  value: selected,
                  items: snapshot.data
                      .map(
                        (user) => DropdownMenuItem<String>(
                          child: Text(
                            user["name"] + user["lastname"],
                            style: GoogleFonts.poppins(),
                          ),
                          value: user["id"],
                        ),
                      )
                      .toList()
                      .cast<DropdownMenuItem<String>>(),
                  onChanged: (value) {
                    setState(() {
                      selected = value;
                      snapshot.data.forEach((v) {
                        if (v["id"] == value) hiredMC = v;
                      });
                    });
                  },
                  validator: (String value) {
                    if (value == null) {
                      return "You have not selected a user";
                    }
                    return null;
                  },
                )
              : Text(''));
    }

    // ignore: unused_element
    Widget _buildTypeField({String type}) {
      String selected = "Cliente";
      return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          prefixIcon: Icon(FeatherIcons.bookmark),
          hintText: "Type",
        ),
        value: selected,
        items: [
          "Cliente",
          "Proveedor",
          "Empleado",
        ]
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
            typeMC = value;
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
                  Form(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          child: _buildTypeField(),
                          padding: const EdgeInsets.only(top: 16.0),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: _buildHiredField()),
                        typeMC == "Cliente"
                            ? Padding(
                                child: _buildContractorField(),
                                padding: const EdgeInsets.only(top: 16.0),
                              )
                            : SizedBox(),
                        typeMC == "Proveedor"
                            ? Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: TextFormField(
                                  controller: nombresMC,
                                  // ignore: missing_return
                                  validator: (valor) {
                                    if (valor.isEmpty) {
                                      return "Provider is empty";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(FeatherIcons.userPlus),
                                    hintText: 'Provider',
                                  ),
                                ),
                              )
                            : SizedBox(),
                        typeMC == "Empleado"
                            ? Padding(
                                child: _buildProjectField(),
                                padding: const EdgeInsets.only(top: 16.0),
                              )
                            : SizedBox(),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextFormField(
                            controller: valorMC,
                            // ignore: missing_return
                            validator: (valor) {
                              if (valor.isEmpty) {
                                return "value is empty";
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(FeatherIcons.dollarSign),
                              hintText: 'Value',
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        DatetimeRangePickerWidgetContract(),
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
                            if (regsCts == false)
                              {
                                _showMyDialog(context,
                                    "There is no consistency in the dates, please check. :)")
                              }
                            else
                              {
                                if (typeMC != "")
                                  {
                                    if (typeMC == "Cliente" &&
                                        valorMC.text != "" &&
                                        contractorMC != null &&
                                        hiredMC != null &&
                                        fromMC != "" &&
                                        untilMC != "")
                                      {
                                        Navigator.pushNamed(
                                            context, '/animation'),
                                        await _downloadLink(),
                                        myContractModelAdd = new ContractModel(
                                          active: true,
                                          apellidos: apellidosMC.text,
                                          id: "",
                                          managerId: myUserModel.id,
                                          idUser: hiredMC["id"],
                                          contractorId: contractorMC["id"],
                                          idOrganization: selectedCurrency,
                                          from: fromMC,
                                          until: untilMC,
                                          nombres: contractorMC["name"]
                                                  .toString()
                                                  .split(" ")[0] +
                                              " " +
                                              contractorMC["lastname"]
                                                  .toString()
                                                  .split(" ")[0],
                                          type: typeMC,
                                          url: urlMC.text,
                                          valor: valorMC.text,
                                          proyecto: "",
                                        ),
                                        ContratosServices.addNewContractModel(
                                            myContractModelAdd),
                                        Navigator.pushReplacementNamed(
                                            context, '/contracts')
                                      }
                                    else if (typeMC == "Empleado" &&
                                        valorMC.text != "" &&
                                        hiredMC != null &&
                                        fromMC != "" &&
                                        untilMC != "" &&
                                        proyecto != "" &&
                                        proyecto != null)
                                      {
                                        Navigator.pushNamed(
                                            context, '/animation'),
                                        await FirebaseFirestore.instance
                                            .collection('projects')
                                            .where("active", isEqualTo: true)
                                            .where("nombre",
                                                isEqualTo: proyecto)
                                            .get()
                                            .then(
                                                (QuerySnapshot querySnapshot) {
                                          querySnapshot.docs.forEach((doc) {
                                            List<String> provi = doc
                                                .get("idUser")
                                                .cast<String>();
                                            provi.contains(hiredMC["id"])
                                                ? print("same")
                                                : provi.add(hiredMC["id"]);
                                            contractProjectModel =
                                                new ProjectModel(
                                                    id: doc.get("id"),
                                                    from: doc.get("from"),
                                                    until: doc.get("until"),
                                                    categoria:
                                                        doc.get("categoria"),
                                                    nombre: doc.get("nombre"),
                                                    presupuesto:
                                                        doc.get("presupuesto"),
                                                    url: doc.get("url"),
                                                    cliente: doc.get("cliente"),
                                                    idUser: provi,
                                                    idOrganization: doc
                                                        .get("idOrganization"),
                                                    active: doc.get("active"));
                                            ProjectServices.modifyProject(
                                                contractProjectModel,
                                                contractProjectModel.nombre);
                                          });
                                        }),
                                        await _downloadLink(),
                                        myContractModelAdd = new ContractModel(
                                            active: true,
                                            apellidos: "",
                                            id: "",
                                            managerId: myUserModel.id,
                                            contractorId: "",
                                            idUser: hiredMC["id"],
                                            idOrganization: selectedCurrency,
                                            from: fromMC,
                                            until: untilMC,
                                            nombres: myUserModel.name,
                                            type: typeMC,
                                            url: urlMC.text,
                                            valor: valorMC.text,
                                            proyecto: proyecto),
                                        ContratosServices.addNewContractModel(
                                            myContractModelAdd),
                                        catergori = null,
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
                                            context, '/contracts')
                                      }
                                    else if (typeMC == "Proveedor" &&
                                        nombresMC.text != "" &&
                                        valorMC.text != "" &&
                                        hiredMC != null &&
                                        fromMC != "" &&
                                        untilMC != "")
                                      {
                                        Navigator.pushNamed(
                                            context, '/animation'),
                                        await _downloadLink(),
                                        myContractModelAdd = new ContractModel(
                                            active: true,
                                            apellidos: "",
                                            id: "",
                                            contractorId: "",
                                            managerId: myUserModel.id,
                                            idUser: hiredMC["id"],
                                            idOrganization: selectedCurrency,
                                            from: fromMC,
                                            until: untilMC,
                                            nombres: nombresMC.text,
                                            type: typeMC,
                                            url: urlMC.text,
                                            valor: valorMC.text,
                                            proyecto: ""),
                                        ContratosServices.addNewContractModel(
                                            myContractModelAdd),
                                        Navigator.pushReplacementNamed(
                                            context, '/contracts')
                                      }
                                    else
                                      {
                                        print(proyecto),
                                        print("Hay datos vacios"),
                                      }
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
          .child("/contracts$value.jpg")
          .putFile(io.File(pickedFile2.path), metadata);
      print("start movil");
    }

    final link = await FirebaseStorage.instance
        .ref("/contracts/$value.jpg")
        .getDownloadURL();
    urlMC.text = link;
  }
}
