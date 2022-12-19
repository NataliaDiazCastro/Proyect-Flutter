import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  static String id = 'page_login';

  @override
  State<StatefulWidget> createState() => LoginPage();
}

class LoginPage extends State<Login>{

  final _fieldCorreo = Container(
    
  );

  final _fieldPassword = Container(

  );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Inicio de Sesión'),
      ),
    );
  }

}