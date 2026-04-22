import 'package:nutriiya/app/view/features/dashboard/data/model/movie_model.dart';

import '../../domain/entity/movie_entity.dart';

class MovieState {
  final List<Search> movies;
  final List<Search> allMovies;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final int page;

  MovieState({
    this.movies = const [],
    this.allMovies = const [],
    this.page = 0,
    this.isLoading = false,
    this.error,
    this.hasMore = true,
    this.isLoadingMore = false
});
  MovieState copyWith({
    List<Search>? movies,
    List<Search>? allMovies,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    int? page,
}){
    return MovieState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      movies: movies ?? this.movies,
      page: page ?? this.page,
      allMovies: allMovies ?? this.allMovies
    );
  }
}