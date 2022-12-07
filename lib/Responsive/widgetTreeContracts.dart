import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/models/contractProvider.dart';
import 'package:argon_flutter/screens/contracts.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'responsiveController.dart';

class WidgetTreeContracts extends StatefulWidget {
  final index;
  WidgetTreeContracts({this.index});
  @override
  _WidgetTreeContracts createState() => _WidgetTreeContracts();
}

class _WidgetTreeContracts extends State<WidgetTreeContracts> {
  _WidgetTreeContracts();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
        phone: Contracts(),
        tablet: Scaffold(
            appBar: Navbar(
              avatar: true,
              rightOptions: false,
              prefferedHeight: 60,
              bgColor: ArgonColors.initial,
            ),
            drawer: ArgonDrawer(
              currentPage: "contract",
            ),
            body: Row(children: [
              Expanded(flex: 2, child: Contracts()),
              Expanded(flex: 2, child: Provider.of<ContractsProvider>(context).contractCurrentWidget)
            ])),
        desktop: Row(
          children: [
            Expanded(
              flex: _size.width > 999 ? 1 : 3,
              child: ArgonDrawer(),
            ),
            Expanded(
              flex: _size.width > 999 ? 10 : 14,
              child: Scaffold(
                  appBar: Navbar(
                    avatar: true,
                    rightOptions: false,
                    prefferedHeight: 60,
                    bgColor: ArgonColors.initial,
                  ),
                  body: Row(children: [
                    Expanded(flex: 2, child: Contracts()),
                    Expanded(flex: 2, child: Provider.of<ContractsProvider>(context).contractCurrentWidget)
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
