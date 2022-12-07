import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/Responsive/widgetTreeRegisterTime.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/models/TimeTracking.dart';
import 'package:argon_flutter/models/timeTrackingProvider.dart';
import 'package:argon_flutter/models/userModel.dart';
import 'package:argon_flutter/screens/profiles.dart';
import 'package:argon_flutter/screens/registerTimeTracking.dart';
import 'package:argon_flutter/screens/specificTimeTracking.dart';
import 'package:argon_flutter/services/timeTrackingServices.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modifyTimeTracking.dart';

class TimeTracking extends StatefulWidget {
  TimeTracking({Key key}) : super(key: key);

  @override
  _TimeTrackingState createState() => _TimeTrackingState();
}
class RotarPageRoute extends PageRouteBuilder {
  final Widget child;
  RotarPageRoute(this.child):super(pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
    return  child;

  },
   transitionsBuilder:   (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child){
     return Transform.scale(scale: animation.value,
     child: Transform.rotate(child :FadeTransition(child: child,
     opacity: animation,),angle: 1 - animation.value )
     );
     
   });

  

}

class _TimeTrackingState extends State<TimeTracking> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ResponsiveLayout.isPhone(context)
            ? Navbar(
                avatar: true,
                transparent: false,
                prefferedHeight: 60,
                bgColor: ArgonColors.initial,
              )
            : null,
        backgroundColor: Theme.of(context).primaryColor == Colors.green[500]
            ? Colors.grey[900]
            : Theme.of(context).primaryColor == Colors.indigo[500]
                ? ArgonColors.white
                : Colors.blue[800],
        drawer: ArgonDrawer(currentPage: "TimeTracking"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 22.0),
              Center(
                child: Text("Time Tracking",
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 22.0),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('timeTracking')
                      .where("active", isEqualTo: true)
                      .where("idUser", isEqualTo: myUserModel.id)
                      .where("idOrganization", isEqualTo: selectedCurrency)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? (snapshot.data.docs.length != 0
                            ? Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ...snapshot.data.docs
                                      .map((doc) {
                                        return Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: Theme.of(context)
                                                        .primaryColor ==
                                                    Colors.green[500]
                                                ? Colors.grey[600]
                                                : Theme.of(context)
                                                            .primaryColor ==
                                                        Colors.indigo[500]
                                                    ? ArgonColors.white
                                                    : Colors.blue[600],
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 0, 12, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                                  .primaryColor ==
                                                              Colors.green[500]
                                                          ? Colors.grey[600]
                                                          : Theme.of(context)
                                                                      .primaryColor ==
                                                                  Colors.indigo[
                                                                      500]
                                                              ? ArgonColors
                                                                  .white
                                                              : Colors
                                                                  .blue[600],
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 15, 0, 0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              myTimeTrackingModel =
                                                                  new TimeTrackingModel(
                                                                id: doc
                                                                    .get("id"),
                                                                active: doc.get(
                                                                    "active"),
                                                                nomTarea: doc.get(
                                                                    "nomTarea"),
                                                                descripcion:
                                                                    doc.get(
                                                                        "descripcion"),
                                                                proyecto: doc.get(
                                                                    "proyecto"),
                                                                from: doc.get(
                                                                    "from"),
                                                                until: doc.get(
                                                                    "until"),
                                                                comentario: doc.get(
                                                                    "comentario"),
                                                              );
                                                              myTimeTrackingModelInitial =
                                                                  myTimeTrackingModel;
                                                              back =
                                                                  "TimeTracking";
                                                              if (ResponsiveLayout
                                                                  .isPhone(
                                                                      context))
                                                                Navigator
                                                                    .pushReplacementNamed(
                                                                        context,
                                                                        '/SpecificTimeTracking');
                                                              else
                                                                Provider.of<TimeTrackingProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .set(
                                                                        SpecificTimeTracking());
                                                            },
                                                            child: Text(
                                                              doc.get(
                                                                  "nomTarea"),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            doc.get("proyecto"),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 16,
                                                              color: Theme.of(context)
                                                                          .primaryColor ==
                                                                      Colors.green[
                                                                          500]
                                                                  ? Colors.white
                                                                  : Theme.of(context)
                                                                              .primaryColor ==
                                                                          Colors.indigo[
                                                                              500]
                                                                      ? ArgonColors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                            ),
                                                          ),
                                                          MediaQuery.of(context)
                                                                          .size
                                                                          .width >=
                                                                      600.4000244140625 &&
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width <=
                                                                      758.4000244140625
                                                              ? Column(
                                                                  children: [
                                                                    Text(
                                                                      doc.get(
                                                                          "from"),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    Text(
                                                                      doc.get(
                                                                          "until"),
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Row(
                                                                  children: [
                                                                    Text(
                                                                      doc.get(
                                                                          "from"),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            5),
                                                                    Icon(
                                                                        Icons
                                                                            .arrow_forward,
                                                                        color: Colors
                                                                            .black54),
                                                                    const SizedBox(
                                                                        width:
                                                                            5),
                                                                    Text(
                                                                      doc.get(
                                                                          "until"),
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 40,
                                                    height: 100,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 10, 0, 0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          myUserModel.roles[0][
                                                                      "time_tracking"]
                                                                  [
                                                                  "time_tracking_update"]
                                                              ? Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      IconButton(
                                                                    icon: Icon(
                                                                      FeatherIcons
                                                                          .edit,
                                                                      color: Color(
                                                                          0xFF8BC34A),
                                                                      size: 25,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      oldTask =
                                                                          doc.get(
                                                                              "nomTarea");
                                                                      myTimeTrackingModelM =
                                                                          new TimeTrackingModel(
                                                                        id: doc.get(
                                                                            "id"),
                                                                        active:
                                                                            doc.get("active"),
                                                                        nomTarea:
                                                                            doc.get("nomTarea"),
                                                                        descripcion:
                                                                            doc.get("descripcion"),
                                                                        proyecto:
                                                                            doc.get("proyecto"),
                                                                        from: doc
                                                                            .get("from"),
                                                                        until: doc
                                                                            .get("until"),
                                                                        comentario:
                                                                            doc.get("comentario"),
                                                                      );
                                                                      if (ResponsiveLayout
                                                                          .isPhone(
                                                                              context))
                                                                        Navigator.pushReplacementNamed(
                                                                            context,
                                                                            '/modifyTimeTracking');
                                                                      else
                                                                        Provider.of<TimeTrackingProvider>(context,
                                                                                listen: false)
                                                                            .set(ModifyTimeTracking());
                                                                    },
                                                                  ))
                                                              : Text(""),
                                                          myUserModel.roles[0][
                                                                      "time_tracking"]
                                                                  [
                                                                  "time_tracking_delete"]
                                                              ? Expanded(
                                                                  child:
                                                                      IconButton(
                                                                  icon: Icon(
                                                                    FeatherIcons
                                                                        .archive,
                                                                    color: Color(
                                                                        0xFFC62626),
                                                                    size: 25,
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    myTimeTrackingModelD =
                                                                        new TimeTrackingModel(
                                                                      id: doc.get(
                                                                          "id"),
                                                                      active:
                                                                          false,
                                                                      nomTarea:
                                                                          doc.get(
                                                                              "nomTarea"),
                                                                      descripcion:
                                                                          doc.get(
                                                                              "descripcion"),
                                                                      proyecto:
                                                                          doc.get(
                                                                              "proyecto"),
                                                                      from: doc.get(
                                                                          "from"),
                                                                      until: doc
                                                                          .get(
                                                                              "until"),
                                                                      comentario:
                                                                          doc.get(
                                                                              "comentario"),
                                                                    );
                                                                    TimeTrackingServices.modifyTimeTracking(
                                                                        myTimeTrackingModelD,
                                                                        doc.get(
                                                                            "nomTarea"));
                                                                    Navigator.pushReplacementNamed(
                                                                        context,
                                                                        '/TimeTracking');
                                                                  },
                                                                ))
                                                              : Text(""),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ));
                                      })
                                      .toList()
                                      .cast<Widget>()
                                ],
                              )
                            : Center(
                                child: Text('There is no data in the Database'),
                              ))
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  })
            ],
          ),
        ),
        floatingActionButton: myUserModel.roles[0]["time_tracking"]
                ["time_tracking_create"]
            ? FloatingActionButton(
                onPressed: () async {
                  fromT = "";
                  untilT = "";
                  if (ResponsiveLayout.isPhone(context))
                   Navigator.of(context).push(RotarPageRoute(WidgetTreeRegisterTimeTracking()));
                  else
                    Provider.of<TimeTrackingProvider>(context, listen: false)
                        .set(RegisterTimeTracking());
                },
                child: const Icon(Icons.add, color: ArgonColors.white),
                backgroundColor: ArgonColors.initial,
              )
            : Text(""));
  }
}
