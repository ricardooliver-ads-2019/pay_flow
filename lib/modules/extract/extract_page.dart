import 'package:flutter/material.dart';
import 'package:pay_flow/shared/models/boleto_model.dart';
import 'package:pay_flow/shared/themes/app_colors.dart';
import 'package:pay_flow/shared/themes/app_text_styles.dart';
import 'package:pay_flow/shared/widgets/boleto_info/boleto_info_widget.dart';
import 'package:pay_flow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:pay_flow/shared/widgets/boleto_list/boleto_list_widget.dart';

class ExtractPagePage extends StatefulWidget {
  const ExtractPagePage({ Key? key }) : super(key: key);

  @override
  _ExtractPagePageState createState() => _ExtractPagePageState();
}

class _ExtractPagePageState extends State<ExtractPagePage> {
  final controller = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 10),
            child: Container(
              child: Row(
                children: [
                  Text("Meus Extratos", 
                    style: AppTextStyles.titleBoldHeading,
                  ),
                ],
              ),
            ),
          ),
    
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Divider(
              thickness: 1,
              height: 1,
              color: AppColors.primary,
            ),
          ),
    
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BoletoListWidget(
              controller: controller,
            ),
          )
        ],
      ),
    );
  }
}