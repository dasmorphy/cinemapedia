import 'package:flutter_application_1/domain/datasources/local_storage_datasource.dart';
import 'package:flutter_application_1/domain/entities/movie.dart';
import 'package:flutter_application_1/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository{
  final LocalStorageDatasource datasource;
  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<bool> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }

}