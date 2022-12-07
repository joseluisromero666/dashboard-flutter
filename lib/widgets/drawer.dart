import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/Responsive/widgetTreeContracts.dart';
import 'package:argon_flutter/Responsive/widgetTreeHome.dart';
import 'package:argon_flutter/Responsive/widgetTreeProjects.dart';
import 'package:argon_flutter/Responsive/widgetTreeTimeTracking.dart';
import 'package:argon_flutter/models/TimeTracking.dart';
import 'package:argon_flutter/models/contractProvider.dart';
import 'package:argon_flutter/models/projectProvider.dart';
import 'package:argon_flutter/models/reportsProvider.dart';
import 'package:argon_flutter/models/timeTrackingProvider.dart';
import 'package:argon_flutter/models/userModel.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:argon_flutter/constants/Theme.dart';

import 'package:argon_flutter/widgets/drawer-tile.dart';

class ArgonDrawer extends StatelessWidget {
  final String currentPage;

  ArgonDrawer({this.currentPage});

  // ignore: unused_element
  _launchURL() async {
    const url = 'https://creative-tim.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Theme.of(context).primaryColor == Colors.green[500]
          ? Color(0xFF141414)
          : Theme.of(context).primaryColor == Colors.indigo[500]
              ? ArgonColors.white
              : Colors.blue[800],
      child: Column(children: [
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 0, left: 12, right: 0),
          child: ResponsiveLayout.isDesktop(context)
              ? Theme.of(context).primaryColor == Colors.green[500]
                  ? Image.asset("assets/img/logo_size_invert_mini.jpg")
                  : Image.asset("assets/img/logo_size_mini.jpg")
              : Theme.of(context).primaryColor == Colors.green[500]
                  ? Image.asset("assets/img/logo_size_invert.jpg")
                  : Image.asset("assets/img/logo_size.jpg"),
        )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 24, left: 12, right: 0),
            children: <Widget>[
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Projects") {
                       Navigator.of(context).push(HorizontalAnimation(ChangeNotifierProvider(create: (context) => ProjectsProvider(), child: WidgetTreeProjects())));
                    }
                  },
                  iconColor: ArgonColors.primary,
                  title: ResponsiveLayout.isDesktop(context) ? "" : "Projects",
                  isSelected: currentPage == "Projects" ? true : false),
              DrawerTile(
                  icon: FeatherIcons.user,
                  onTap: () {
                    if (currentPage != "Profile")
                      Navigator.pushReplacementNamed(context, '/profiles');
                  },
                  iconColor: ArgonColors.muted,
                  title: ResponsiveLayout.isDesktop(context) ? "" : "Profile",
                  isSelected: currentPage == "Profile" ? true : false),
              DrawerTile(
                  icon: FeatherIcons.book,
                  onTap: () {
                    
                    if (currentPage != "Contracts") Navigator.of(context).push(AnimarPageRoute(ChangeNotifierProvider(create: (context) => ContractsProvider(), child: WidgetTreeContracts())));
                  },
                  iconColor: Color(0xFF964B00),
                  title: ResponsiveLayout.isDesktop(context) ? "" : "Contracts",
                  isSelected: currentPage == "Contracts" ? true : false),
              DrawerTile(
                  icon: Icons.lock_clock,
                  onTap: () {
                    reports=false;
                    if (currentPage != "TimeTracking") Navigator.of(context).push(AnimarPageRoute( ChangeNotifierProvider(create: (context) => TimeTrackingProvider(), child: WidgetTreeTimeTracking())));
                  },
                  iconColor: Color(0xFF9DA5D9),
                  title: ResponsiveLayout.isDesktop(context)
                      ? ""
                      : "Time Tracking",
                  isSelected: currentPage == "TimeTracking" ? true : false),
              myUserModel.manager == ""
                  ? DrawerTile(
                      icon: FeatherIcons.edit,
                      onTap: () {
                        reports=true;
                        if (currentPage != "Reports") Navigator.of(context).push(AnimarPageRoute( ChangeNotifierProvider(create: (context) => ReportsProvider(), child: WidgetTreeHome())));
                      },
                      iconColor: Color(0xFFA7D9BE),
                      title:
                          ResponsiveLayout.isDesktop(context) ? "" : "Reports",
                      isSelected: currentPage == "Reports" ? true : false)
                  : Text("")
            ],
          ),
        ),
      ]),
    ));
  }
}
class AnimarPageRoute extends PageRouteBuilder {
  final Widget child;
  AnimarPageRoute(this.child):super(transitionDuration: Duration(seconds: 1), pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
    return  child;

  },
   transitionsBuilder:   (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child){
     return  ScaleTransition(scale: animation, 
     child: child,);
    
     
     
   });

}
class HorizontalAnimation extends PageRouteBuilder{
  final Widget child;
  HorizontalAnimation(this.child):super(transitionDuration: Duration(seconds: 1), pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
    return  child;

  },
   transitionsBuilder:   (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child){
     return  SlideTransition(position: Tween<Offset>(
       begin: Offset(-1,0),
       end: Offset.zero,
     ).animate(animation),
     child: child,);
    
     
     
   });

}