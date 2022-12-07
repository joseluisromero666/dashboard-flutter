import 'package:argon_flutter/models/contractModel.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContratosServices extends ChangeNotifier {
  static var v;
  static CollectionReference projects = FirebaseFirestore.instance.collection('contracts');
  static CollectionReference users = FirebaseFirestore.instance.collection('users');
  static CollectionReference contracts = FirebaseFirestore.instance.collection('contracts');

  static Future<String> addNewContractModel(ContractModel myContract) async {
    v = await FirebaseFirestore.instance.collection('contracts').add(myContract.toMap());
    myContract.id = v.id;
    modifyContract(myContract, myContract.id);
    return v.id;
  }

  static Future<void> modifyContract(ContractModel myContract, String id) {
    return contracts.doc(id).update({
      'id': myContract.id,
      'from': myContract.from,
      'until': myContract.until,
      'apellidos': myContract.apellidos,
      'nombres': myContract.nombres,
      'type': myContract.type,
      'url': myContract.url,
      'valor': myContract.valor,
      'active': myContract.active,
      'proyecto': myContract.proyecto,
      'managerId': myContract.managerId
    });
  }
}
