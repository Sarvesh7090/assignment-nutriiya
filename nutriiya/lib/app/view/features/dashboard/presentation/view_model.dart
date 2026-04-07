import 'package:flutter/material.dart';
import '../data/model/movie_model.dart';
import '../domain/entity/movie_entity.dart';
import '../domain/usecase/dashboard_usecase.dart';


class MovieViewModel extends ChangeNotifier {
  final GetMoviesUseCase useCase;

  List<Search> movies = [];
  bool isLoading = false;
  String? errorMsg;

  MovieViewModel(this.useCase);

  Future<void> loadMovies({bool forceRefresh = false}) async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await useCase.call();

      movies = List.from(data.search);

      print(" ViewModel — Loaded ${movies.length} movies");

    } catch (e) {
      errorMsg = e.toString();
      print("ViewModel — loadMovies error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}