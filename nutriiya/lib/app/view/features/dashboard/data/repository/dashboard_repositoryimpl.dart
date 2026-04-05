import 'package:nutriiya/app/view/features/dashboard/domain/entity/movie_item_entity.dart';

import '../../domain/entity/movie_entity.dart';
import '../../domain/repositories/dasboard_repository.dart';
import '../datasources/dasboard_data_source.dart';
import '../datasources/dashboard_local_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remote;
  MovieRepositoryImpl(this.remote);

  @override
  Future<MovieEntity> getMovies({
    required int page,
    required String query,
  }) async {
    try {
      final model = await remote.getMovies(page: page, query: query);
      return model.toEntity();
    } catch (e) {
      return MovieEntity(
        search: [],
        totalResults: "0",
        response: "False",
      );
    }
  }

  @override
  Future<MovieItemEntity> getMovieDetail(String imdbID) {
    // TODO: implement getMovieDetail
    throw UnimplementedError();
  }
}