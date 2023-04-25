import 'package:flutter/material.dart';
import 'package:registro_pagos/app/theme/theme.dart';

class RegisterLogo extends StatelessWidget {
  const RegisterLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: MediaQuery.of(context).size.width / 1.4,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(register),
          fit: BoxFit.cover,
        )),
      ),
    );
  }
}
