import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/global_alert_options.dart';
import '../../../../widgets/global_loading.dart';
import '../../../routes/routes.dart';
import '../register_controller.dart';
import '../register_model.dart';

class RegisterButton extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  const RegisterButton(
    this._scaffoldKey, {
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  bool _buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterController>(
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
                    final RegisterModel? result =
                        await model.submitRegisterData();
                    Navigator.of(context).pop();
                    if (result != null) {
                      if (result.status == 'SUCCESS') {
                        registerSuccess(context);
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
        child: const Text('Registrarte'),
      ),
    );
  }

  Future<void> registerSuccess(
    BuildContext context,
  ) async {
    Navigator.of(context).pop();
  }
}
