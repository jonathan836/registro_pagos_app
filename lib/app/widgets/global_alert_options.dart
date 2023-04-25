import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertOptions(BuildContext context,
    {required String msg,
    required String title,
    void Function()? acceptOnPressed,
    void Function()? cancelOnPressed,
    void Function()? closeOnPressed,
    String? acceptTitle,
    String? cancelTitle,
    String? closeTitle,
    Widget? msgWidget}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: CupertinoAlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            content: msgWidget ?? Text(msg),
            actions: (acceptOnPressed != null || cancelOnPressed != null)
                ? [
                    (cancelOnPressed != null)
                        ? CupertinoDialogAction(
                            onPressed: cancelOnPressed,
                            child: Text(
                              (cancelTitle != null) ? cancelTitle : 'Cancelar',
                              style: const TextStyle(color: Colors.black),
                            ),
                          )
                        : const SizedBox.shrink(),
                    (acceptOnPressed != null)
                        ? CupertinoDialogAction(
                            onPressed: acceptOnPressed,
                            child: Text(
                              (acceptTitle != null) ? acceptTitle : 'Aceptar',
                              style: const TextStyle(color: Colors.black),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ]
                : [
                    CupertinoDialogAction(
                      onPressed: (closeOnPressed != null)
                          ? closeOnPressed
                          : () => Navigator.of(context).pop(),
                      child: Text(
                        (closeTitle != null) ? closeTitle : 'Cerrar',
                        style: const TextStyle(color: Colors.black),
                      ),
                    )
                  ]),
      );
    },
  );
}
