import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parcial_dispositivos/provider/api.services.dart';
import 'package:parcial_dispositivos/provider/auth.services.dart';

class Principal extends StatefulWidget{
  static String id = 'page_principal';

  @override
  State<StatefulWidget> createState() => PrincipalPage();
}

class PrincipalPage extends State<Principal> {

  Autenticacion auth = Autenticacion();
  ConsumoApi api = ConsumoApi();

  List<Resultado> results = [];
  List<String> tipos = [];

  List<Pokemones> pokemones = [];
  List<Resultado> pokeResultado = [];

  String? _selectedType;

  bool mostrar = false;
  bool carga = false;


  ///Funcion qie se encarga de traer los datos de la api
  void getTypes() async {
    EstructuraApi res = await api.getType();
    for (final res in res.results){
      setState(() {
        results.add(Resultado.fromJson(res));
      });
    }

    for(final res in results){
      tipos.add(res.name);
      //print(res.name);
    }
  }

  /// funcion que obtiene los pokemones segun su tipo
  void getPkemonType(String type) async {
    setState((){
      mostrar = false;
      carga = true;
    });
    pokemones = [];
    pokeResultado = [];
    final res = await api.getPokemonType(type);
    print(res.pokemon.length);
    for(int i = 0; i < 20; i++){
      pokemones.add(Pokemones.fromJson(res.pokemon[i]));
    }
    print(pokemones.length);
    for(final res in pokemones){
      pokeResultado.add(Resultado.fromJson(res.pokemon));
    }
    print(pokeResultado.length);
    var cont = 0;
    for(final img in pokeResultado){
      final image = await api.getPokemonImg(img.name);
      setState(() {
        img.url = image.img;
      });
      cont++;
      print(cont);
    }

    if(cont == pokeResultado.length){
      setState(() {
        mostrar = true;
        carga = false;
      });
    }

  }

  void initState() {
    super.initState();
    getTypes();
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text('Pokémon Explora'),
          titleSpacing: 0.0,
          centerTitle: true,
          actions: [
           IconButton(
              onPressed: (){
                auth.cerrarSesion().whenComplete(() => {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(Login.id, (Route<dynamic> route) => false)
                });
              },
              icon: Icon(Icons.door_back_door_outlined, size: 30.0)
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                color: Color(0xFFA44BFF),
                width: double.infinity,
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Tipo de Pokémon',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0
                      ),
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Color(0x4FC4C4C4),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: Color(0xFFA44BFF))
                        ),
                        width: 130.0,
                        height: 45.0,
                        child: DropdownButton(
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          value: _selectedType,
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value as String;
                            });
                            getPkemonType(_selectedType!);
                          },
                          hint: const Center(
                              child: Text(
                                '*Seleccione Uno',
                                style: TextStyle(
                                    color: Colors.white),
                              )),
                          // Hide the default underline
                          //underline: Container(),
                          // set the color of the dropdown menu
                          dropdownColor: Color(0xFFDBDBDB),
                          alignment: Alignment.center,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 35.0,
                          ),

                          isExpanded: true,

                          // The list of options
                          items: tipos
                              .map<DropdownMenuItem<String>>((e) {
                            return DropdownMenuItem<String>(
                                value: e,
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0
                                  ),
                                )
                            );
                          }).toList(),


                          // Customize the selected item
                          selectedItemBuilder: (
                              BuildContext context) =>
                              tipos
                                  .map((e) =>
                                  Center(
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontStyle: FontStyle
                                              .italic,
                                          fontWeight: FontWeight
                                              .bold),
                                    ),
                                  )).toList(),
                        )
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              if(mostrar)
                Expanded(
                  //
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        physics: ScrollPhysics(),
                        children: [
                          for(final res in pokeResultado)
                            Card(
                              color: Color(0xFFDBDBDB),
                              elevation: 10,
                              child: Center(
                                child: Column(
                                  children: [
                                    res.url != null ? Image(image: NetworkImage(res.url), width: 100, height: 100, fit: BoxFit.cover,) : Image(image: AssetImage('assets/pokebol.png'),width: 100, height: 100, fit: BoxFit.cover),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      res.name,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                        ],

                      ),
                    ),
                  ),
                ),
              carga ? const CircularProgressIndicator(
                backgroundColor: Colors.white,
              ) : Center()
            ]
          ),
        ),
      )
    );
  }

}