import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/movie_provider.dart';
import '../widget/bottom_sheet_detail.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends ConsumerState<DashboardScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(movieProvider.notifier).loadMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(movieProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(movieProvider.notifier).loadMovies();
            },
          )
        ],
      ),

      body: Builder(
        builder: (_) {
          if (state.isLoading && state.movies.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.error != null) {
            print("error state 51 ${state.error}");
            return Center(child: Text(state.error!));
          }

          if (state.movies.isEmpty) {
            return const Center(child: Text("No Movies Found"));
          }
          print("enter in dashboard page");
          return RefreshIndicator(
            onRefresh: () => ref.read(movieProvider.notifier).loadMovies(),
            child: ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];

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
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        isDismissible: true,
                        enableDrag: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return BottomSheetDetail(movie: movie);
                        },
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => DetailScreen(movie:movie ),
                      //   ),
                      // );
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