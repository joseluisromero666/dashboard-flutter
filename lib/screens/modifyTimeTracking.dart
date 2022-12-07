import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/models/TimeTracking.dart';
import 'package:argon_flutter/services/timeTrackingServices.dart';
import 'package:argon_flutter/widgets/DatetimeRangePickerWidgetModifyTimeTracking.dart';
import 'package:argon_flutter/widgets/button_widget.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ModifyTimeTracking extends StatefulWidget {
  @override
  _ModifyTimeTrackingState createState() => _ModifyTimeTrackingState();
}

String proyectoTM;

class _ModifyTimeTrackingState extends State<ModifyTimeTracking> {
  @override
  Widget build(BuildContext context) {
    taskTM.text = myTimeTrackingModelM.nomTarea;
    descriptionTM.text = myTimeTrackingModelM.descripcion;
    proyectoTM = myTimeTrackingModelM.proyecto;
    fromTM = myTimeTrackingModelM.from;
    untilTM = myTimeTrackingModelM.until;
    commentTM.text = myTimeTrackingModelM.comentario;
    print(commentTM.text + "A");
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

    InputDecoration formDecoration(hintTextt, icon) {
      return InputDecoration(
          filled: true,
          fillColor: Theme.of(context).primaryColor == Colors.green[500]
              ? Colors.grey[600]
              : Theme.of(context).primaryColor == Colors.indigo[500]
                  ? ArgonColors.white
                  : Colors.blue[800],
          hintStyle: TextStyle(
            color: Theme.of(context).primaryColor == Colors.green[500]
                ? Colors.white
                : Theme.of(context).primaryColor == Colors.indigo[500]
                    ? ArgonColors.white
                    : Colors.blue[800],
          ),
          prefixIcon: Icon(icon),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor == Colors.green[500]
                      ? Colors.white
                      : Theme.of(context).primaryColor == Colors.indigo[500]
                          ? ArgonColors.white
                          : Colors.blue[800],
                  width: 1.0,
                  style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor == Colors.green[500]
                      ? Colors.white
                      : Theme.of(context).primaryColor == Colors.indigo[500]
                          ? ArgonColors.white
                          : Colors.blue[800],
                  width: 1.0,
                  style: BorderStyle.solid)),
          hintText: hintTextt);
    }

    // ignore: unused_element
    Widget _buildProjectField() {
      String selected = projectsTM[projectsTM.indexOf(proyectoTM)];
      return DropdownButtonFormField<String>(
        decoration: formDecoration("Projects", FeatherIcons.bookOpen),
        value: selected,
        items: projectsTM
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
            proyectoTM = value;
            print(proyectoTM);
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

    return Scaffold(
      appBar: ResponsiveLayout.isPhone(context)
          ? Navbar(
              avatar: true,
              backPage: "TimeTracking",
              title: "Modify Time-Traking",
              backButton: true,
              prefferedHeight: 60,
              bgColor: ArgonColors.initial,
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
                SizedBox(height: 8.0),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextFormField(
                        controller: taskTM,
                        decoration: InputDecoration(
                          prefixIcon: Icon(FeatherIcons.bookmark),
                          hintText: "Task",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextFormField(
                          controller: descriptionTM,
                          decoration: InputDecoration(
                            prefixIcon: Icon(FeatherIcons.book),
                            hintText: "Description",
                          )),
                    ),
                    reports
                        ? Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: TextFormField(
                              controller: commentTM,
                              decoration: InputDecoration(
                                prefixIcon: Icon(FeatherIcons.bookmark),
                                hintText: "Comment",
                              ),
                            ),
                          )
                        : SizedBox(),
                    DatetimeRangePickerWidgetModifyTimeTracking(),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonWidgett(
                            mColor: Color(0xFF8BC34A),
                            text: "Save",
                            onClicked: () => {
                              if (editTT == false)
                                {
                                  _showMyDialog(context,
                                      "There is no consistency in the dates, please check. :)")
                                }
                              else
                                {
                                  if (taskTM.text != "" &&
                                      descriptionTM.text != "" &&
                                      proyectoTM != "" &&
                                      fromTM != "" &&
                                      untilTM != "")
                                    {
                                      Navigator.pushNamed(
                                          context, '/animation'),
                                      myTimeTrackingModelM =
                                          new TimeTrackingModel(
                                              id: myTimeTrackingModelM.id,
                                              active: true,
                                              nomTarea: taskTM.text,
                                              descripcion: descriptionTM.text,
                                              proyecto:
                                                  myTimeTrackingModelM.proyecto,
                                              from: fromTM,
                                              until: untilTM,
                                              comentario: commentTM.text),
                                      TimeTrackingServices.modifyTimeTracking(
                                          myTimeTrackingModelM, oldTask),
                                      taskTM = TextEditingController(),
                                      namesTM = TextEditingController(),
                                      descriptionT = TextEditingController(),
                                      commentTM = TextEditingController(),
                                      proyectoTM = "",
                                      fromTM = "",
                                      untilTM = "",
                                      oldTask = "",
                                      projectsTM = ["NaN"],
                                      reports
                                          ? Navigator.pushReplacementNamed(
                                              context, '/TreeHome')
                                          : Navigator.pushReplacementNamed(
                                              context, '/TimeTracking'),
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
                              projectsTM = ["NaN"],
                              reports
                                  ? Navigator.pushReplacementNamed(
                                      context, '/TreeHome')
                                  : Navigator.pushReplacementNamed(
                                      context, '/TimeTracking')
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
