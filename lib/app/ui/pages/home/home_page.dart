import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:registro_pagos/app/ui/routes/routes.dart';

import '../../../widgets/global_alert.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Stack(
          children: [
            Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color.fromARGB(255, 11, 92, 130),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Menu'),
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
                ),
                body: Column(children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: CupertinoButton(
                          color: const Color.fromARGB(255, 11, 92, 130),
                          borderRadius: BorderRadius.circular(30),
                          child: const Text('Agregar registro'),
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.ADD_PAYMENT);
                          }),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: CupertinoButton(
                          color: const Color.fromARGB(255, 11, 92, 130),
                          borderRadius: BorderRadius.circular(30),
                          child: const Text('Ver registro'),
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.PAYMENT_RECORD);
                          }),
                    ),
                  )
                ])),
          ],
        ),
        onWillPop: () async {
          return false;
        });
  }
}
