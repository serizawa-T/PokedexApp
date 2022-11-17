import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PokemonSearch(),
    );
  }
}

class PokemonSearch extends StatefulWidget {
  const PokemonSearch({Key? key}) : super(key: key);

  @override
  State<PokemonSearch> createState() => _PokemonSearchState();
}

class _PokemonSearchState extends State<PokemonSearch> {
  List pokemonDataLists = []; //  ポケモン全部のデータリスト
  List pokemonImages = []; //  ポケモンのイラストリスト
  List<Pokemon> pokemon = [];

  Future<void> pokemonData() async {
    final response =
        await Dio().get('https://pokeapi.co/api/v2/pokemon?limit=100&offset=0');
    pokemonDataLists = response.data['results'];
    pokemonFetchImages();
    setState(() {});
  }

  Future<void> pokemonFetchImages() async {
    for (int i = 1; i < pokemonDataLists.length + 1; i++) {
      final response = await Dio().get(pokemonDataLists[i - 1]['url']);
      final responseName = await Dio().get(response.data['species']['url']);
      List responseType = response.data['types'];
      typeConversion(responseType);
      pokemon.add(Pokemon(
          id: i.toString(),
          name: responseName.data['names'][9]['name'],
          imageURL: response.data['sprites']['other']['official-artwork']
              ['front_default'],
          types: typeConversion(responseType)));
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    pokemonData();
  }

  List typeConversion(List responseType) {
    final types = [];
    final type = [];
    for (int i = 0; i < responseType.length; i++) {
      type.add(responseType[i]['type']['name']);
      if (type[i] == 'grass') {
        types.add('くさ');
      } else if (type[i] == 'poison') {
        types.add('どく');
      } else if (type[i] == 'fire') {
        types.add('ほのお');
      } else if (type[i] == 'fighting') {
        types.add('かくとう');
      } else if (type[i] == 'flying') {
        types.add('ひこう');
      } else if (type[i] == 'ground') {
        types.add('じめん');
      } else if (type[i] == 'normal') {
        types.add('ノーマル');
      } else if (type[i] == 'rock') {
        types.add('いわ');
      } else if (type[i] == 'bug') {
        types.add('むし');
      } else if (type[i] == 'ghost') {
        types.add('ゴースト');
      } else if (type[i] == 'steel') {
        types.add('はがね');
      } else if (type[i] == 'water') {
        types.add('みず');
      } else if (type[i] == 'electric') {
        types.add('でんき');
      } else if (type[i] == 'psychic') {
        types.add('エスパー');
      } else if (type[i] == 'ice') {
        types.add('こおり');
      } else if (type[i] == 'dragon') {
        types.add('ドラゴン');
      } else if (type[i] == 'dark') {
        types.add('あく');
      } else if (type[i] == 'fairy') {
        types.add('フェアリー');
      } else if (type[i] == 'unknown') {
        types.add('不明');
      } else if (type[i] == 'shadow') {
        types.add('shadow');
      }
    }
    return types;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: pokemon.length,
        itemBuilder: (context, index) {
          return InkWell(
            // child: Image.network(pokemon[index].imageURL),
            onTap: () {
              print(pokemon[index].name);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PokemonDetail(
                            id: pokemon[index].id,
                            name: pokemon[index].name,
                            imageURL: pokemon[index].imageURL,
                            types: pokemon[index].types.toString(),
                          )));
              setState(() {});
            },
            child: Image.network(pokemon[index].imageURL),
          );
        },
      ),
    );
  }
}

class Pokemon {
  final String id;
  final String name; //キャラクター名
  final String imageURL; //一覧表示用
  final List types;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.types,
  });
}
