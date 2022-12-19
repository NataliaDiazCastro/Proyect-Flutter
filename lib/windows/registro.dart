import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  static String id = 'page_registro';

  @override
  State<StatefulWidget> createState() => RegistroPage();
}

class RegistroPage extends State<Registro>{
  final textNombreController = TextEditingController();
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
        color: Color(0xFF1B1B1B)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30.0,
                ),
              );
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Registro',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Ingresa los siguientes datos.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Nombre',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              _fieldNombre(),
              const SizedBox(
                height: 20.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Correo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              _fieldCorreo(),
              const SizedBox(
                height: 20.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Contraseña',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              _fieldPassword(),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: _botonCrear(),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: RichText(
                      text: const TextSpan(
                          text: '¿Ya tienes cuenta? ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Inicia sesión', style: TextStyle(fontWeight: FontWeight.w700))
                          ]
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Campo para ingresar el correo electronico
  Widget _fieldNombre() {
    return Container(
        decoration: BoxDecoration(
            color: Color(0x32C4C4C4),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFFA44BFF))
        ),
        height: 55.0,
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          keyboardType: TextInputType.name,
          //obscureText: obscureText,
          controller: textNombreController,
            cursorColor: Colors.white,
            style: TextStyle(
                color: Colors.white
            ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Pepito Peréz',
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Color(0xFF9F9F9F),
            ),
          ),
          //   validator: (value) {
          //     if(value == null || value == ''){
          //       return 'Ingrese su nombre';
          //     }
          //     return null;
          //   },
          // autovalidateMode: AutovalidateMode.onUserInteraction
          //onChanged: ,
        )
    );
  }
///-------------------------------------------------------------------------------------
  /// Campo para ingresar el correo electronico
  Widget _fieldCorreo() {
    return Container(
        decoration: BoxDecoration(
            color: Color(0x32C4C4C4),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFFA44BFF))
        ),
        height: 55.0,
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          //obscureText: obscureText,
          controller: textEmailController,
          cursorColor: Colors.white,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'ejemplo@gmail.com',
              hintStyle: TextStyle(
                  color: Color(0xFF9F9F9F)
              )
          ),
          //   validator: (value) {
          //     if(value == null || value == ''){
          //       return 'Ingrese correo valido.';
          //     }
          //     return null;
          //   },
          // //onChanged: ,
          // autovalidateMode: AutovalidateMode.always
        )
    );
  }
  ///-------------------------------------------------------------------------------------
  /// Campo de texto de la contraseña
  Widget _fieldPassword() {
    return Container(
        height: 55.0,
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Color(0x32C4C4C4),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFFA44BFF))
        ),
        child: TextFormField(
          obscureText: !_passwordVisible,
          controller: textPassController,
          cursorColor: Colors.white,
          style: TextStyle(
              color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '***********',
            hintStyle: TextStyle(
              color: Color(0xFF9F9F9F)
            ),
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
          // validator: (value) {
          //   if(value == null || value == '' || value.length < 9){
          //     return 'Ingrese una contraseña valida.';
          //   }
          //   return null;
          // },
          // autovalidateMode: AutovalidateMode.always
        )
    );
  }
  ///-------------------------------------------------------------------------------------
  /// Boton para crear cuenta
  Widget _botonCrear(){
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
              'Crear Cuenta',
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