import 'package:nutriiya/app/global/model/use_case_request_model.dart';

import '../entity/movie_entity.dart';

abstract class MovieRepository {
  Future<MovieEntity> getMovies({
    required UseCaseRequestModel param,
    bool forceRefresh = false,
  });

}