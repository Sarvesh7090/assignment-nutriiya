// import 'package:flutter/material.dart';
// import '../domain/entity/movie_entity.dart';
// import '../domain/usecase/dashboard_usecase.dart';
// import '../data/model/movie_request_model.dart';
//
// class MovieViewModel extends ChangeNotifier {
//   final GetMoviesUseCase getMoviesUseCase;
//
//   MovieViewModel(this.getMoviesUseCase);
//
//   List<MovieEntity> movies = [];
//
//   bool isLoading = false;
//   bool isLoadingMore = false;
//   bool hasMore = true;
//
//   int page = 1;
//
//   // Initial Load
//   Future<void> loadMovies() async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       print("enter in povider load Movie");
//       page = 1;
//
//       final data = await getMoviesUseCase(params: MovieRequestModel(page: page));
//       print("enter in povider load Movie $data");
//       movies = data;
//       print("movie $movies");
//       // If no data → stop pagination
//       hasMore = data.isNotEmpty;
//
//     } catch (e) {
//       print("LoadMovies Error: $e");
//     }
//
//     isLoading = false;
//     notifyListeners();
//   }
//
//   // Pagination
//   Future<void> loadMore() async {
//     // Prevent duplicate calls
//     if (isLoadingMore || !hasMore) return;
//
//     isLoadingMore = true;
//     notifyListeners();
//
//     try {
//       page++;
//
//       final data = await getMoviesUseCase(params: MovieRequestModel(page: page));
//
//       if (data.isEmpty) {
//         hasMore = false;
//       } else {
//         movies.addAll(data);
//       }
//
//     } catch (e) {
//       print("LoadMore Error: $e");
//     }
//
//     isLoadingMore = false;
//     notifyListeners();
//   }
//
//   // Pull to refresh
//   Future<void> refresh() async {
//     page = 1;
//     hasMore = true;
//     await loadMovies();
//   }
// }



import 'package:flutter/material.dart';
import '../../../../core/constants/api_constants.dart';
import '../data/model/movie_model.dart';
import '../domain/entity/movie_entity.dart';
import '../domain/usecase/dashboard_usecase.dart';
import '../data/model/movie_request_model.dart';

class MovieViewModel extends ChangeNotifier {
  final GetMoviesUseCase getMoviesUseCase;

  MovieViewModel(this.getMoviesUseCase);

  // ✅ Issue 1 — private fields with public getters
  List<Search> _movies = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _errorMsg;
  int _page = 1;

  // ✅ Public getters — read only from outside
  List<Search> get movies       => _movies;
  bool get isLoading                 => _isLoading;
  bool get isLoadingMore             => _isLoadingMore;
  bool get hasMore                   => _hasMore;
  String? get errorMsg               => _errorMsg;
  int get page                       => _page;

  static const int _pageSize = 10; // OMDB returns 10 per page

  // ─────────────────────────────────────
  // Initial Load
  // ─────────────────────────────────────
  Future<void> loadMovies() async {
    _isLoading = true;
    _errorMsg = null;
    notifyListeners();

    try {
      print("🔵 ViewModel — loadMovies called");
      _page = 1;

      final data = await getMoviesUseCase(
        page: _page,
        query: "batman",
      );

      print("🟢 ViewModel — got ${data.search.length} movies");

      _movies = List.from(data.search);

      _hasMore = data.search.length >= _pageSize;

    } catch (e) {
      _errorMsg = e.toString();
      print("🔴 ViewModel — loadMovies error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─────────────────────────────────────
  // Pagination
  // ─────────────────────────────────────
  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      _page++;
      print("🔵 ViewModel — loadMore page: $_page");

      final data = await getMoviesUseCase(
        page: _page,
        query: "batman",
      );

      if (data.search.isEmpty || data.search.length < _pageSize) {
        _hasMore = false; // ✅ no more pages
      }

      if (data.search.isNotEmpty) {
        _movies.addAll(data.search);
      }

      print("🟢 ViewModel — total movies: ${_movies.length}");

    } catch (e) {
      _page--; // ✅ rollback page on failure
      print("🔴 ViewModel — loadMore error: $e");
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  // ─────────────────────────────────────
  // Pull to Refresh
  // ─────────────────────────────────────
  Future<void> refresh() async {
    _page = 1;
    _hasMore = true;
    _movies = [];          // ✅ clear immediately
    notifyListeners();
    await loadMovies();
  }
}