import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

class MoviesSlideshow extends StatelessWidget {

  final List<Movie> movies;
  
  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity, //toma todo el ancho disponible
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary
          )
        ),
        autoplay: true,
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;
  // se borra el super.key porque es un widget privado
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10)
        )
      ]
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover, //Toma todo el espacio disponible la imagen

            //loadingBuilder ayuda a saber cuando se contruyo la imagen
            loadingBuilder: (context, child, loadingProgress) {
              //significa que se esta cargando la imagen
              if (loadingProgress != null) {
                return const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black12)
                );
              }

              return GestureDetector(
                onTap: () => context.push('/home/0/movie/${movie.id}'),
                child: FadeIn(child: child)//cuando se termine de cargar la imagen se retorna el child (imagen)
              );
            },
          ),
        ),
      ),
    );
  }
}