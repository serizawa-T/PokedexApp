import 'package:flutter/material.dart';

class PokemonDetail extends StatelessWidget {
  const PokemonDetail(
      {Key? key,
      required this.id,
      required this.name,
      required this.imageURL,
      required this.types})
      : super(key: key);

  final String id;
  final String name; //キャラクター名
  final String imageURL; //一覧表示用
  final String types;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imageURL,
              scale: 2,
            ),
            Card(
              child: SizedBox(
                width: 350,
                // height: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'No.00$id',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 38, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'タイプ: $types',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
