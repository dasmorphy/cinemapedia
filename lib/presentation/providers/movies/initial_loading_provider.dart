import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final stepNowPLayingMovies = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final stepPopularMovies = ref.watch(popularMoviesProvider).isEmpty;
  final stepUpcomingMovies = ref.watch(upcomingMoviesProvider).isEmpty;
  final stepTopRatedMovies = ref.watch(topRatedMoviesProvider).isEmpty;

  if (stepNowPLayingMovies || stepPopularMovies || stepUpcomingMovies || stepTopRatedMovies) return true;

  return false;
});