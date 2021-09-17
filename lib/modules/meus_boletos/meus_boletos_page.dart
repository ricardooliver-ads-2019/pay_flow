import 'package:flutter/material.dart';
import 'package:pay_flow/shared/themes/app_colors.dart';
import 'package:pay_flow/shared/themes/app_text_styles.dart';
import 'package:pay_flow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:pay_flow/shared/widgets/boleto_list/boleto_list_widget.dart';

class MeusBoletosPage extends StatefulWidget {
  const MeusBoletosPage({ Key? key }) : super(key: key);

  @override
  _MeusBoletosPageState createState() => _MeusBoletosPageState();
}

class _MeusBoletosPageState extends State<MeusBoletosPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24,top: 24,bottom: 10),
            child: Container(
              child: Row(
                children: [
                  Text("Meus Boletos", 
                    style: AppTextStyles.titleBoldHeading,
                  ),
                ],
              ),
            ),
          ),
    
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Divider(
              thickness: 1,
              height: 1,
              color: AppColors.primary,
            ),
          ),
    
          BoletoListWidget()
        ],
      ),
    );
  }
}