import 'package:flutter/material.dart';
import 'package:parcial_dispositivos/provider/auth.services.dart';
import 'package:parcial_dispositivos/windows/login.dart';

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
  bool validateNombre = false;
  bool validateEmail = false;
  bool validatePass = false;
  final _formKey = GlobalKey<FormState>(); // Clave que se encarga de validar que los campos del formulario esten llenos

  DataBase db = DataBase();
  Autenticacion auth = Autenticacion();

  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  /// Función que se encragada de crear el usuario
  void registrar() async {
    String uid = await auth.registrar(textEmailController.text, textPassController.text);

    if(uid != null) {
      final user = InfoUser(
        nombre: textNombreController.text,
        correo: textEmailController.text
      );

      await db.createDoc(user.toJson(), 'Usuarios', uid).whenComplete(() => {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                backgroundColor: Color(0xFFDBDBDB),
                title: Text('Registro Exitoso', style: TextStyle(color: Colors.black),),
                content: Text('Regrese al inicio para ingresar.', style: TextStyle(color: Colors.black),),
                actions: [
                  DecoratedBox(
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
                          onPressed: (){
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil(Login.id, (Route<dynamic> route) => false);
                            setState(() {
                              textEmailController.clear();
                              textNombreController.clear();
                              textPassController.clear();
                            });
                          },
                          child: Text('Ir', style: TextStyle(color: Colors.white),)
                      )
                  )
                ],
              );
            }
        )
      });
    }else {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              backgroundColor: Color(0xFFDBDBDB),
              title: Text('Registro Fallido', style: TextStyle(color: Colors.black),),
              content: Text('Vuelva a intentarlo.', style: TextStyle(color: Colors.black),),
              actions: [
                DecoratedBox(
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
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text('Ir', style: TextStyle(color: Colors.white),)
                    )
                )
              ],
            );
          }
      );
    }
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
          child: Form(
            key: _formKey,
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
          )
        ),
      ),
    );
  }

  /// Campo para ingresar el correo electronico
  Widget _fieldNombre() {
    return Center(
      child: SizedBox(
        height: 55.0,
        width: MediaQuery.of(context).size.width - 40,
        child: TextFormField(
          keyboardType: TextInputType.name,
          //obscureText: obscureText,
          controller: textNombreController,
          cursorColor: Colors.white,
          style: TextStyle(
              color: Colors.white
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0x32C4C4C4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Color(0xFFA44BFF))
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: !validateNombre ? BorderSide(color: Color(0xFFC4C4C4)) : BorderSide(color: Color(0xFFA44BFF))
            ),

            hintText: 'Pepito Peréz',
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Color(0xFF9F9F9F),
            ),
          ),
          validator: (value) {
            if(value == null || value == ''){
              return 'Ingrese su nombre';
            }else{
              validateNombre = true;
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction
          //onChanged: ,
        ),
      ),
    );
  }
///-------------------------------------------------------------------------------------
  /// Campo para ingresar el correo electronico
  Widget _fieldCorreo() {
    return Center(
      child: SizedBox(
        height: 55.0,
        width: MediaQuery.of(context).size.width - 40,
        child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            //obscureText: obscureText,
            controller: textEmailController,
            cursorColor: Colors.white,
            style: TextStyle(
                color: Colors.white
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0x32C4C4C4),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Color(0xFFA44BFF))
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: !validateEmail ? BorderSide(color: Color(0xFFC4C4C4)) : BorderSide(color: Color(0xFFA44BFF))
              ),

                hintText: 'ejemplo@gmail.com',
                hintStyle: TextStyle(
                    color: Color(0xFF9F9F9F)
                )
            ),
            validator: (value) {
              if(value == null || value == ''){
                return 'Ingrese correo valido.';
              }else {
                validateEmail = true;
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction
          //onChanged: ,
        ),
      ),
    );
  }
  ///-------------------------------------------------------------------------------------
  /// Campo de texto de la contraseña
  Widget _fieldPassword() {
    return Center(
      child: SizedBox(
        height: 55.0,
        width: MediaQuery.of(context).size.width - 40,
        child: TextFormField(
            obscureText: !_passwordVisible,
            controller: textPassController,
            cursorColor: Colors.white,
            style: TextStyle(
                color: Colors.white
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0x32C4C4C4),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Color(0xFFA44BFF))
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: !validatePass ? BorderSide(color: Color(0xFFC4C4C4)) : BorderSide(color: Color(0xFFA44BFF))
              ),
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
            validator: (value) {
              if(value == null || value == '' || value.length < 9){
                return 'Ingrese una contraseña valida.';
              }else {
                validatePass = true;
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction
          //onChanged: ,
        ),
      ),
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
          onPressed: (){
            if(_formKey.currentState!.validate()){
              registrar();
            }else {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      backgroundColor: Color(0xFFDBDBDB),
                      title: Text('Error', style: TextStyle(color: Colors.black),),
                      content: Text('Verifique que todos los campos estan llenos.', style: TextStyle(color: Colors.black),),
                      actions: [
                        DecoratedBox(
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
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Text('Ir', style: TextStyle(color: Colors.white),)
                            )
                        )
                      ],
                    );
                  }
              );
            }
          },
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