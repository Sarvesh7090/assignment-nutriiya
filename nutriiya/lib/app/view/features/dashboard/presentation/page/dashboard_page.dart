
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model.dart';
import 'detail_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieViewModel>().loadMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MovieViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              vm.loadMovies(forceRefresh: true);
            },
          )
        ],
      ),

      body: Builder(
        builder: (_) {
          if (vm.isLoading && vm.movies.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (vm.errorMsg != null) {
            return Center(child: Text(vm.errorMsg!));
          }

          if (vm.movies.isEmpty) {
            return const Center(child: Text("No Movies Found"));
          }

          return RefreshIndicator(
            onRefresh: () => vm.loadMovies(forceRefresh: true),
            child: ListView.builder(
              itemCount: vm.movies.length,
              itemBuilder: (context, index) {
                final movie = vm.movies[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(movie:movie ),
                        ),
                      );
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        movie.poster,
                        width: 50,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text("Year: ${movie.year}"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}