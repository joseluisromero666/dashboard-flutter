import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/Responsive/widgetTreeRegisContract.dart';
import 'package:argon_flutter/models/contractModel.dart';
import 'package:argon_flutter/models/contractProvider.dart';
import 'package:argon_flutter/models/userModel.dart';
import 'package:argon_flutter/screens/RegisterContracts.dart';
import 'package:argon_flutter/screens/profiles.dart';
import 'package:argon_flutter/screens/specificContract.dart';
import 'package:argon_flutter/services/contratosServices.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:provider/provider.dart';

import 'modifyContract.dart';

// ignore: must_be_immutable
class Contracts extends StatefulWidget {
  var tamanio;
  Contracts({Key key, this.tamanio}) : super(key: key);
  @override
  _ContractsState createState() => _ContractsState();
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

class _ContractsState extends State<Contracts> {
  bool kIsWeb = identical(0, 0.0);
  var tm;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 0, right: 0),
        child: Scaffold(
            appBar: ResponsiveLayout.isPhone(context)
                ? Navbar(
                    avatar: true,
                    rightOptions: false,
                    prefferedHeight: 60,
                    bgColor: ArgonColors.initial,
                  )
                : null,
            backgroundColor: Theme.of(context).primaryColor == Colors.green[500]
                ? Colors.grey[800]
                : Theme.of(context).primaryColor == Colors.indigo[500]
                    ? ArgonColors.white
                    : Colors.blue[800],
            drawer: ArgonDrawer(currentPage: "Contracts"),
            body: Column(
              children: [
                SizedBox(height: 22.0),
                Text("Contracts", style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 22.0),
                Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('contracts')
                            .where("active", isEqualTo: true)
                            .where("idUser", isEqualTo: myUserModel.id)
                            .where("idOrganization", isEqualTo: selectedCurrency)
                            .snapshots(),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? (snapshot.data.docs.length != 0
                                  ? GridView(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: ResponsiveLayout.isPhone(context)
                                            ? 2
                                            : ResponsiveLayout.isTablet(context)
                                                ? (kIsWeb)
                                                    ? 2
                                                    : 2
                                                : ResponsiveLayout.isDesktop(context)
                                                    ? (kIsWeb)
                                                        ? MediaQuery.of(context).size.width >= 1000 &&
                                                                MediaQuery.of(context).size.width <= 1242.4000244140625
                                                            ? 2
                                                            : 3
                                                        : 4
                                                    : null,
                                        childAspectRatio: (kIsWeb)
                                            ? ResponsiveLayout.isDesktop(context)
                                                ? MediaQuery.of(context).size.width >= 1000 &&
                                                        MediaQuery.of(context).size.width <= 1128
                                                    ? 0.86
                                                    : MediaQuery.of(context).size.width >= 1128 &&
                                                            MediaQuery.of(context).size.width <= 1238.4000244140625
                                                        ? 0.98
                                                        : MediaQuery.of(context).size.width >= 1238.4000244140625 &&
                                                                MediaQuery.of(context).size.width <= 1340
                                                            ? 0.72
                                                            : MediaQuery.of(context).size.width >= 1341 &&
                                                                    MediaQuery.of(context).size.width <= 1444
                                                                ? 0.77
                                                                : MediaQuery.of(context).size.width >= 1445 &&
                                                                        MediaQuery.of(context).size.width <= 1536
                                                                    ? 0.84
                                                                    : 0.90
                                                : ResponsiveLayout.isTablet(context)
                                                    ? MediaQuery.of(context).size.width >= 600 &&
                                                            MediaQuery.of(context).size.width <= 650.4000244140625
                                                        ? 0.57
                                                        : MediaQuery.of(context).size.width >= 650.4000244140625 &&
                                                                MediaQuery.of(context).size.width <= 718
                                                            ? 0.62
                                                            : MediaQuery.of(context).size.width >= 719 &&
                                                                    MediaQuery.of(context).size.width <= 814
                                                                ? 0.68
                                                                : MediaQuery.of(context).size.width >= 815 &&
                                                                        MediaQuery.of(context).size.width <= 900
                                                                    ? 0.75
                                                                    : 0.85
                                                    : ResponsiveLayout.isPhone(context)
                                                        ? MediaQuery.of(context).size.width >= 300 &&
                                                                MediaQuery.of(context).size.width <= 537.5999755859375
                                                            ? 0.95
                                                            : 1
                                                        : null
                                            : ResponsiveLayout.isDesktop(context)
                                                ? ResponsiveLayout.isRotated(context)
                                                    ? 0.57
                                                    : 0.57
                                                : ResponsiveLayout.isTablet(context)
                                                    ? ResponsiveLayout.isRotated(context)
                                                        ? 0.95
                                                        : MediaQuery.of(context).size.width >= 600 &&
                                                                MediaQuery.of(context).size.width <= 650.4000244140625
                                                            ? 0.60
                                                            : 0.80
                                                    : ResponsiveLayout.isPhone(context)
                                                        ? ResponsiveLayout.isRotated(context)
                                                            ? 1.20
                                                            : 0.78
                                                        : null,
                                      ),
                                      scrollDirection: Axis.vertical,
                                      children: [
                                        ...snapshot.data.docs
                                            .map((doc) {
                                              return Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(2, 0, 2, 0),
                                                child: Card(
                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                  color: Theme.of(context).primaryColor == Colors.green[500]
                                                      ? Colors.grey[700]
                                                      : Theme.of(context).primaryColor == Colors.indigo[500]
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
                                                          myContractModel = new ContractModel(
                                                            active: doc.get('active'),
                                                            apellidos: doc.get('apellidos'),
                                                            from: doc.get('from'),
                                                            id: doc.get('id'),
                                                            nombres: doc.get('nombres'),
                                                            type: doc.get('type'),
                                                            until: doc.get('until'),
                                                            url: doc.get('url'),
                                                            valor: doc.get('valor'),
                                                            idUser: doc.get('idUser'),
                                                            idOrganization: doc.get('idOrganization'),
                                                            proyecto: doc.get('proyecto'),
                                                          );
                                                          print(myContractModel.toMap());
                                                          myContractModelInitial = myContractModel;
                                                          if (ResponsiveLayout.isPhone(context))
                                                            Navigator.pushReplacementNamed(
                                                                context, '/SpecificContract');
                                                          else
                                                            Provider.of<ContractsProvider>(context, listen: false)
                                                                .set(SpecificContract());
                                                        },
                                                        child: Image.network(
                                                          doc.get('url'),
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
                                                              height: (kIsWeb)
                                                                  ? 135
                                                                  : 110,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(context)
                                                                            .primaryColor ==
                                                                        Colors.green[
                                                                            500]
                                                                    ? Colors.grey[
                                                                        700]
                                                                    : Theme.of(context).primaryColor ==
                                                                            Colors.indigo[
                                                                                500]
                                                                        ? ArgonColors
                                                                            .white
                                                                        : Colors
                                                                            .blue[600],
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                    (kIsWeb) ? 20 : 10, 20, 0, 0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Expanded(
                                                                        child: Text(
                                                                      doc.get('nombres'),
                                                                      style: TextStyle(
                                                                        fontFamily: 'Poppins',
                                                                        fontSize: (kIsWeb)
                                                                            ? MediaQuery.of(context).size.width >=
                                                                                        600 &&
                                                                                    MediaQuery.of(context).size.width <=
                                                                                        650.4000244140625
                                                                                ? 15
                                                                                : 20
                                                                            : 20,
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                                    )),
                                                                    SizedBox(height: 5.0),
                                                                    Expanded(
                                                                        child: Text(
                                                                      doc.get('type'),
                                                                      style: TextStyle(
                                                                          fontFamily: 'Poppins',
                                                                          color: Theme.of(context).primaryColor ==
                                                                                  Colors.green[500]
                                                                              ? Colors.white
                                                                              : Theme.of(context).primaryColor ==
                                                                                      Colors.indigo[500]
                                                                                  ? ArgonColors.black
                                                                                  : Colors.black,
                                                                          fontSize: (kIsWeb)
                                                                              ? MediaQuery.of(context).size.width >=
                                                                                          600 &&
                                                                                      MediaQuery.of(context)
                                                                                              .size
                                                                                              .width <=
                                                                                          650.4000244140625
                                                                                  ? 12
                                                                                  : 14
                                                                              : 14,
                                                                          fontWeight: FontWeight.bold),
                                                                    )),
                                                                    SizedBox(height: 2.0),
                                                                    Expanded(
                                                                        child: Text(
                                                                      "\$ " + doc.get('valor'),
                                                                      style: TextStyle(
                                                                          fontFamily: 'Poppins',
                                                                          color: Theme.of(context).primaryColor ==
                                                                                  Colors.green[500]
                                                                              ? Colors.white
                                                                              : Theme.of(context).primaryColor ==
                                                                                      Colors.indigo[500]
                                                                                  ? Color(0xFF4A50C3)
                                                                                  : Colors.black,
                                                                          fontSize: (kIsWeb)
                                                                              ? MediaQuery.of(context).size.width >=
                                                                                          600 &&
                                                                                      MediaQuery.of(context)
                                                                                              .size
                                                                                              .width <=
                                                                                          650.4000244140625
                                                                                  ? 10
                                                                                  : 13
                                                                              : 13,
                                                                          fontWeight: FontWeight.bold),
                                                                    )),
                                                                    SizedBox(height: 2.0),
                                                                    Expanded(
                                                                        child: Text(
                                                                      doc.get('proyecto'),
                                                                      style: TextStyle(
                                                                          color: Theme.of(context).primaryColor ==
                                                                                  Colors.green[500]
                                                                              ? Colors.white
                                                                              : Theme.of(context).primaryColor ==
                                                                                      Colors.indigo[500]
                                                                                  ? ArgonColors.black
                                                                                  : Colors.black,
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: (kIsWeb)
                                                                              ? MediaQuery.of(context).size.width >=
                                                                                          600 &&
                                                                                      MediaQuery.of(context)
                                                                                              .size
                                                                                              .width <=
                                                                                          650.4000244140625
                                                                                  ? 9
                                                                                  : 11
                                                                              : 11,
                                                                          fontWeight: FontWeight.bold),
                                                                    )),
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
                                                                  0, 0, (kIsWeb) ? 20 : 0, 0),
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.max,
                                                                children: [
                                                                  Expanded(
                                                                    child: myUserModel.roles[2]["contracts"]
                                                                            ["contracts_update"]
                                                                        ? IconButton(
                                                                            icon: Icon(FeatherIcons.edit,
                                                                                size: (kIsWeb)
                                                                                    ? MediaQuery.of(context)
                                                                                                    .size
                                                                                                    .width >=
                                                                                                600 &&
                                                                                            MediaQuery.of(context)
                                                                                                    .size
                                                                                                    .width <=
                                                                                                650.4000244140625
                                                                                        ? 25
                                                                                        : 30
                                                                                    : 25),
                                                                            color: Color(0xFF8BC34A),
                                                                            onPressed: () async {
                                                                              myContractModel = new ContractModel(
                                                                                active: doc.get('active'),
                                                                                apellidos: doc.get('apellidos'),
                                                                                from: doc.get('from'),
                                                                                id: doc.get('id'),
                                                                                nombres: doc.get('nombres'),
                                                                                type: doc.get('type'),
                                                                                until: doc.get('until'),
                                                                                url: doc.get('url'),
                                                                                valor: doc.get('valor'),
                                                                                proyecto: doc.get('proyecto'),
                                                                              );

                                                                              if (ResponsiveLayout.isPhone(context))
                                                                                Navigator.pushReplacementNamed(
                                                                                    context, '/modifyContract');
                                                                              else
                                                                                Provider.of<ContractsProvider>(context,
                                                                                        listen: false)
                                                                                    .set(ModifyContract());
                                                                            },
                                                                          )
                                                                        : SizedBox(width: 10.0),
                                                                  ),
                                                                  Expanded(
                                                                    child: myUserModel.roles[2]["contracts"]
                                                                            ["contracts_delete"]
                                                                        ? IconButton(
                                                                            icon: Icon(FeatherIcons.archive,
                                                                                size: (kIsWeb)
                                                                                    ? MediaQuery.of(context)
                                                                                                    .size
                                                                                                    .width >=
                                                                                                600 &&
                                                                                            MediaQuery.of(context)
                                                                                                    .size
                                                                                                    .width <=
                                                                                                650.4000244140625
                                                                                        ? 25
                                                                                        : 30
                                                                                    : 25),
                                                                            color: Color(0xFFC62626),
                                                                            onPressed: () async {
                                                                              myContractModelAdd2 = new ContractModel(
                                                                                active: false,
                                                                                apellidos: doc.get('apellidos'),
                                                                                from: doc.get('from'),
                                                                                id: doc.get('id'),
                                                                                nombres: doc.get('nombres'),
                                                                                type: doc.get('type'),
                                                                                until: doc.get('until'),
                                                                                url: doc.get('url'),
                                                                                valor: doc.get('valor'),
                                                                                proyecto: doc.get('proyecto'),
                                                                              );
                                                                              ContratosServices.modifyContract(
                                                                                  myContractModelAdd2, doc.get('id'));
                                                                              if (ResponsiveLayout.isPhone(context))
                                                                                Navigator.pushReplacementNamed(
                                                                                    context, '/contracts');
                                                                              else
                                                                                Navigator.pushReplacementNamed(
                                                                                    context, '/contracts');
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
                                            })
                                            .toList()
                                            .cast<Widget>()
                                      ],
                                    )
                                  : Center(child: Text('There is no data in the Database')))
                              : Center(
                                  child: CircularProgressIndicator(),
                                );
                        }))
              ],
            ),
            floatingActionButton: myUserModel.roles[2]["contracts"]["contracts_create"]
                ? FloatingActionButton(
                    heroTag: 1,
                    onPressed: () async {
                      fromMC = "";
                      untilMC = "";
                      nombresMC = TextEditingController();
                      apellidosMC = TextEditingController();
                      typeMC = "";
                      urlMC = TextEditingController();
                      valorMC = TextEditingController();
                      proyecto = "";
                      typeMC = "";
                      projectsMC = ["NaN"];

                      if (ResponsiveLayout.isPhone(context))
                        Navigator.of(context).push(RotarPageRoute(WidgetTreeRegisContract()));
                      else
                        Provider.of<ContractsProvider>(context, listen: false)
                            .set(RegisterContracts());
                    },
                    child: Icon(Icons.add, color: ArgonColors.white),
                    backgroundColor: ArgonColors.initial,
                  )
                : null));
  }
}
