class Pokemon {
  final String name;
  final String url;

  Pokemon({required this.name, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
    );
  }

  // Lógica para extraer el ID de la URL (Actividad 3)
  String get imageUrl {
    // La URL es tipo: https://pokeapi.co/api/v2/pokemon/1/
    final segments = url.split('/');
    final id = segments[segments.length - 2];
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }
}