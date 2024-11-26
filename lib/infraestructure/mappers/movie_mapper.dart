import 'package:flutter_application_1/domain/entities/movie.dart';
import 'package:flutter_application_1/infraestructure/dto/moviedb/movie_details.dart';
import 'package:flutter_application_1/infraestructure/dto/moviedb/movie_moviedb.dart';

class MovieMapper {
  //se pone static para utilizar directamente movieDBToEntity y no tener que instanciar la clase
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
    adult: moviedb.adult, 
    backdropPath: (moviedb.backdropPath != '') 
      ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
      : 'https://st4.depositphotos.com/14953852/24787/v/380/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg', 
    genreIds: moviedb.genreIds.map((e) => e.toString()).toList(), 
    id: moviedb.id, 
    originalLanguage: moviedb.originalLanguage, 
    originalTitle: moviedb.originalTitle, 
    overview: moviedb.overview, 
    popularity: moviedb.popularity, 
    posterPath: (moviedb.posterPath != '')
      ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
      : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-r6KetrzrVN6soWnhhRBaCD0fqYIEl-ig_Q&s', 
    releaseDate: moviedb.releaseDate, 
    title: moviedb.title, 
    video: moviedb.video, 
    voteAverage: moviedb.voteAverage, 
    voteCount: moviedb.voteCount
  );

  static Movie movieDetailsToEntity (MovieDetails movieDetails)  => Movie(
    adult: movieDetails.adult, 
    backdropPath: (movieDetails.backdropPath != '') 
      ? 'https://image.tmdb.org/t/p/w500${movieDetails.backdropPath}'
      : 'https://st4.depositphotos.com/14953852/24787/v/380/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg', 
    genreIds: movieDetails.genres.map((e) => e.name).toList(), 
    id: movieDetails.id, 
    originalLanguage: movieDetails.originalLanguage, 
    originalTitle: movieDetails.originalTitle, 
    overview: movieDetails.overview, 
    popularity: movieDetails.popularity, 
    posterPath: (movieDetails.posterPath != '')
      ? 'https://image.tmdb.org/t/p/w500${movieDetails.posterPath}'
      : 'https://st4.depositphotos.com/14953852/24787/v/380/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg', 
    releaseDate: movieDetails.releaseDate, 
    title: movieDetails.title, 
    video: movieDetails.video, 
    voteAverage: movieDetails.voteAverage, 
    voteCount: movieDetails.voteCount
  );



}