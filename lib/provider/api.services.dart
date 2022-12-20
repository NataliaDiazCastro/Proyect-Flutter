import 'dart:convert';

import 'package:http/http.dart' as http;

class ConsumoApi {


/// Funcion encargada de obtener los diferentes tipos de pokemones que hay
  Future<EstructuraApi> getType() async {
    final url = Uri.https('www.pokeapi.co', '/api/v2/type', {'q': '{http}'});
    final response = await http.get(url);

    if(response.statusCode == 200){
      return EstructuraApi.fromJson(json.decode(response.body));
    }else {
      throw Exception('Error para cargar los tipos');
    }
  }

  /// Funcion encargda de obtener los pokemones por tipo
  Future<Pokemon> getPokemonType(String type) async {
    final url = Uri.https('www.pokeapi.co', '/api/v2/type/$type', {'q': '{http}'});
    final response = await http.get(url);

    if(response.statusCode == 200){
      return Pokemon.fromJson(json.decode(response.body));
    }else {
      throw Exception('Error para cargar los tipos');
    }

    // return response;
  }

  /// Funcion encargda de obtener la imagen del pokemon
  Future<Img> getPokemonImg(String name) async {
    final url = Uri.https('www.pokeapi.co', '/api/v2/pokemon/$name', {'q': '{http}'});
    final response = await http.get(url);

    if(response.statusCode == 200){
      return Img.fromJson(json.decode(response.body));
    }else {
      throw Exception('Error para cargar los tipos');
    }

    // return response;
  }

}

class EstructuraApi {
  late int count;
  late dynamic next;
  late dynamic previous;
  late List<dynamic> results;

  EstructuraApi({
    required this.count,
    required this.next,
    required this.previous,
    required this.results
  });

  factory EstructuraApi.fromJson(
      Map<String, dynamic> json
      ){
    return EstructuraApi(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: json['results']
    );
  }

}

class Resultado {
  late String name;
  late String url;

  Resultado({
    required this.name,
    required this.url
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'url': url
  };

  factory Resultado.fromJson(
      Map<String, dynamic> json
      ) {
    return Resultado(
      name: json['name'],
      url: json['url']
    );
  }
}

class Pokemon {
  late List<dynamic> pokemon;

  Pokemon({
    required this.pokemon
  });

  factory Pokemon.fromJson(
      Map<String, dynamic> json
      ){
    return Pokemon(pokemon: json['pokemon']);
  }
}

class Pokemones {
  late dynamic pokemon;
  late int slot;

  Pokemones({
    required this.pokemon,
    required this.slot,
  });

  factory Pokemones.fromJson(
      Map<String, dynamic> json
      ){
    return Pokemones(
      pokemon: json['pokemon'],
      slot: json['slot']
    );
  }
}

class Img {
  late dynamic img;

  Img({
    required this.img
  });

  factory Img.fromJson(
      Map<String, dynamic> json
      ){
    return Img(img: json['sprites']['other']['official-artwork']['front_default']);
  }
}