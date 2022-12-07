import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';
//widgets

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

class Reports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage("assets/img/profile-screen-bg.png"),
              fit: BoxFit.fitWidth)),
      padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
      child: SingleChildScrollView(
          child: Container(
        color: Theme.of(context).primaryColor == Colors.green[500]
            ? Colors.grey[800]
            : Theme.of(context).primaryColor == Colors.indigo[500]
                ? ArgonColors.white
                : Colors.blue[600],
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: 8.0),
            Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: formDecoration("Titulo reporte"),
                  ),
                  TextFormField(
                    decoration: formDecoration("Hora inicio"),
                  ),
                  TextFormField(
                    decoration: formDecoration("Hora final"),
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            ),
            SizedBox(height: 20.0),
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
                    "Validate",
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
                        Navigator.pushReplacementNamed(context, '/home');
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
      )),
    ));
  }
}
