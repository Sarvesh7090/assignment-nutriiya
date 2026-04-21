import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:nutriiya/app/view/features/dashboard/presentation/provider/movie_state.dart';

import '../../domain/usecase/dashboard_usecase.dart';

class MovieController extends StateNotifier<MovieState> {
  MovieController(this.getMoviesUseCase) : super(MovieState());

  final GetMoviesUseCase getMoviesUseCase;

  Future<void> loadMovies() async {
    debugPrint("inside try in controller 1");
    state = state.copyWith(page: 1, isLoading: true, error: null);
    try {
      debugPrint("inside try in controller 2");
      final data = await getMoviesUseCase();
      debugPrint("inside try in controller 3 ${data.search}");
      state = state.copyWith(
        isLoading: false,
        page: 1,
        movies: data.search,
        hasMore: data.search.length >= 10,
      );
    } catch (e) {
      debugPrint("inside catch in controller ${e.toString()}");
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
