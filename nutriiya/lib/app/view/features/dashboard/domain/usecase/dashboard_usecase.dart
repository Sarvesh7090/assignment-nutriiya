import 'package:dartz/dartz.dart';
import 'package:nutriiya/app/view/features/dashboard/data/model/movie_request_model.dart';

import '../../../../../core/failure/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entity/movie_entity.dart';
import '../repositories/dasboard_repository.dart';

class GetMoviesUseCase{
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  Future<MovieEntity> call({
    required int page,
    required String query,
  }) {
    return repository.getMovies(page: page, query: query);
  }
}