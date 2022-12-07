import 'package:argon_flutter/constants/Theme.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Card(
                          color: Theme.of(context).primaryColor ==
                                  Colors.green[500]
                              ? Colors.grey[600]
                              : Theme.of(context).primaryColor ==
                                      Colors.indigo[500]
                                  ? Colors.blue[400]
                                  : Colors.blue[600],
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: CircleAvatar(
                                    backgroundImage: Image.network(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStMQsCHVlBRy419TWlJaLa8NfwckVfQaLVAA&usqp=CAU',
                                    ).image,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Text('Jose Luis',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time),
                                            Text('Hours: 5 hr'),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Card(
                          color: Theme.of(context).primaryColor ==
                                  Colors.green[500]
                              ? Colors.grey[600]
                              : Theme.of(context).primaryColor ==
                                      Colors.indigo[500]
                                  ? Colors.blue[400]
                                  : Colors.blue[600],
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: CircleAvatar(
                                    backgroundImage: Image.network(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStMQsCHVlBRy419TWlJaLa8NfwckVfQaLVAA&usqp=CAU',
                                    ).image,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Text('Jose Luis',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time),
                                            Text('Hours: 5 hr'),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Card(
                          color: Theme.of(context).primaryColor ==
                                  Colors.green[500]
                              ? Colors.grey[600]
                              : Theme.of(context).primaryColor ==
                                      Colors.indigo[500]
                                  ? Colors.blue[400]
                                  : Colors.blue[600],
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: CircleAvatar(
                                    backgroundImage: Image.network(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStMQsCHVlBRy419TWlJaLa8NfwckVfQaLVAA&usqp=CAU',
                                    ).image,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Text('Jose Luis',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time),
                                            Text('Hours: 5 hr'),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: const Icon(FeatherIcons.download),
        backgroundColor: ArgonColors.initial,
      ),
    );
  }
}
