import 'package:argon_flutter/screens/modifyProject.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'responsiveController.dart';

class WidgetTreeModifyProject extends StatefulWidget {
  final index;
  WidgetTreeModifyProject({this.index});
  @override
  _WidgetTreeModifyProject createState() => _WidgetTreeModifyProject();
}

class _WidgetTreeModifyProject extends State<WidgetTreeModifyProject> {
  _WidgetTreeModifyProject();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
        phone: ModifyProject(),
        tablet: Row(
          children: [
            Expanded(
              flex: 9,
              child: ModifyProject(),
            )
          ],
        ),
        desktop: Row(
          children: [
            Expanded(
              flex: _size.width > 1340 ? 1 : 3,
              child: ArgonDrawer(),
            ),
            Expanded(
              flex: _size.width > 1340 ? 10 : 14,
              child: ModifyProject(),
            )
          ],
        ),
      ),
    );
  }
}
