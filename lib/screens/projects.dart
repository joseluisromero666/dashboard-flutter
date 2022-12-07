import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/Responsive/widgetTreeRegisterProject.dart';
import 'package:argon_flutter/models/projectModel.dart';
import 'package:argon_flutter/models/projectProvider.dart';
import 'package:argon_flutter/models/userModel.dart';
import 'package:argon_flutter/screens/modifyProject.dart';
import 'package:argon_flutter/screens/profiles.dart';
import 'package:argon_flutter/screens/registerProject.dart';
import 'package:argon_flutter/screens/specificProject.dart';
import 'package:argon_flutter/services/projectServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:provider/provider.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
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

bool kIsWeb = identical(0, 0.0);

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ResponsiveLayout.isPhone(context)
            ? Navbar(
                avatar: true,
                backPage: "projects",
                rightOptions: true,
                bgColor: ArgonColors.initial,
                prefferedHeight: 60,
              )
            : null,
        backgroundColor: Theme.of(context).primaryColor == Colors.green[500]
            ? Colors.grey[900]
            : Theme.of(context).primaryColor == Colors.indigo[500]
                ? ArgonColors.white
                : Colors.blue[800],
        drawer: ArgonDrawer(
          currentPage: "Projects",
        ),
        body: new Column(
          children: <Widget>[
            SizedBox(height: 22.0),
            Text("Projects",
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 22.0),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveLayout.isPhone(context)
                        ? 2
                        : ResponsiveLayout.isTablet(context)
                            ? (kIsWeb)
                                ? 2
                                : 2
                            : ResponsiveLayout.isDesktop(context)
                                ? (kIsWeb)
                                    ? MediaQuery.of(context).size.width >=
                                                1000 &&
                                            MediaQuery.of(context).size.width <=
                                                1242.4000244140625
                                        ? 2
                                        : 3
                                    : 4
                                : null,
                    childAspectRatio: (kIsWeb)
                        ? ResponsiveLayout.isDesktop(context)
                            ? MediaQuery.of(context).size.width >= 1000 &&
                                    MediaQuery.of(context).size.width <= 1128
                                ? 0.90
                                : MediaQuery.of(context).size.width >= 1128 &&
                                        MediaQuery.of(context).size.width <=
                                            1238.4000244140625
                                    ? 1
                                    : MediaQuery.of(context).size.width >=
                                                1238.4000244140625 &&
                                            MediaQuery.of(context).size.width <=
                                                1340
                                        ? 0.77
                                        : MediaQuery.of(context).size.width >= 1341 &&
                                                MediaQuery.of(context).size.width <=
                                                    1444
                                            ? 0.80
                                            : MediaQuery.of(context).size.width >= 1445 &&
                                                    MediaQuery.of(context).size.width <=
                                                        1536
                                                ? 0.90
                                                : 1
                            : ResponsiveLayout.isTablet(context)
                                ? MediaQuery.of(context).size.width >= 600 &&
                                        MediaQuery.of(context).size.width <=
                                            650.4000244140625
                                    ? 0.61
                                    : MediaQuery.of(context).size.width >= 650.4000244140625 &&
                                            MediaQuery.of(context).size.width <=
                                                758.4000244140625
                                        ? 0.65
                                        : MediaQuery.of(context).size.width >=
                                                    758.4000244140625 &&
                                                MediaQuery.of(context).size.width <=
                                                    882.4000244140625
                                            ? 0.75
                                            : 0.88
                                : ResponsiveLayout.isPhone(context)
                                    ? MediaQuery.of(context).size.width >= 300 &&
                                            MediaQuery.of(context).size.width <=
                                                537.5999755859375
                                        ? 1
                                        : 1.1
                                    : null
                        : ResponsiveLayout.isDesktop(context)
                            ? ResponsiveLayout.isRotated(context)
                                ? 0.57
                                : 0.57
                            : ResponsiveLayout.isTablet(context)
                                ? ResponsiveLayout.isRotated(context)
                                    ? 0.95
                                    : MediaQuery.of(context).size.width >= 600 &&
                                            MediaQuery.of(context).size.width <=
                                                650.4000244140625
                                        ? 0.60
                                        : 0.80
                                : ResponsiveLayout.isPhone(context)
                                    ? ResponsiveLayout.isRotated(context)
                                        ? 1.20
                                        : 0.78
                                    : null,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: misMaps.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(2, 0, 2, 0),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color:
                            Theme.of(context).primaryColor == Colors.green[500]
                                ? Colors.grey[800]
                                : Theme.of(context).primaryColor ==
                                        Colors.indigo[500]
                                    ? ArgonColors.white
                                    : Colors.blue[600],
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              onTap: () async {
                                List<String> provi2 =
                                    misMaps[index].get("idUser").cast<String>();
                                myProjectModel = new ProjectModel(
                                    categoria: misMaps[index].get('categoria'),
                                    from: misMaps[index].get('from'),
                                    id: misMaps[index].get('id'),
                                    nombre: misMaps[index].get('nombre'),
                                    active: misMaps[index].get('active'),
                                    idOrganization:
                                        misMaps[index].get('idOrganization'),
                                    idUser: provi2,
                                    presupuesto:
                                        misMaps[index].get('presupuesto'),
                                    until: misMaps[index].get('until'),
                                    url: misMaps[index].get('url'),
                                    cliente: misMaps[index].get('cliente'));
                                myProjectModelInitial = myProjectModel;

                                if (ResponsiveLayout.isPhone(context))
                                  Navigator.pushReplacementNamed(
                                      context, '/project');
                                else
                                  Provider.of<ProjectsProvider>(context,
                                          listen: false)
                                      .set(SpecificProject());
                              },
                              child: Image.network(
                                misMaps[index].get('url'),
                                width: double.infinity,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 100,
                                    height: 115,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor ==
                                              Colors.green[500]
                                          ? Colors.grey[800]
                                          : Theme.of(context).primaryColor ==
                                                  Colors.indigo[500]
                                              ? ArgonColors.white
                                              : Colors.blue[600],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          (kIsWeb) ? 20 : 10, 20, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            misMaps[index].get('nombre'),
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: (kIsWeb)
                                                  ? MediaQuery.of(context)
                                                                  .size
                                                                  .width >=
                                                              600 &&
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width <=
                                                              758.4000244140625
                                                      ? 15
                                                      : 20
                                                  : 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(
                                            misMaps[index].get('categoria'),
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Theme.of(context)
                                                            .primaryColor ==
                                                        Colors.green[500]
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                                .primaryColor ==
                                                            Colors.indigo[500]
                                                        ? ArgonColors.black
                                                        : Colors.black,
                                                fontSize: (kIsWeb)
                                                    ? MediaQuery.of(context)
                                                                    .size
                                                                    .width >=
                                                                600 &&
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width <=
                                                                758.4000244140625
                                                        ? 13
                                                        : 16
                                                    : 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 2.0),
                                          Text(
                                            misMaps[index].get('cliente'),
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Theme.of(context)
                                                            .primaryColor ==
                                                        Colors.green[500]
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                                .primaryColor ==
                                                            Colors.indigo[500]
                                                        ? ArgonColors.black
                                                        : Colors.black,
                                                fontSize: (kIsWeb)
                                                    ? MediaQuery.of(context)
                                                                    .size
                                                                    .width >=
                                                                600 &&
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width <=
                                                                758.4000244140625
                                                        ? 10
                                                        : 13
                                                    : 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 2.0),
                                          Text(
                                            "\$ " +
                                                misMaps[index]
                                                    .get('presupuesto'),
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Theme.of(context)
                                                            .primaryColor ==
                                                        Colors.green[500]
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                                .primaryColor ==
                                                            Colors.indigo[500]
                                                        ? Color(0xFF4A50C3)
                                                        : Colors.black,
                                                fontSize: (kIsWeb)
                                                    ? MediaQuery.of(context)
                                                                    .size
                                                                    .width >=
                                                                600 &&
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width <=
                                                                650.4000244140625
                                                        ? 10
                                                        : 13
                                                    : 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 100,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, (kIsWeb) ? 0 : 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: myUserModel.roles[1]
                                                      ["projects"]
                                                  ["projects_update"]
                                              ? IconButton(
                                                  icon: Icon(FeatherIcons.edit,
                                                      size: MediaQuery.of(context)
                                                                      .size
                                                                      .width >=
                                                                  600 &&
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width <=
                                                                  758.4000244140625
                                                          ? 25
                                                          : 30),
                                                  color: Color(0xFF8BC34A),
                                                  onPressed: () {
                                                    List<String> provi3 =
                                                        misMaps[index]
                                                            .get("idUser")
                                                            .cast<String>();
                                                    idi = misMaps[index]
                                                        .get('id');
                                                    myProjectModel = new ProjectModel(
                                                        active: misMaps[index]
                                                            .get('active'),
                                                        categoria: misMaps[index]
                                                            .get('categoria'),
                                                        idOrganization:
                                                            misMaps[index].get(
                                                                'idOrganization'),
                                                        idUser: provi3,
                                                        from: misMaps[index]
                                                            .get('from'),
                                                        id: misMaps[index]
                                                            .get('id'),
                                                        nombre: misMaps[index]
                                                            .get('nombre'),
                                                        presupuesto:
                                                            misMaps[index].get(
                                                                'presupuesto'),
                                                        until: misMaps[index]
                                                            .get('until'),
                                                        url: misMaps[index]
                                                            .get('url'),
                                                        cliente: misMaps[index]
                                                            .get('cliente'));

                                                    if (ResponsiveLayout
                                                        .isPhone(context))
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              '/modifyProject');
                                                    else
                                                      Provider.of<ProjectsProvider>(
                                                              context,
                                                              listen: false)
                                                          .set(ModifyProject());
                                                  },
                                                )
                                              : SizedBox(width: 10.0),
                                        ),
                                        Expanded(
                                          child: myUserModel.roles[1]
                                                      ["projects"]
                                                  ["projects_delete"]
                                              ? IconButton(
                                                  icon: Icon(
                                                      FeatherIcons.archive,
                                                      size: MediaQuery.of(context)
                                                                      .size
                                                                      .width >=
                                                                  600 &&
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width <=
                                                                  758.4000244140625
                                                          ? 25
                                                          : 30),
                                                  color: Color(0xFFC62626),
                                                  onPressed: () async {
                                                    Navigator.pushNamed(
                                                        context, '/animation');
                                                    List<String> provi4 =
                                                        misMaps[index]
                                                            .get("idUser")
                                                            .cast<String>();

                                                    myProjectModel2 = new ProjectModel(
                                                        categoria: misMaps[index]
                                                            .get('categoria'),
                                                        from: misMaps[index]
                                                            .get('from'),
                                                        id: misMaps[index]
                                                            .get('id'),
                                                        nombre: misMaps[index]
                                                            .get('nombre'),
                                                        idOrganization:
                                                            misMaps[index].get(
                                                                'idOrganization'),
                                                        idUser: provi4,
                                                        presupuesto:
                                                            misMaps[index].get(
                                                                'presupuesto'),
                                                        until: misMaps[index]
                                                            .get('until'),
                                                        url: misMaps[index]
                                                            .get('url'),
                                                        cliente: misMaps[index]
                                                            .get('cliente'),
                                                        active: false);
                                                    await ProjectServices
                                                        .modifyProject(
                                                            myProjectModel2,
                                                            myProjectModel2
                                                                .nombre);
                                                    catergori = null;
                                                    catergori = ["NaN"];
                                                    misMaps = [];
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('projects')
                                                        .where("active",
                                                            isEqualTo: true)
                                                        .where("idOrganization",
                                                            isEqualTo:
                                                                selectedCurrency)
                                                        .get()
                                                        .then((QuerySnapshot
                                                            querySnapshot) {
                                                      querySnapshot.docs
                                                          .forEach((doc) {
                                                        for (var i = 0;
                                                            i <
                                                                doc['idUser']
                                                                    .length;
                                                            i++) {
                                                          if (doc['idUser']
                                                                  [i] ==
                                                              myUserModel.id) {
                                                            misMaps.add(doc);
                                                            catergori.add(
                                                                misMaps[i].get(
                                                                    "nombre"));
                                                          }
                                                        }
                                                      });
                                                    });
                                                    Navigator
                                                        .pushReplacementNamed(
                                                            context, '/home');
                                                  },
                                                )
                                              : SizedBox(width: 10.0),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
        floatingActionButton: myUserModel.roles[1]["projects"]
                ["projects_create"]
            ? FloatingActionButton(
                heroTag: 1,
                onPressed: () {
                  fromM = "";
                  untilM = "";
                  if (ResponsiveLayout.isPhone(context))
                     Navigator.of(context).push(RotarPageRoute(WidgetTreeRegisterProject()));
                  else
                    Provider.of<ProjectsProvider>(context, listen: false)
                        .set(RegisterProject());
                },
                child: Icon(Icons.add, color: ArgonColors.white),
                backgroundColor: ArgonColors.initial,
              )
            : null);
  }
}
