
import 'package:flutter_application_1/domain/entities/movie.dart';
import 'package:flutter_application_1/domain/repositories/local_storage_repository.dart';
import 'package:flutter_application_1/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider); //watch en este caso es recomendado
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  
  int page = 0;
  final LocalStorageRepository localStorageRepository;
  
  StorageMoviesNotifier({
    required this.localStorageRepository
  }): super({});


  Future<List<Movie>> loadNextPage() async{
    final movies = await localStorageRepository.loadMovies(offset: page * 10, limit: 20);
    page++;

    final tempMovie = <int, Movie>{};

    for (final movie in movies) {
      tempMovie[movie.id] = movie;
    }

    //Se emite el nuevo valor usando el state
    state = {...state, ...tempMovie};

    return movies;

  }

  Future<void> toggleFavorite(Movie movie) async {
    final bool isMovieInFavorites = await localStorageRepository.toggleFavorite(movie);

    if (isMovieInFavorites) {
      state = {...state, movie.id: movie};
    }else{
      state.remove(movie.id);
      state = {...state};
    }
  }


}