import 'package:flutter_application_1/domain/entities/movie.dart';

abstract class LocalStorageRepository {
  Future<bool> toggleFavorite(Movie movie);
  Future<bool> isMovieFavorite(int movieId);
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}