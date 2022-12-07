import 'dart:io';
import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/models/TimeTracking.dart';
import 'package:argon_flutter/models/reportsProvider.dart';
import 'package:argon_flutter/models/userModel.dart';
import 'package:argon_flutter/screens/profiles.dart';
import 'package:argon_flutter/services/projectServices.dart';
import 'package:argon_flutter/services/timeTrackingServices.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/expandable-fabReports.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'PdfPreviewScreen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart' as html;
//widgets
import 'package:flutter/painting.dart';

import 'modifyTimeTracking.dart';

const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const PdfColor green = PdfColor.fromInt(0xff9ce5d0);

class Home extends StatefulWidget {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  _HomeState createState() => _HomeState();
}

var pdf = pw.Document();
File file;
bool kIsWeb = identical(0, 0.0);
final bytes = pdf.save();
final blob = html.Blob([bytes], 'application/pdf');
String paragraph = "";
var page;
var a = ["NaN", "sss"];

class _HomeState extends State<Home> {
  String espacios(int numero, String valor) {
    String t = "";
    int one = (30 - numero);
    for (var i = 0; i < one; i++) {
      t += " ";
    }
    return valor + t;
  }

  a(doc) {
    String temp = espacios(doc["from"].length, doc["from"]) +
        espacios(doc["until"].length, doc["until"]) +
        espacios(doc["nomTarea"].length, doc["nomTarea"]) +
        "\n\n";
    paragraph += temp;
  }

