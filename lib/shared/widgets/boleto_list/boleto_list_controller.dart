import 'package:flutter/cupertino.dart';
import 'package:pay_flow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoletoListController{
  final boletosNotifier = ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);
  List<BoletoModel> get boletos => boletosNotifier.value;
  set boletos(List<BoletoModel> value) => boletosNotifier.value = value;

  BoletoListController(){
    getBoletos();
  }

  

  void getBoletos() async {
    try {
      final instace = await SharedPreferences.getInstance();
      final reponse = instace.getStringList("boletos");
      boletos= reponse!.map((e) => BoletoModel.fromJson(e)).toList();
    } catch (e) {
      
    }
  }

  void dispose() {
    boletosNotifier.dispose();
  }
}