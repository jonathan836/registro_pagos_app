// import 'package:catcher/catcher.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/data/login_impl.dart';
import 'app/data/providers/login_api.dart';
import 'app/ui/pages/login/logout_controller.dart';
import 'app/ui/routes/pages.dart';
import 'app/ui/routes/routes.dart';
import 'app_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LogoutController(
            LoginImpl(LoginApi(Dio())),
          ),
        ),
      ],
      child: MaterialApp(
        // navigatorKey: Catcher.navigatorKey,
        // localizationsDelegates: context.localizationDelegates,
        // locale: context.locale,
        // supportedLocales: context.supportedLocales,
        title: AppConfig.instance.nameApp,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.blue,
        ),
        initialRoute: Routes.LOGIN,
        routes: appRoutes(),
      ),
    );
  }
}
