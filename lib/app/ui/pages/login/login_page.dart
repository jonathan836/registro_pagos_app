import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:registro_pagos/app/ui/pages/login/widgets/go_register_page_button.dart';
import 'package:registro_pagos/app/ui/pages/login/widgets/login_button.dart';
import 'package:registro_pagos/app/ui/pages/login/widgets/login_inputs.dart';
import 'package:registro_pagos/app/ui/pages/login/widgets/logo_login.dart';
import '../../../data/login_impl.dart';
import '../../../data/providers/login_api.dart';
import '../login/login_controller.dart';

class LoginPage extends StatelessWidget {
  final String username, password;

  LoginPage({
    Key? key,
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
          ChangeNotifierProvider<LoginController>(
            create: (_) {
              return LoginController(
                LoginImpl(
                  LoginApi(Dio()),
                ),
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
                          const LoginLogo(),
                          const LoginInputs(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              LoginButton(_scaffoldKey),
                              // const FingerPrint()
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text('¿Has olvidado tu contraseña?'),
                          // const RememberUserPage(),
                          const SizedBox(height: 15),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Container(
                              color: Colors.black,
                              height: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const GoRegistePagerButton()
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
