extension extString on String {
  // Metodo para validar username
  bool get isValidUsername {
    // Verificar el username ingresado si tiene el formato correcto
    // final nameRegExp = RegExp(r'^[A-Za-z0-9]+(?:[._-][A-Za-z0-9]+)*$');
    final nameRegExp = RegExp(
        r'^(([a-zA-Z0-9]([\.\-\_]){1})|([a-zA-Z0-9]))+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4}|[a-zA-Z]{1,3}\.[a-zA-Z]{1,3})$');
    return nameRegExp.hasMatch(this);
  }

  // Metodo para validar password
  bool get isValidPassword {
    // Verificar la contraseña ingresado si tiene el formato correcto
    final passwordRegExp = RegExp(
        r'^(?=.*[0-9])(?=.*[.,#-])(?=.*[A-Z])(?=.*[a-z])[a-zA-Z0-9.,#-]{6,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp(r'^[a-zA-ZñÑáÁéÉíÍóÓúÚ ]+$');
    return nameRegExp.hasMatch(this);
  }

  // En caso de no esta vacio retorna null
  bool get isNotNull {
    return this != null;
  }
}
