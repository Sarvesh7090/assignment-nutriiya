import '../entity/movie_entity.dart';

abstract class MovieRepository {
  Future<MovieEntity> getMovies({
    required int page,
    required String query,
    bool forceRefresh = false,
  });

}