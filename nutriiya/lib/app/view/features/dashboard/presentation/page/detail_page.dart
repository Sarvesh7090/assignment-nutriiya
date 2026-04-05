import 'package:flutter/material.dart';
import '../../domain/entity/movie_entity.dart';

class DetailScreen extends StatelessWidget {
  final MovieEntity movie;

  const DetailScreen({required this.movie});

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
              height: 250,
              errorBuilder: (_, __, ___) =>
                  Icon(Icons.image_not_supported, size: 100),
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