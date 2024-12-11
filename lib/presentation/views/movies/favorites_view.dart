import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entities/movie.dart';
import 'package:flutter_application_1/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/presentation/providers/providers.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    
    if (movies.isEmpty) {
      isLastPage = true;
    }

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Convierte un objeto en una lista
    final List<Movie> favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();


    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary),
            Text('Sin favoritos', style: TextStyle(fontSize: 30, color: colors.primary)),
            const Text('Agrega tu primera película favorita', style: TextStyle(fontSize: 20, color: Colors.black45),),
            
            const SizedBox(height: 20,),
            FilledButton(
              onPressed: () => context.go('/home/0'), 
              child: const Text('Empieza a buscar')
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        movies: favoriteMovies, 
        loadNextPage: loadNextPage,
      )
    );
  }
}