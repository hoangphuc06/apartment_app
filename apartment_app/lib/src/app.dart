import 'package:apartment_app/src/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

class MyApp extends StatelessWidget {
  late final AuthBloc authBloc;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: "service_page",
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
    );
  }
}