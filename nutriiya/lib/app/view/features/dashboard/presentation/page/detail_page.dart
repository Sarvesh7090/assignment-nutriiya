import 'package:flutter/material.dart';
import '../../data/model/movie_model.dart';


class DetailScreen extends StatelessWidget {
  final Search movie;

   DetailScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              movie.poster,
              headers: {
                "User-Agent": "Mozilla/5.0",
              },
              height: 250,
            ),
            SizedBox(height: 20),
            Text(
              movie.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Year: ${movie.year}"),
          ],
        ),
      ),
    );
  }
}