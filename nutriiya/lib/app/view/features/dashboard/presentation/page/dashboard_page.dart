import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // Safe API call after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieViewModel>(context, listen: false).loadMovies();
    });

    // Scroll listener
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (_controller.position.pixels >=
        _controller.position.maxScrollExtent - 200) {

      final vm = Provider.of<MovieViewModel>(context, listen: false);

      // Prevent multiple calls
      if (!vm.isLoadingMore && vm.hasMore) {
        vm.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movie Feed")),

      // Consumer listens to notifyListeners
      body: Consumer<MovieViewModel>(
        builder: (context, vm, child) {

      if (vm.isLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (vm.movies.isEmpty) {
        return Center(child: Text("No Movies Found"));
      }else{
        return ListView.builder(
          controller: _controller,
          itemCount: vm.movies.length,
          itemBuilder: (context, index) {
            final movie = vm.movies[index];
            print("movie.title ${movie.title}");
            return ListTile(
              leading: Image.network(
                movie.poster,
                width: 50,
                errorBuilder: (_, __, ___) =>
                    Icon(Icons.image_not_supported),
              ),
              title: Text(movie.title),
              subtitle: Text(movie.year),
            );
          },
        );
      }
    },
    )
    );
  }
}