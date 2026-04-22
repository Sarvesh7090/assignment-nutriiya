
import 'package:nutriiya/app/global/model/use_case_request_model.dart';

import '../entity/movie_entity.dart';
import '../repositories/dasboard_repository.dart';

class GetMoviesUseCase{
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  Future<MovieEntity> call(UseCaseRequestModel param) {
    print("enter in usecase ${repository.getMovies(param: param).toString()}");
    return repository.getMovies(param: param);
  }
}