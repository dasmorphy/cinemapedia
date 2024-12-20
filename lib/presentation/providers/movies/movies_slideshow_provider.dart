
import 'package:flutter_application_1/domain/entities/movie.dart';
import 'package:flutter_application_1/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPLayingMovies = ref.watch(nowPlayingMoviesProvider);
  
  if (nowPLayingMovies.isEmpty) return [];

  return nowPLayingMovies.sublist(0,6);

});