import 'package:flutter_application_1/domain/entities/actor.dart';
import 'package:flutter_application_1/infraestructure/dto/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => 
  Actor(
    id: cast.id, 
    name: cast.name, 
    profilePath: cast.profilePath != null 
    ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
    : 'https://bysperfeccionoral.com/wp-content/uploads/2020/01/136-1366211_group-of-10-guys-login-user-icon-png.jpg', 
    character: cast.character
  );
}