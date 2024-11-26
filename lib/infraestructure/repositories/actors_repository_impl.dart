import 'package:flutter_application_1/domain/datasources/actors_datasource.dart';
import 'package:flutter_application_1/domain/entities/actor.dart';
import 'package:flutter_application_1/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {

  final ActorsDatasource datasource;
  ActorsRepositoryImpl(this.datasource);


  @override
  Future<List<Actor>> getActorByMovie(String movieId) {
    return datasource.getActorByMovie(movieId);

  }

}