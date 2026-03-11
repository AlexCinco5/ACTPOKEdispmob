import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/pokemon_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Pokemon>> pokemonList;

  @override
  void initState() {
    super.initState();
    // Iniciamos la petición a la API al cargar la pantalla
    pokemonList = apiService.fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex Universitaria'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      // Actividad 2: Uso de FutureBuilder para manejar los estados
      body: FutureBuilder<List<Pokemon>>(
        future: pokemonList,
        builder: (context, snapshot) {
          // Estado 1: Cargando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          // Estado 2: Error
          else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Ocurrió un error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } 
          // Estado 3: Éxito
          else if (snapshot.hasData) {
            final pokemons = snapshot.data!;
            
            // Actividad 1: Mostrar los 20 Pokémon en un ListView
            return ListView.builder(
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = pokemons[index];
                
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 2,
                  child: ListTile(
                    // Actividad 3: Mostrar la imagen usando la URL calculada en el modelo
                    leading: Image.network(
                      pokemon.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      // Un pequeño extra: por si la imagen tarda o falla
                      errorBuilder: (context, error, stackTrace) => 
                        const Icon(Icons.image_not_supported),
                    ),
                    title: Text(
                      pokemon.name.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            );
          }
          
          // Por si acaso no cae en ninguno de los anteriores
          return const Center(child: Text('No hay datos disponibles.'));
        },
      ),
    );
  }
}