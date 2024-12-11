import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entities/movie.dart';
import 'package:flutter_application_1/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const name = 'movie-screen';
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorInfoProvider.notifier).loadActors(widget.movieId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDetails(movie: movie),
            childCount: 1
          ))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              //Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),

              const SizedBox(width: 10),
              
              //Descripcion
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyle.titleLarge),
                    Text(movie.overview)
                  ],
                ),
              )
            ],
          ),
        ),

        //Generos de la pelicula
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              ...movie.genreIds.map((gender) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(gender),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ))
            ],
          ),
        ),

        _ActorsByMovie(movieId: movie.id.toString()),

        const SizedBox(height: 0)
      ],
    );
  }
}


class _ActorsByMovie extends ConsumerWidget {

  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {

    final actorsByMovie = ref.watch(actorInfoProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              children: [
                //Actor photo
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //Nombre 
                const SizedBox(height: 5),

                Text(actor.name, 
                  maxLines: 2,
                  textAlign: TextAlign.center
                ),
                Text(actor.character ?? '', 
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                )

              ],
            ),
          );
        },
      ),
    );
  }
}


class _CustomSliverAppBar extends ConsumerWidget {
  
  final Movie movie;
  
  const _CustomSliverAppBar({
    required this.movie
  });

  @override
  Widget build(BuildContext context, ref) {

    final size = MediaQuery.of(context).size;
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7, //Se obtiene el 70% del alto del dispositivo
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            // await ref.read(localStorageRepositoryProvider).toggleFavorite(movie);
            await ref.read(favoriteMoviesProvider.notifier).toggleFavorite(movie);
            //Invalida el provider regresandolo a su estado original
            //Vuelve a consultar a la base para confirmar el estado inicial
            ref.invalidate(isFavoriteProvider(movie.id)); 
          }, 
          icon: isFavoriteFuture.when(
            loading: () => const CircularProgressIndicator(strokeWidth: 2),
            data: (isFavorite) => isFavorite 
              ? const Icon(Icons.favorite_rounded, color: Colors.red,)
              : const Icon(Icons.favorite_border),
            error: (_, __) => throw UnimplementedError(), //StackTrace son los pasos que se dieron para producir el error
          )
          
          
          // const Icon(Icons.favorite_border)
          // icon: const Icon(Icons.favorite_rounded, color: Colors.red,)
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),        
        title: Text(
          textAlign: TextAlign.start,
          movie.title,
          style: const TextStyle(color: Colors.white,fontSize: 20),
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },

              ),
            ),

            const _CustomGradient(
              colors: [
                Colors.black54,
                Colors.transparent
              ],
              stops: [0.0, 0.2],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),

            const _CustomGradient(
              colors: [
                Colors.transparent,
                Colors.black87
              ],
              stops: [0.7, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),

            const _CustomGradient(
              colors: [
                Colors.black87,
                Colors.transparent
              ],
              stops: [0.0, 0.3],
              begin: Alignment.topLeft,
            ),
          ],
        ),
      ),
    );
  }
}


class _CustomGradient extends StatelessWidget {
  
  final List<double> stops;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<Color> colors;
  
  const _CustomGradient({
    required this.stops, 
    this.begin = Alignment.centerLeft, 
    this.end = Alignment.centerRight, 
    required this.colors
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors
          )
        ),
      )
    );
  }
}