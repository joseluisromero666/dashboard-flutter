import 'package:flutter/widgets.dart';

class ContractModel {
  String url = "";
  String nombres = "";
  String apellidos = "";
  String type = "";
  String from = "";
  String until = "";
  String valor = "";
  String id = "";
  String managerId = "";
  bool active = true;
  String proyecto = "";
  String idUser = "";
  String idOrganization = "";
  String contractorId = "";
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'nombres': nombres,
      'apellidos': apellidos,
      'type': type,
      'from': from,
      'until': until,
      'valor': valor,
      'active': active,
      'proyecto': proyecto,
      'managerId': managerId,
      'idUser': idUser,
      'idOrganization': idOrganization,
      'contractorId': contractorId
    };
  }

  ContractModel(
      {this.id,
      this.url,
      this.nombres,
      this.apellidos,
      this.type,
      this.from,
      this.until,
      this.valor,
      this.active,
      this.proyecto,
      this.managerId,
      this.idUser,
      this.idOrganization,
      this.contractorId});
}

var urlMC = TextEditingController();
var nombresMC = TextEditingController();
var apellidosMC = TextEditingController();
var titleMC = TextEditingController();
String contratanteMC;
String typeMC;
String fromMC;
String untilMC;
dynamic contractorMC;
dynamic hiredMC;
var valorMC = TextEditingController();
var idNMC = TextEditingController();
ContractModel myContractModel;
ContractModel myContractModelAdd;
ContractModel myContractModelAdd2;
String idMC;
ContractModel myContractModelMod;
bool activeMC;
var urlMCMod = TextEditingController();
var nombresMCMod = TextEditingController();
var apellidosMCMod = TextEditingController();
String contratanteMCMod;
String typeMCMod;
String fromMCMod;
String untilMCMod;
var valorMCMod = TextEditingController();
String proyectoMCMod;
List<ContractModel> articlesCards = [];
List<String> projectsMC = ["NaN"];
List<String> projectsMCMod = ["NaN"];
ContractModel myContractModelInitial;
bool regsCts = true;
bool editCts;

List<String> catergory;
