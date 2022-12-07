import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:flutter/material.dart';

import 'package:argon_flutter/constants/Theme.dart';

bool kIsWeb = identical(0, 0.0);

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final bool isSelected;
  final Color iconColor;

  DrawerTile({this.title, this.icon, this.onTap, this.isSelected = false, this.iconColor = ArgonColors.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    MediaQuery.of(context).size.width >= 999 && MediaQuery.of(context).size.width <= 1252 ? 14 : 26,
                    0,
                    0,
                    0),
                child: Icon(icon,
                    size: ResponsiveLayout.isDesktop(context) ? 25 : 20, color: isSelected ? Colors.red : iconColor),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(title,
                    style: TextStyle(
                        letterSpacing: .3,
                        fontSize: 15,
                        color: isSelected
                            ? Colors.red
                            : Theme.of(context).primaryColor == Colors.green[500]
                                ? ArgonColors.white
                                : Theme.of(context).primaryColor == Colors.indigo[500]
                                    ? ArgonColors.black
                                    : ArgonColors.black)),
              )
            ],
          )),
    );
  }
}
