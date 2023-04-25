import 'package:flutter/material.dart';

//colores

//primary
const Color primaryColor = Color(0xff2B5178);
const Color primaryColorLight = Color(0xff406286);
//secondary
const Color secondaryColor = Color(0xffd84835);
const Color secondaryColorLight = Color(0xffdc5a49);
//tertiary
const Color tertiaryColor = Color(0xffE3D3B2);
const Color tertiaryColorLight = Color(0xffe6d7ba);
// diseable
const Color diseableColor = Color(0xffe0e0e0);
// colores para los botones de las alertas
const Color bodyColorStyle = Color(0xff868686);
const Color successColorStyle = Color(0xff2B778F);
const Color dangerColorStyle = Color(0xfffA4733);
const Color warningColorStyle = Color(0xfffCCA4C);

const Color disableColor = Color(0xffe0e0e0);
const Color disableColorIcon = Color(0xff8b8b8b);

// tamaño de fuente
const TextStyle fontText = TextStyle(fontSize: 16, color: Colors.white);
const TextStyle fontTextBlack = TextStyle(fontSize: 16, color: Colors.black);
const TextStyle fontTextBlue = TextStyle(fontSize: 20, color: primaryColor);
const TextStyle fontTextBlueTerms = TextStyle(
  fontSize: 16,
  color: primaryColor,
  decoration: TextDecoration.underline,
);
const TextStyle fontTextBlueTermsNoUnderline =
    TextStyle(fontSize: 16, color: primaryColor);
const TextStyle fontTextBold =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
const TextStyle formLabelStyle = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xff142638));
const TextStyle formFieldStyle = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff142638));
// tamaño de body de la alerta
const TextStyle bodyDialog = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
);
// Tamaño del titulo de la alerta
const TextStyle titleDialog = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w400,
);

// calculo de tamaño de la alerta
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;

// imagenes
const String login = 'assets/login.jpg';
const String screenHome = '';
const String register = 'assets/registro.jpg';

// Decoration para Registro
InputDecoration inputStyleRegister(String text) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
    hintStyle: fontText,
    hintText: text,
    counterStyle: const TextStyle(color: Colors.white),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: secondaryColor, width: 2),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    errorStyle: const TextStyle(color: tertiaryColor, fontSize: 14),
    errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: secondaryColor)),
    focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: secondaryColor, width: 2.0)),
  );
}

// Decoration para Registro de password
InputDecoration inputStylePasswordRegister(String text, bool _isObscure) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
    hintStyle: fontText,
    hintText: text,
    suffixIcon: IconButton(
      color: secondaryColor,
      icon: Icon(
        _isObscure ? Icons.visibility : Icons.visibility_off,
      ),
      onPressed: () {
        _isObscure = !_isObscure;
      },
    ),
    counterStyle: const TextStyle(color: Colors.white),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: secondaryColor, width: 2),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    errorStyle: const TextStyle(color: tertiaryColor, fontSize: 14),
    errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: secondaryColor)),
    focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: secondaryColor, width: 2.0)),
  );
}
