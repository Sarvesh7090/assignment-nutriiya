import '../../data/model/movie_model.dart';
import '../entity/movie_entity.dart';
import '../entity/movie_item_entity.dart';

abstract class MovieRepository {
  Future<MovieEntity> getMovies({
    required int page,
    required String query,
  });

  Future<MovieItemEntity> getMovieDetail(String imdbID);
}