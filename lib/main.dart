import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parcial_dispositivos/windows/login.dart';
import 'package:parcial_dispositivos/windows/principal.dart';
import 'package:parcial_dispositivos/windows/registro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
          colorScheme:
          ThemeData().colorScheme.copyWith(primary: Color(0xFF9F9F9F))),
      home: Login(),
      routes: {
        Login.id: (context) => Login(),
        Registro.id: (context) => Registro(),
        Principal.id: (context) => Principal(),
      },
    );
  }
}
