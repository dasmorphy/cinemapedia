import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  //SINO SE ESPECIFICA NOTIFIER DEVUELVE EL ESTADO POR DEFECTO, ES DECIR EL VALOR DE ESE PROVIDER


  @override
  void initState() {
    //En los metodos llmar el metodo read en los providers (flutter favorite)
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const SplitLoader();

    final nowPLayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);

    //CustomScrollView para tener control del scroll
    return CustomScrollView(
      //los slivers son ciertos widgets que tiene la funcionalidad de realizar comportamientos especiales con el scroll
      slivers: [

        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            // titlePadding: EdgeInsets.all(0),
            title: CustomAppbar()
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return Column(
                children: [              
                  MoviesSlideshow(movies: moviesSlideshow),
              
                  MovieHorizontalListview(
                    movies: nowPLayingMovies,
                    title: 'En cines',
                    subTitle: '20 DIas',
                    loadNextPage: () {
                      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                    },
                  ),
              
                  MovieHorizontalListview(
                    movies: popularMovies,
                    title: 'Populares',
                    // subTitle: '20 DIas',
                    loadNextPage: () {
                      ref.read(popularMoviesProvider.notifier).loadNextPage();
                    },
                  ),

                  MovieHorizontalListview(
                    movies: upcomingMovies,
                    title: 'Próximamente',
                    // subTitle: '20 DIas',
                    loadNextPage: () {
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                    },
                  ),

                  MovieHorizontalListview(
                    movies: topRatedMovies,
                    title: 'Mejor calificadas',
                    subTitle: 'Desde siempre',
                    loadNextPage: () {
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                    },
                  ),

                  const SizedBox(height: 10,)
                  
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: nowPLayingMovies.length,
                  //     itemBuilder: (context, index) {
                  //       final movie = nowPLayingMovies[index];
                  //       return ListTile(
                  //         title: Text(movie.title),
                  //       );
                  //     },
                  //   ),
                  // )
                ],
              );
            }
          )
        )
      ],
      
    );
  }
}