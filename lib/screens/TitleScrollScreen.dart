import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/screens/specificProject.dart';
import 'package:argon_flutter/screens/report.dart';
import 'package:argon_flutter/widgets/misc/navigation_helpers.dart';
import 'package:argon_flutter/widgets/navigation/title_scroll_navigation.dart';
import 'package:flutter/material.dart';
//widgets
import 'package:argon_flutter/widgets/navbar.dart';

class TitleScrollScreen extends StatefulWidget {
  TitleScrollScreen({Key key}) : super(key: key);

  @override
  _TitleScrollScreenState createState() => _TitleScrollScreenState();
}

class _TitleScrollScreenState extends State<TitleScrollScreen> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveLayout.isPhone(context)
          ? Navbar(
              backPage: "home",
              title: "Project",
              rightOptions: false,
              prefferedHeight: 60,
              backButton: true,
              bgColor: Theme.of(context).primaryColor == Colors.green[500]
                  ? Colors.grey[800]
                  : Theme.of(context).primaryColor == Colors.indigo[500]
                      ? ArgonColors.white
                      : Colors.blue[800],
            )
          : null,
      body: TitleScrollNavigation(
        barStyle: TitleNavigationBarStyle(
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor == Colors.green[500]
                ? Colors.blue
                : Theme.of(context).primaryColor == Colors.indigo[500]
                    ? ArgonColors.border
                    : Colors.blue[800],
          ),
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          spaceBetween: 40,
        ),
        titles: [
          "Project",
          "Informe",
        ],
        pages: [
          SpecificProject(),
          Report(),
        ],
      ),
    );
  }
}
