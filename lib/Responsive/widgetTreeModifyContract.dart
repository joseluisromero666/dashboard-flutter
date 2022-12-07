import 'package:argon_flutter/screens/modifyContract.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'responsiveController.dart';

class WidgetTreeModifyContract extends StatefulWidget {
  final index;
  WidgetTreeModifyContract({this.index});
  @override
  _WidgetTreeModifyContract createState() => _WidgetTreeModifyContract();
}

class _WidgetTreeModifyContract extends State<WidgetTreeModifyContract> {
  _WidgetTreeModifyContract();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
        phone: ModifyContract(),
        tablet: Row(
          children: [
            Expanded(
              flex: 9,
              child: ModifyContract(),
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
              child: ModifyContract(),
            )
          ],
        ),
      ),
    );
  }
}
