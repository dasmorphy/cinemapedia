import 'package:flutter_application_1/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

final searchedMoviesProvider = StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider).searchMovies;
  return SearchMoviesNotifier(
    searchMoviesCallback: movieRepository,
    ref: ref
  );
});

class SearchMoviesNotifier extends StateNotifier<List<Movie>> {
  
  final SearchMoviesCallback searchMoviesCallback;
  final Ref ref;

  SearchMoviesNotifier({
    required this.searchMoviesCallback,
    required this.ref
  }): super([]); //Valor inicial

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final searchQuery = ref.read(searchQueryProvider);

    if (searchQuery == query) {
      return state;
    }

    final List<Movie> movies = await searchMoviesCallback(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  }


}