import 'package:flutter_application_1/domain/entities/actor.dart';
import 'package:flutter_application_1/presentation/providers/actors/actors_by_movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorInfoProvider = StateNotifierProvider<ActorsByMovieProvider, Map<String, List<Actor>>>((ref) {
  final actorRepository = ref.watch(actorRepositoryProvider);
  return ActorsByMovieProvider(getActorsCallback: actorRepository.getActorByMovie);
});

typedef GetActorsCallback = Future<List<Actor>>Function(String movieId);

class ActorsByMovieProvider extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActorsCallback;

  ActorsByMovieProvider({
    required this.getActorsCallback
  }): super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actors = await getActorsCallback(movieId);
    state = {...state, movieId: actors};
  }

}