import 'package:argon_flutter/screens/Sign_in.dart';
import 'package:flutter/material.dart';
import 'responsiveController.dart';

class SigninTree extends StatefulWidget {
  final index;
  SigninTree({this.index});
  @override
  _SigninTreeState createState() => _SigninTreeState();
}

class _SigninTreeState extends State<SigninTree> {
  _SigninTreeState();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
          phone: Sign_in(),
          tablet: Sign_in(
              cardMargin: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width - 600) / 2,
                  right: (MediaQuery.of(context).size.width - 600) / 2)),
          desktop: Sign_in(
              cardMargin: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width - 600) / 2,
                  right: (MediaQuery.of(context).size.width - 600) / 2))),
    );
  }
}
