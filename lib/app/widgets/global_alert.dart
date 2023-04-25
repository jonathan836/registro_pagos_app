import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/pages/login/login_controller.dart';
import '../ui/pages/login/logout_controller.dart';
import '../ui/routes/routes.dart';
import 'global_alert_options.dart';
import 'global_loading.dart';

void showAlert(
  BuildContext contextAn, {
  required String msg,
  required String title,
  bool? logout,
  LoginController? model,
  GlobalKey<ScaffoldState>? key,
}) {
  showDialog(
    barrierDismissible: false,
    context: contextAn,
    builder: (BuildContext context) {
      final controller = Provider.of<LogoutController>(context);
      return WillPopScope(
        onWillPop: () async => false,
        child: CupertinoAlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: Text(msg),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.black),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () async {
                Navigator.of(context).pop();
                globalLoading(contextAn);
                if (logout != null && logout == true) {
                  await controller.logout();
                  Navigator.pushNamedAndRemoveUntil(
                      contextAn, Routes.LOGIN, (Route<dynamic> route) => false);
                } else if (logout != null && logout == false) {
                  try {
                    final prefs = await SharedPreferences.getInstance();
                    final String? username = prefs.getString('username');
                    final String? profile = prefs.getString('profile');
                    final String? token = prefs.getString('token');

                    if (username == null || token == null || profile == null) {
                      await controller.logout();
                      await loginAgain(contextAn, model);
                    } else {
                      final prefs = await SharedPreferences.getInstance();
                      final String? token = prefs.getString('token');
                      loginSuccess(contextAn, token!, profile);
                    }
                  } on DioError catch (e) {
                    Navigator.of(context).pop();
                    if (e.type == DioErrorType.badResponse) {
                      showAlertOptions(
                        context,
                        msg:
                            'Disculpe, en estos momentos no hay conexión a internet',
                        title: 'Importante',
                      );
                    } else {
                      showAlertOptions(
                        context,
                        msg: "Error del servidor",
                        title: 'Importante',
                      );
                    }
                  } catch (e) {
                    showAlertOptions(
                      context,
                      msg: "Error del servidor",
                      title: 'Importante',
                    );
                  }
                } else {
                  Navigator.of(contextAn).pop();
                }
              },
              child: const Text(
                'Aceptar',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> loginSuccess(
    BuildContext context, String token, String? perfil) async {
  final pref = await SharedPreferences.getInstance();
  await pref.setString('token', token);
  Navigator.pop(context);
  Navigator.of(context).pushNamed(Routes.HOME);
}

Future<void> loginAgain(BuildContext context, LoginController? model) async {
  final response = await model!.submitData();
  if (response != null) {
    final controller = Provider.of<LoginController>(context, listen: false);
    final pref = await SharedPreferences.getInstance();
    await pref.setString('token', response.data);
    await pref.setInt('profile', response.profile);
    await pref.setInt('idUser', response.id);
    await pref.setString('username', controller.usernameController.text);
    await pref.setString('password', controller.passwordController.text);
    await pref.setString('usernamePrefs', controller.usernameController.text);
    await pref.setString('passwordPrefs', controller.passwordController.text);
    Navigator.pop(context);
    Navigator.of(context).pushNamed(Routes.HOME);
  } else {
    Navigator.pop(context);
    showAlertOptions(context,
        msg: 'Error al iniciar sesion', title: 'Importante');
  }
}
