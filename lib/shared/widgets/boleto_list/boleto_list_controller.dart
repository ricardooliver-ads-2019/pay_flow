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

  

  Future<void> getBoletos() async {
    try {
      final instace = await SharedPreferences.getInstance();
      final reponse = instace.getStringList("boletos") ?? <String>[];
      
      boletos= reponse.map((e) => BoletoModel.fromJson(e)).toList();
    } catch (e) {
      boletos = <BoletoModel>[];
    }
  }

  void dispose() {
    boletosNotifier.dispose();
  }
}