import 'package:argon_flutter/screens/registerContracts.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'responsiveController.dart';

class WidgetTreeRegisContract extends StatefulWidget {
  final index;
  WidgetTreeRegisContract({this.index});
  @override
  _WidgetTreeRegisContract createState() => _WidgetTreeRegisContract();
}

class _WidgetTreeRegisContract extends State<WidgetTreeRegisContract> {
  _WidgetTreeRegisContract();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
        phone: RegisterContracts(),
        tablet: Row(
          children: [
            Expanded(
              flex: 9,
              child: RegisterContracts(),
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
              child: RegisterContracts(),
            )
          ],
        ),
      ),
    );
  }
}
