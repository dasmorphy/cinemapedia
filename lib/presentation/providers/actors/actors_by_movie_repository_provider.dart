import 'package:flutter_application_1/infraestructure/datasources/actors_datasource_impl.dart';
import 'package:flutter_application_1/infraestructure/repositories/actors_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Este repositorio es inmutable ya que se esta usando Provider
//Su objetivo es proporcionar a todos los demas providers la informacion necesaria para consultar el datasourceimpl
final actorRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImpl(ActorsDatasourceImpl());
});