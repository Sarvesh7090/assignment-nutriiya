// import 'package:flutter/material.dart';
// import '../../data/model/movie_model.dart';
//
// class MovieCard extends StatelessWidget {
//   final Search movie;
//   final VoidCallback onTap;
//
//   const MovieCard({required this.movie, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     print("enter in MovieCard");
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       elevation: 3,
//       child: ListTile(
//         leading: Image.network(
//           movie.poster,
//           width: 50,
//           fit: BoxFit.cover,
//           errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported),
//         ),
//         title: Text(movie.title),
//         subtitle: Text(movie.year),
//         onTap: onTap,
//       ),
//     );
//   }
// }