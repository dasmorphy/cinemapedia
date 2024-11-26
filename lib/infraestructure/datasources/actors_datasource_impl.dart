import 'package:dio/dio.dart';
import 'package:flutter_application_1/config/constants/environments.dart';
import 'package:flutter_application_1/domain/datasources/actors_datasource.dart';
import 'package:flutter_application_1/domain/entities/actor.dart';
import 'package:flutter_application_1/infraestructure/dto/moviedb/credits_response.dart';
import 'package:flutter_application_1/infraestructure/mappers/actor_mapper.dart';

class ActorsDatasourceImpl extends ActorsDatasource {

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environments.movieDbKey,
        'language': 'es-MX'
      }
    )
  );
  
  @override
  Future<List<Actor>> getActorByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final castResponse = CreditsResponse.fromJson(response.data);
    final List<Actor> actors = castResponse.cast
    .map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();

    return actors;
  }

}