import 'dart:ui';
import 'package:argon_flutter/Responsive/responsiveController.dart';
import 'package:argon_flutter/models/contractModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductCarousel extends StatefulWidget {
  final List<ContractModel> imgArray;

  const ProductCarousel({
    Key key,
    @required this.imgArray,
  }) : super(key: key);

  @override
  _ProductCarouselState createState() => _ProductCarouselState();
}

class _ProductCarouselState extends State<ProductCarousel> {
  // ignore: unused_field
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('contracts').snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? (snapshot.data.docs.length != 0
                  ? CarouselSlider(
                      items: snapshot.data.docs
                          .map((document) => Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(
                                              color: Color.fromRGBO(0, 0, 0, 0.4),
                                              blurRadius: 8,
                                              spreadRadius: 0.3,
                                              offset: Offset(0, 3))
                                        ]),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(4),
                                          child: Container(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(context, '/contract');
                                              },
                                              child: Image.network(
                                                document.get('url'),
                                                fit: BoxFit.fill,
                                                width: 800,
                                                height: ResponsiveLayout.isDesktop(context) ? 400 : 350,
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 16.0),
                                      child: Column(
                                        children: [
                                          Text(document.get('nombres'),
                                              style: TextStyle(fontSize: 16, color: Colors.black87),
                                              textAlign: TextAlign.center),
                                          Text(document.get('apellidos'),
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black54,
                                              ),
                                              textAlign: TextAlign.center),
                                          Text(
                                            document.get('valor'),
                                            style: TextStyle(fontSize: 16, color: Colors.black45),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ))
                          .toList()
                          .cast<Widget>(),
                      options: CarouselOptions(
                          height: 530,
                          autoPlay: false,
                          enlargeCenterPage: false,
                          enableInfiniteScroll: true,
                          initialPage: 0,
                          viewportFraction: ResponsiveLayout.isDesktop(context) ? 0.5 : 0.8,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    )
                  : Text('No existen productos en la Base de Datos'))
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
