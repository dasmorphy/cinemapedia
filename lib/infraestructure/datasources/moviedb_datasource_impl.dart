import 'package:dio/dio.dart';
import 'package:flutter_application_1/config/constants/environments.dart';
import 'package:flutter_application_1/domain/datasources/movies_datasource.dart';
import 'package:flutter_application_1/domain/entities/movie.dart';
import 'package:flutter_application_1/infraestructure/dto/moviedb/movie_details.dart';
import 'package:flutter_application_1/infraestructure/dto/moviedb/moviedb_response.dart';
import 'package:flutter_application_1/infraestructure/mappers/movie_mapper.dart';

class MoviedbDatasourceImpl extends MoviesDatasource{
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environments.movieDbKey,
        'language': 'es-MX'
      }
    )
  );

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final moviesResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = moviesResponse.results
    .where((moviedb) => moviedb.posterPath != 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-r6KetrzrVN6soWnhhRBaCD0fqYIEl-ig_Q&s')
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    
    final response = await dio.get('/movie/now_playing',
      queryParameters: {
        'page': page
      }
    );
    
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular',
      queryParameters: {
        'page': page
      }
    );
        
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated',
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming',
      queryParameters: {
        'page': page
      }
    );
    
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<Movie> getMovieById(String movieId) async {
    final response = await dio.get('/movie/$movieId');

    if (response.statusCode != 200) throw Exception('Movie with id: $movieId not found');

    final movieDetails = MovieDetails.fromJson(response.data);

    return MovieMapper.movieDetailsToEntity(movieDetails); 
  }
  
  @override
  Future<List<Movie>> searchMovies(String query) async {
    final response = await dio.get('/search/movie',
      queryParameters: {
        'query': query
      }
    );

    return _jsonToMovies(response.data);
  }
  
}