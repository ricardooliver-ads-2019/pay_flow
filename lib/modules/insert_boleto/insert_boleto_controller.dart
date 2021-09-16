import 'package:flutter/cupertino.dart';
import 'package:pay_flow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBoletoController{
  final formKey = GlobalKey<FormState>();
  BoletoModel model= BoletoModel();


  String? validateName(String? value)=> value?.isEmpty ?? true ? "O nome do boleto não pode ser vazio": null;

  String? validateVacimento(String? value)=> value?.isEmpty ?? true ? "A data de vencimento não pode ser vazio":null;

  String? validateValor(double value)=> value == 0 ? "Insira um valor maior que R\$ 0,00" : null;

  String? validateCodigo(String? value) => value?.isEmpty ?? true ? "O Código do boleto não pode ser vazio" : null; 

  void onChange({
    String? name,
    String? dueDate, 
    double? value, 
    String? barcode,
    }){
      model = model.copyWith();
  }

  Future<void> saveBoleto() async{
 
      final instance =await SharedPreferences.getInstance();
      final boletos = instance.getStringList("boletos") ?? <String>[];
      boletos.add(model.toJson());
      await instance.setStringList("boletos", boletos);
      return;
   
    

  }

  Future<void> cadastrarBoleto() async{
    final form = formKey.currentState;
    if(form!.validate()){
      return saveBoleto();
    }
  }
}