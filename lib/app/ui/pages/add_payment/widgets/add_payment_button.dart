import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/add_payment_controller.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/add_payment_model.dart';

import '../../../../widgets/global_alert_options.dart';
import '../../../../widgets/global_loading.dart';
import '../../register/register_controller.dart';

class AddPaymentButton extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  const AddPaymentButton(
    this._scaffoldKey, {
    Key? key,
  }) : super(key: key);

  @override
  State<AddPaymentButton> createState() => _AddPaymentButtonState();
}

class _AddPaymentButtonState extends State<AddPaymentButton> {
  bool _buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPaymentController>(
      builder: (context, model, child) => CupertinoButton(
        disabledColor: const Color.fromARGB(255, 11, 92, 130).withOpacity(0.4),
        pressedOpacity: 1,
        color: const Color.fromARGB(255, 11, 92, 130),
        borderRadius: BorderRadius.circular(30),
        onPressed: (!model.validate)
            ? null
            : () async {
                globalLoading(context);
                if (!_buttonPressed) {
                  try {
                    _buttonPressed = true;
                    FocusScope.of(context).unfocus();
                    final AddPaymentModel? result = await model.addPayment();
                    Navigator.of(context).pop();
                    if (result != null) {
                      if (result.status == 'SUCCESS') {
                        paymentAdded(context, result.data);
                      } else if (result.status == 'Error') {
                        showAlertOptions(
                          context,
                          title: 'Importante',
                          msg: 'Usuario y/o contraseña incorrecta.',
                        );
                      }
                    } else {
                      showAlertOptions(
                        context,
                        title: 'Importante',
                        msg:
                            'Disculpe, en estos momentos no hay conexión a internet',
                      );
                    }
                    _buttonPressed = false;
                  } on DioError catch (e) {
                    Navigator.of(context).pop();
                    if (e.error == "Connection refused") {
                      showAlertOptions(
                        context,
                        msg: "Error del servidor",
                        title: 'Importante',
                      );
                    } else {
                      showAlertOptions(
                        context,
                        msg:
                            'Disculpe, en estos momentos no hay conexión a internet',
                        title: 'Importante',
                      );
                    }
                    _buttonPressed = false;
                  } catch (e) {
                    Navigator.of(context).pop();
                    showAlertOptions(
                      context,
                      msg: "Error del servidor",
                      title: 'Importante',
                    );
                  }
                }
              },
        child: const Text('Agregar pago'),
      ),
    );
  }
}

Future<void> paymentAdded(
  BuildContext context,
  String msg,
) async {
  showAlertOptions(
    context,
    title: 'Importante',
    msg: msg,
  );
}
