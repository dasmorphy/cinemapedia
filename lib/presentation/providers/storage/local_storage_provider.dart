import 'package:flutter_application_1/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//El futureProvider sirve para trabajar con tareas asincronas, y el family
//permite pasar un argumento al provider

//El autodispose sirve para que cuando se deje de escuchar el provider o se destruya
//el consumerWidget, el valor del provider vuelve a su estado inicial
final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
}); 