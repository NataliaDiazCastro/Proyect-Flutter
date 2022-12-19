import 'package:flutter/material.dart';
import 'package:parcial_dispositivos/windows/registro.dart';

class Login extends StatefulWidget{
  static String id = 'page_login';

  @override
  State<StatefulWidget> createState() => LoginPage();
}

class LoginPage extends State<Login>{
  final textEmailController = TextEditingController();
  final textPassController = TextEditingController();
  bool _passwordVisible = false;


  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //     colors: [
          //       Color(0xFF4268B3),
          //       Color(0xFF584CD1)
          //     ],
          //     begin: FractionalOffset(0.2, 0.0),
          //     end: FractionalOffset(1.0, 0.6),
          //     stops: [0.0, 0.6],
          //     tileMode: TileMode.clamp
          // )
        color: Color(0xFF1B1B1B)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child:  Column(
              children: [
                Container(
                    height: 250.0,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image(
                        image: AssetImage('assets/work.jpg'),
                        fit: BoxFit.cover,
                      ),
                    )
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Text(
                  'Inicio de Sesión',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                _fieldCorreo(),
                const SizedBox(
                  height: 20.0,
                ),
                _fieldPassword(),
                const SizedBox(
                  height: 30.0,
                ),
                _botonIniciarSesion(),
                const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Registro.id);
                  },
                  child: RichText(
                      text: const TextSpan(
                          text: '¿No tienes cuenta? ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Regístrate', style: TextStyle(fontWeight: FontWeight.w700))
                          ]
                      )
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }

  /// Campo para ingresar el correo electronico
  Widget _fieldCorreo() {
    return Container(
        decoration: BoxDecoration(
          color: Color(0x32C4C4C4),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFFA44BFF))
        ),
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          //obscureText: obscureText,
          controller: textEmailController,
          cursorColor: Color(0xFF9F9F9F),
          decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.email_outlined,
              size: 30.0,
              color: Color(0xFF9F9F9F),
            ),
            labelText: 'Correo',
            labelStyle: TextStyle(
                fontSize: 15.0,
                color: Color(0xFF9F9F9F),
                fontWeight: FontWeight.w500),
            hintText: 'ejemplo@gmail.com',
            hintStyle: TextStyle(
              color: Color(0xFF9F9F9F)
            )
          ),
          //onChanged: ,
        )
    );
  }
  ///-------------------------------------------------------------------------------------
  /// Campo de texto de la contraseña
  Widget _fieldPassword() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
            color: Color(0x32C4C4C4),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFFA44BFF))
        ),
        child: TextField(
          obscureText: !_passwordVisible,
          controller: textPassController,
          cursorColor: Color(0xFF9F9F9F),
          decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                size: 30.0,
                color: Color(0xFF9F9F9F),
              ),
              border: InputBorder.none,
              labelText: 'Contraseña',
              labelStyle: const TextStyle(
                  fontSize: 15.0,
                  color: Color(0xFF9F9F9F),
                  fontWeight: FontWeight.w500),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    size: 30.0,
                  )
              ),

          ),
          //onChanged: ,
        )
    );
  }
///-------------------------------------------------------------------------------------
/// Boton para iniciar sesion
  Widget _botonIniciarSesion(){
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [
                Color(0xFFA44BFF),
                Color(0xFFDA48FF)
              ],
              begin: FractionalOffset(0.2, 0.0),
              end: FractionalOffset(1.0, 0.6),
              stops: [0.0, 0.6],
              tileMode: TileMode.clamp
          ),
        borderRadius: BorderRadius.circular(12.0)
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            onSurface: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: (){},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0
              ),
            ),
          )
      ),
    );
  }



}