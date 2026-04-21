
import '../entity/movie_entity.dart';
import '../repositories/dasboard_repository.dart';

class GetMoviesUseCase{
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  Future<MovieEntity> call() {
    print("enter in usecase ${repository.getMovies(page: 1, query: '').toString()}");
    return repository.getMovies(page: 1, query: '');
  }
}