  writeOnPdf(String a) {
    page = pw.MultiPage(
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

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    file = File("$documentPath/example.pdf");

    file.writeAsBytesSync(await pdf.save());
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  String proyecto;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ResponsiveLayout.isPhone(context)
            ? Navbar(
                avatar: true,
                transparent: false,
                prefferedHeight: 60,
                bgColor: ArgonColors.initial,
              )
            : null,
        drawer: ArgonDrawer(currentPage: "Reports"),
        body: Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.only(left: 4.5, right: 4.5),
                    child: Column(
                      children: [_buildProjectField()],
                    )),
                SizedBox(height: 20.0),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('timeTracking')
                              .where("active", isEqualTo: true)
                              .where("idUser", isEqualTo: myUserModel.id)
                              .where("idOrganization",
                                  isEqualTo: selectedCurrency)
                              .where("proyecto", isEqualTo: proyecto)
                              .snapshots(),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? (snapshot.data.docs.length != 0
                                    ? Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ...snapshot.data.docs
                                              .map((doc) {
                                                return Card(
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    color: Theme.of(context)
                                                                .primaryColor ==
                                                            Colors.green[500]
                                                        ? Colors.grey[600]
                                                        : Theme.of(context)
                                                                    .primaryColor ==
                                                                Colors
                                                                    .indigo[500]
                                                            ? ArgonColors.white
                                                            : Colors.blue[800],
                                                    elevation: 10,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12, 0, 12, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Theme.of(context)
                                                                          .primaryColor ==
                                                                      Colors.green[
                                                                          500]
                                                                  ? Colors
                                                                      .grey[600]
                                                                  : Theme.of(context)
                                                                              .primaryColor ==
                                                                          Colors.indigo[
                                                                              500]
                                                                      ? ArgonColors
                                                                          .white
                                                                      : Colors.blue[
                                                                          800],
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          15,
                                                                          0,
                                                                          0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {},
                                                                    child: Text(
                                                                      doc.get(
                                                                          "nomTarea"),
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                        fontSize:
                                                                            20,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    doc.get(
                                                                        "proyecto"),
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontSize:
                                                                          16,
                                                                      color: Theme.of(context).primaryColor ==
                                                                              Colors.green[500]
                                                                          ? Colors.white
                                                                          : Theme.of(context).primaryColor == Colors.indigo[500]
                                                                              ? ArgonColors.white
                                                                              : Colors.black,
                                                                    ),
                                                                  ),
                                                                  MediaQuery.of(context).size.width >=
                                                                              300 &&
                                                                          MediaQuery.of(context).size.width <=
                                                                              758.4000244140625
                                                                      ? Column(
                                                                          children: [
                                                                            Text(
                                                                              doc.get("from"),
                                                                              style: TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                                                                            ),
                                                                            Text(
                                                                              doc.get("until"),
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: 'Poppins',
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : Row(
                                                                          children: [
                                                                            Text(
                                                                              doc.get("from"),
                                                                              style: TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                                                                            ),
                                                                            const SizedBox(width: 5),
                                                                            Icon(Icons.arrow_forward,
                                                                                color: Colors.black54),
                                                                            const SizedBox(width: 5),
                                                                            Text(
                                                                              doc.get("until"),
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: 'Poppins',
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 40,
                                                            height: 100,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          10,
                                                                          0,
                                                                          0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          FeatherIcons
                                                                              .edit,
                                                                          color:
                                                                              Color(0xFF8BC34A),
                                                                          size:
                                                                              25,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          oldTask =
                                                                              doc.get("nomTarea");
                                                                          myTimeTrackingModelM =
                                                                              new TimeTrackingModel(
                                                                            id: doc.get("id"),
                                                                            active:
                                                                                doc.get("active"),
                                                                            nomTarea:
                                                                                doc.get("nomTarea"),
                                                                            descripcion:
                                                                                doc.get("descripcion"),
                                                                            proyecto:
                                                                                doc.get("proyecto"),
                                                                            from:
                                                                                doc.get("from"),
                                                                            until:
                                                                                doc.get("until"),
                                                                            comentario:
                                                                                doc.get("comentario"),
                                                                          );
                                                                          if (ResponsiveLayout.isPhone(
                                                                              context))
                                                                            Navigator.pushReplacementNamed(context,
                                                                                '/modifyTimeTracking');
                                                                          else
                                                                            Provider.of<ReportsProvider>(context, listen: false).set(ModifyTimeTracking());
                                                                        },
                                                                      )),
                                                                  Expanded(
                                                                      child:
                                                                          IconButton(
                                                                    icon: Icon(
                                                                      FeatherIcons
                                                                          .archive,
                                                                      color: Color(
                                                                          0xFFC62626),
                                                                      size: 25,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      myTimeTrackingModelD =
                                                                          new TimeTrackingModel(
                                                                        id: doc.get(
                                                                            "id"),
                                                                        active:
                                                                            false,
                                                                        nomTarea:
                                                                            doc.get("nomTarea"),
                                                                        descripcion:
                                                                            doc.get("descripcion"),
                                                                        proyecto:
                                                                            doc.get("proyecto"),
                                                                        from: doc
                                                                            .get("from"),
                                                                        until: doc
                                                                            .get("until"),
                                                                        comentario:
                                                                            doc.get("comentario"),
                                                                      );
                                                                      TimeTrackingServices.modifyTimeTracking(
                                                                          myTimeTrackingModelD,
                                                                          doc.get(
                                                                              "nomTarea"));
                                                                    },
                                                                  )),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ));
                                              })
                                              .toList()
                                              .cast<Widget>(),
                                        ],
                                      )
                                    : Center(
                                        child: Text(
                                            'There is no data in the Database'),
                                      ))
                                : Center(
                                    child: CircularProgressIndicator(),
                                  );
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: ExpandableFabReports(
          distance: 50,
          children: [
            ActionButton(
                onPressed: () =>
                    !kIsWeb ? movilWatch(context) : webWatch(context),
                icon: Icon(
                  FeatherIcons.eye,
                  color: ArgonColors.white,
                )),
            kIsWeb
                ? ActionButton(
                    onPressed: () => webDownload(context),
                    icon: Icon(
                      FeatherIcons.download,
                      color: ArgonColors.white,
                    ),
                  )
                : null
          ],
        ));
  }

  movilWatch(context) async {
    paragraph = "";
    file = null;
    page = null;
    pdf = pw.Document();
    await FirebaseFirestore.instance
        .collection('timeTracking')
        .where("active", isEqualTo: true)
        .where("idUser", isEqualTo: myUserModel.id)
        .where("idOrganization", isEqualTo: selectedCurrency)
        .where("proyecto", isEqualTo: proyecto)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        a(doc);
      });
    });
    writeOnPdf(paragraph);
    pdf.addPage(page);
    await savePdf();
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

  webDownload(context) async {
    paragraph = "";
    file = null;
    page = null;
    pdf = pw.Document();
    await FirebaseFirestore.instance
        .collection('timeTracking')
        .where("active", isEqualTo: true)
        .where("idUser", isEqualTo: myUserModel.id)
        .where("idOrganization", isEqualTo: selectedCurrency)
        .where("proyecto", isEqualTo: proyecto)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        a(doc);
      });
    });
    writeOnPdf(paragraph);
    pdf.addPage(page);
    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement()
      ..href = url
      ..style.display = 'none'
      ..download = 'some_name.pdf';
    html.document.body.children.add(anchor);
    anchor.click();
    html.document.body.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  webWatch(context) async {
    paragraph = "";
    file = null;
    page = null;
    pdf = pw.Document();
    await FirebaseFirestore.instance
        .collection('timeTracking')
        .where("active", isEqualTo: true)
        .where("idUser", isEqualTo: myUserModel.id)
        .where("idOrganization", isEqualTo: selectedCurrency)
        .where("proyecto", isEqualTo: proyecto)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        a(doc);
      });
    });
    writeOnPdf(paragraph);
    pdf.addPage(page);
    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');
    html.Url.revokeObjectUrl(url);
  }
}
