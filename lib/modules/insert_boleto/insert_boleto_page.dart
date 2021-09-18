import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pay_flow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:pay_flow/shared/themes/app_colors.dart';
import 'package:pay_flow/shared/themes/app_text_styles.dart';
import 'package:pay_flow/shared/widgets/input_text/input_text_widget.dart';
import 'package:pay_flow/shared/widgets/set_lebal_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({
    Key? key,
    this.barcode,
  }) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();

  final moneyInputTextController = MoneyMaskedTextController(
      leftSymbol: "R\$", initialValue: 0, decimalSeparator: ",");
  final vencimentoInputTextController =
      MaskedTextController(mask: "00/00/0000");
  final codigoInputTextController = TextEditingController();

  @override
  void initState() {
    if (widget.barcode != null) {
      codigoInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 93, vertical: 24),
                child: Text(
                  "Preencha os dados do boleto",
                  style: AppTextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    InputTextWidget(
                      label: "Nome do boleto",
                      icon: Icons.description_outlined,
                      onChanged: (value) {
                        controller.onChange(name: value);
                      },
                      validator: controller.validateName,
                    ),
                    InputTextWidget(
                      controller: vencimentoInputTextController,
                      label: "Vencimento",
                      icon: FontAwesomeIcons.timesCircle,
                      onChanged: (value) {
                        controller.onChange(dueDate: value);
                      },
                      validator: controller.validateVencimento,
                    ),
                    InputTextWidget(
                      controller: moneyInputTextController,
                      label: "Valor",
                      icon: FontAwesomeIcons.wallet,
                      validator: (_) => controller
                          .validateValor(moneyInputTextController.numberValue),
                      onChanged: (value) {
                        controller.onChange(
                            value: moneyInputTextController.numberValue);
                      },
                    ),
                    InputTextWidget(
                      controller: codigoInputTextController,
                      label: "Código",
                      icon: FontAwesomeIcons.barcode,
                      validator: controller.validateCodigo,
                      onChanged: (value) {
                        controller.onChange(barcode: value);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.stroke,
          ),
          SetLabelButtons(
            enableSecondaryColor: true,
            labelPrimary: "Cancelar",
            onTapPrimary: () {
              Navigator.pop(context);
            },
            labelSecondary: "Cadastrar",
            onTapSecondary: () async {
              await controller.cadastrarBoleto();
              if (controller.respSaveBoleto == false) {
                print(controller.respSaveBoleto);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: AppColors.stroke,
                  content: Container(
                    height: 120,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text("Não foi possivel cadastar o boleto!", 
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red),
                          ),
                        ),

                        Icon(Icons.sentiment_dissatisfied_outlined, size: 50, color: Colors.red,)
                      ],
                    ),
                  )
                )
                );
              } else {
                
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: AppColors.stroke,
                  content: Container(
                    height: 120,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text("Boleto Cadastrado com Sucesso!", 
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red),
                          ),
                        ),

                        Row(
                          children: [
                            Icon(Icons.sentiment_very_satisfied, size: 50, color: Colors.red,),
                            Icon(Icons.check, size: 50, color: Colors.red,),

                          ],
                        )
                      ],
                    ),
                  )
                )
                );
                Navigator.pop(context);
              }
              
            },
          ),
        ],
      ),
    );
  }
}
