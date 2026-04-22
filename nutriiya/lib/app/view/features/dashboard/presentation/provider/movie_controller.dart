import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:nutriiya/app/global/model/use_case_request_model.dart';
import 'package:nutriiya/app/view/features/dashboard/presentation/provider/movie_state.dart';

import '../../domain/usecase/dashboard_usecase.dart';

class MovieController extends StateNotifier<MovieState> {
  MovieController(this.getMoviesUseCase) : super(MovieState());

  final GetMoviesUseCase getMoviesUseCase;

  Future<void> loadMovies({required UseCaseRequestModel param}) async {
    debugPrint("inside try in controller 1");
    state = state.copyWith(page: 1, isLoading: true, error: null);
    try {
      debugPrint("inside try in controller 2");
      final data = await getMoviesUseCase(param);
      debugPrint("inside try in controller 3 ${data.search}");
      final all = data.search;
      state = state.copyWith(
        isLoading: false,
        page: 1,
        allMovies: all,
        movies: all.take(10).toList(),
        hasMore: all.length > 10,
      );
    } catch (e) {
      debugPrint("inside catch in controller ${e.toString()}");
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
 Future<void> loadMore() async{
    if(state.isLoadingMore || !state.hasMore) return;
    state = state.copyWith(isLoadingMore: true);
    final nextPage = state.page + 1;
    final start = (nextPage - 1) * 10;
    final end = start + 10;
    final all = state.allMovies;
    final nextItem = all.sublist(
      start,
      end > all.length ? all.length : end,
    );
    state = state.copyWith(
      movies: [...state.movies,...nextItem],
      page: nextPage,
      isLoadingMore: false,
      hasMore:  end < all.length,
    );
 }

}
