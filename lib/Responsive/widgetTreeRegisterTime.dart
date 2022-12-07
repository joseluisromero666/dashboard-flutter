import 'package:argon_flutter/screens/registerTimeTracking.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'responsiveController.dart';

class WidgetTreeRegisterTimeTracking extends StatefulWidget {
  final index;
  WidgetTreeRegisterTimeTracking({this.index});
  @override
  _WidgetTreeRegisterTimeTracking createState() => _WidgetTreeRegisterTimeTracking();
}

class _WidgetTreeRegisterTimeTracking extends State<WidgetTreeRegisterTimeTracking> {
  _WidgetTreeRegisterTimeTracking();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
        phone: RegisterTimeTracking(),
        tablet: Row(
          children: [
            Expanded(
              flex: 9,
              child: RegisterTimeTracking(),
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
              child: RegisterTimeTracking(),
            )
          ],
        ),
      ),
    );
  }
}
