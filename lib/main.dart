import 'package:flutter/material.dart';
import 'package:parcial_dispositivos/windows/login.dart';
import 'package:parcial_dispositivos/windows/registro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
          colorScheme:
          ThemeData().colorScheme.copyWith(primary: Color(0xFF9F9F9F))),
      home: Login(),
      routes: {
        Login.id: (context) => Login(),
        Registro.id: (context) => Registro(),
      },
    );
  }
}
