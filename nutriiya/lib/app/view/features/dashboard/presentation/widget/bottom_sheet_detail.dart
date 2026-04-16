import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/model/movie_model.dart';

class BottomSheetDetail extends StatelessWidget {
  final Search movie;
  BottomSheetDetail({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.4,
      maxChildSize: 0.8,
      builder: (controller, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10),
            ],
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        movie.poster,
                        headers: {"User-Agent": "Mozilla/5.0"},
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
              ),
            ],
          ),
        );
      },
    );
  }
}
