import 'package:flutter_application_1/domain/datasources/local_storage_datasource.dart';
import 'package:flutter_application_1/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageDatasourceImpl extends LocalStorageDatasource{

  late Future<Isar> db = openDB();

  // IsarDatasource() {
  //   db = openDB();
  // }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema], directory: dir.path, inspector: true);
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;

    //Compara el id movie y devuelve el primero que encuentra
    final Movie? isMovieFavorite = await isar.movies
      .filter()
      .idEqualTo(movieId)
      .findFirst();

    return isMovieFavorite != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;

    return isar.movies.where()
      .offset(offset)
      .limit(limit)
      .findAll();

  }

  @override
  Future<bool> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie = await isar.movies
      .filter()
      .idEqualTo(movie.id)
      .findFirst();


    if (favoriteMovie != null) {
      //Eliminar
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.idIsar!));
      return Future<bool>.value(false);
    }

    //Se guarda la pelicula en caso que no este guardada previamente
    return isar.writeTxnSync(() {
      isar.movies.putSync(movie);
      return Future<bool>.value(true);
    });
  }

}