import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:registro_pagos/app/ui/pages/register/register_controller.dart';
import 'package:registro_pagos/app/ui/pages/register/widgets/register_button.dart';
import 'package:registro_pagos/app/ui/pages/register/widgets/register_inputs.dart';
import 'package:registro_pagos/app/ui/pages/register/widgets/register_logo.dart';
import '../../../data/providers/register_api.dart';
import '../../routes/routes.dart';

class RegisterPage extends StatelessWidget {
  final String firstName, lastName, username, password;

  RegisterPage({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //checkLogin(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<RegisterController>(
            create: (_) {
              return RegisterController(
                RegisterApi(Dio()),
                firstName: firstName,
                lastName: lastName,
                username: username,
                password: password,
              );
            },
          ),
          // ChangeNotifierProvider<FingerprintController>(create: (_) {
          //   return FingerprintController(context);
          // }),
        ],
        child: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            Scaffold(
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
                          const RegisterLogo(),
                          const RegisterInputs(),
                          // const RememberUserPage(),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RegisterButton(_scaffoldKey),
                              // const FingerPrint()
                            ],
                          ),
                          // const SizedBox(height: 15),
                          TextButton(
                            child: const Text(
                              'Inicia Sesión',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () async {
                              Navigator.of(context).pushNamed(Routes.LOGIN);
                            },
                          )
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
