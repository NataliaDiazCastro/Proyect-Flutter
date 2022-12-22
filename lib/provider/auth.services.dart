import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Autenticacion {
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// Función encargada de la autenticacion del usuario cuando este va a iniciar sesion con el correo y la contraseña
  Future<String> iniciarSesion(String email, String password) async {
    String? errorType;
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      return user.uid;
    } on FirebaseAuthException catch(e) {
      if(Platform.isAndroid) {
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = '*No existe registro de usuario correspondiente a este identificador. Es posible que el usuario haya sido eliminado.';
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = '*Contraseña no válida';
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = '*Se ha producido un error de red comprube que esta conectado a internet';
            break;
          default:
            print('Caso ${e.message}');
        }
      }
    }
    return "$errorType";
  }

  /// Funcion encargada de crear el usuario, apartir del correo y la contraseña
  Future registrar(String email, String password) async {
    User? user;
    FirebaseApp app = await Firebase.initializeApp(name: 'Secondary', options: Firebase.app().options);
    try {
      UserCredential result = await FirebaseAuth.instanceFor(app: app).createUserWithEmailAndPassword(email: email, password: password);
      user = result.user!;
    }on FirebaseAuthException catch(e){
      print("Error ----> $e");
      return null;
    }

    await app.delete();
    return user.uid;
  }


  /// Funcion que se encarga del inicio d ssion con google
  Future loginGoogle() async {
    User? user;
    GoogleSignIn objGoogleSingIn = GoogleSignIn();
    GoogleSignInAccount? objGoogle = await objGoogleSingIn.signIn();

    if(objGoogle != null){
      GoogleSignInAuthentication objGoogleSingInAuthentication = await objGoogle.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: objGoogleSingInAuthentication.accessToken,
        idToken: objGoogleSingInAuthentication.idToken
      );
      try {
        UserCredential result = await auth.signInWithCredential(credential);
        user = result.user!;
        return user;
      } on FirebaseAuthException catch(e){
        print('Error ---> $e');
        return null;
      }
    }
  }

  ///Funcion encargada de obtener el idntificador del usuario que inicio sesion
  Future<User> getCurrentUser() async {
    User user = await auth.currentUser!;
    return user;
  }

  /// Funcion que se encarga de cerrar la sesion
  Future<void> cerrarSesion() {
    return auth.signOut();
  }
}

class DataBase {
  FirebaseFirestore db = FirebaseFirestore.instance;

  /// Funcion encargada de guaradar la informacion del usuario
  Future createDoc(Map<String, dynamic> data, String path, String idUser) async {
    try {
      final res = await db.collection(path).doc(idUser).set(data);
    } on FirebaseException catch(e){
      print("Error ---> $e");
      return "Error ---> $e";
    }
  }

  /// Funcion que obtiene la informacion de la base de datos
  Future getDoc(String path, String idUser) async {
    InfoUser? user;
    final ref = await db.collection(path).doc(idUser).get();
    user = InfoUser.FromFirestore(ref);
    return user;
  }
}

class InfoUser{
  String nombre;
  String correo;

  InfoUser({
    required this.nombre,
    required this.correo
  });

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'correo': correo,
  };

  factory InfoUser.FromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      ){
    final data = snapshot.data();
    return InfoUser(
      nombre: data?['nombre'],
      correo: data?['correo']
    );
  }
}