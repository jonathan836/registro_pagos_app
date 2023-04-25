import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/add_payment_controller.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/widgets/add_payment_button.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/widgets/add_payment_inputs.dart';

import '../../../data/providers/add_payment_api.dart';
import '../../../widgets/global_alert.dart';

class AddPaymentPage extends StatelessWidget {
  final String name;
  final dynamic apartment, amount;

  AddPaymentPage({
    Key? key,
    required this.apartment,
    required this.name,
    required this.amount,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AddPaymentController>(
            create: (_) {
              return AddPaymentController(
                AddPaymentApi(Dio()),
                apartment: apartment,
                name: name,
                amount: amount,
              );
            },
          ),
        ],
        child: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: const Color.fromARGB(255, 11, 92, 130),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Agregar pago'),
                    IconButton(
                      onPressed: () {
                        showAlert(
                          context,
                          logout: true,
                          title: 'importante',
                          msg: '¿Está seguro que desea cerrar sesión?',
                        );
                      },
                      icon: const Icon(Icons.logout_rounded),
                    )
                  ],
                ),
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back)),
              ),
              key: _scaffoldKey,
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const AddPaymentInput(),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AddPaymentButton(_scaffoldKey),
                              // const FingerPrint()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
