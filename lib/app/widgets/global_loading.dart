import 'package:flutter/material.dart';

import '../theme/theme.dart';

void globalLoading(BuildContext context) {
  showDialog(
      barrierColor: Colors.white54,
      barrierDismissible: false,
      context: context,
      builder: (_) => WillPopScope(
          onWillPop: () async => false,
          child: const Center(
              child: CircularProgressIndicator(
            color: primaryColor,
          ))));
}
