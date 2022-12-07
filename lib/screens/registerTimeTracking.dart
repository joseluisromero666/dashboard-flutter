import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/models/TimeTracking.dart';
import 'package:argon_flutter/models/userModel.dart';
import 'package:argon_flutter/screens/profiles.dart';
import 'package:argon_flutter/services/timeTrackingServices.dart';
import 'package:argon_flutter/widgets/DatetimeRangePickerWidgetTimeTracking.dart';
import 'package:argon_flutter/widgets/button_widget.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterTimeTracking extends StatefulWidget {
  @override
  _RegisterTimeTrackingState createState() => _RegisterTimeTrackingState();
}

String proyectoT;

class _RegisterTimeTrackingState extends State<RegisterTimeTracking> {
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

  Widget _buildProjectField() {
    String selected;
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        prefixIcon: Icon(FeatherIcons.bookOpen),
        hintText: "Projects",
      ),
      value: selected,
      items: catergori
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
          proyectoT = value;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveLayout.isPhone(context)
          ? Navbar(
              avatar: true,
              backButton: true,
              backPage: "TimeTracking",
              prefferedHeight: 60,
              bgColor: ArgonColors.initial,
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
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextFormField(
                        controller: taskT,
                        decoration: InputDecoration(
                          prefixIcon: Icon(FeatherIcons.bookmark),
                          hintText: "Task ",
                        ),
                      ),
                    ),
                    _buildProjectField(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextFormField(
                        controller: descriptionT,
                        decoration: InputDecoration(
                          prefixIcon: Icon(FeatherIcons.book),
                          hintText: "Description",
                        ),
                      ),
                    ),
                    DatetimeRangePickerWidgetTimeTracking(),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonWidgett(
                            mColor: Color(0xFF8BC34A),
                            text: "Save",
                            onClicked: () => {
                              if (regisTT == false)
                                {_showMyDialog(context, "There is no consistency in the dates, please check. :)")}
                              else
                                {
                                  if (taskT.text != "" &&
                                      descriptionT.text != "" &&
                                      proyectoT != "" &&
                                      fromT != "" &&
                                      untilT != "")
                                    {
                                      Navigator.pushNamed(context, '/animation'),
                                      myTimeTrackingModel = new TimeTrackingModel(
                                          id: "",
                                          idUser: myUserModel.id,
                                          idOrganization: selectedCurrency,
                                          active: true,
                                          nomTarea: taskT.text,
                                          descripcion: descriptionT.text,
                                          proyecto: proyectoT,
                                          from: fromT,
                                          until: untilT,
                                          comentario: ""),
                                      TimeTrackingServices.addNewTimeTrackingModel(myTimeTrackingModel),
                                      taskT = TextEditingController(),
                                      descriptionT = TextEditingController(),
                                      proyectoT = "",
                                      fromT = "",
                                      untilT = "",
                                      Navigator.pushReplacementNamed(context, '/TimeTracking'),
                                    }
                                  else
                                    {_showMyDialog(context, "There are empty fields, please verify. :)")}
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
                              taskT = TextEditingController(),
                              descriptionT = TextEditingController(),
                              proyectoT = "",
                              fromT = "",
                              untilT = "",
                              Navigator.pushReplacementNamed(context, '/TimeTracking')
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
