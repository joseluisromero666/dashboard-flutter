import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/widgets/date_range_picker_widget.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class EditReport extends StatefulWidget {
  @override
  _EditReportState createState() => _EditReportState();
}

class _EditReportState extends State<EditReport> {
  @override
  Widget build(BuildContext context) {
    InputDecoration formDecoration(decoration) {
      return InputDecoration(
        labelText: decoration,
        errorStyle: TextStyle(
          fontSize: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
        ),
      );
    }

    // ignore: unused_element
    Widget _buildUserField({String user}) {
      String selected;
      return DropdownButtonFormField<String>(
        decoration: formDecoration("By"),
        value: selected,
        items: [
          "User 1",
          "User 2",
          "User 3",
          "User 4",
          "User 5",
          "User 6",
          "User 7",
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
          });
        },
        validator: (String value) {
          if (value == null) {
            return "You have not selected User ";
          }
          return null;
        },
      );
    }

    return Scaffold(
      appBar: Navbar(
        title: "Edit Reportes",
        prefferedHeight: 60,
        bgColor: Theme.of(context).primaryColor == Colors.green[500]
            ? Colors.grey[900]
            : Theme.of(context).primaryColor == Colors.indigo[500]
                ? ArgonColors.white
                : Colors.blue[800],
      ),
      body: Container(
          padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 8.0),
                Column(
                  children: [
                    TextFormField(
                      decoration: formDecoration("Name"),
                    ),
                    TextFormField(
                      decoration: formDecoration("Description"),
                    ),
                    TextFormField(
                      decoration: formDecoration("Comments"),
                    ),
                    Center(
                      child: DateRangePickerWidget(),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                          textColor: ArgonColors.white,
                          color: ArgonColors.success,
                          onPressed: () {
                            // Respond to button press
                            Navigator.pushReplacementNamed(context, '/home');
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        )),
                        SizedBox(
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                              textColor: ArgonColors.white,
                              color: ArgonColors.error,
                              onPressed: () {
                                // Respond to button press
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
