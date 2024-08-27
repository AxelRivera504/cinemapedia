import 'package:path_provider/path_provider.dart';
import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';

class IsarDatabaseDatasource extends LocalStorageDataSource{
  
  //Se hace late pare esperar a que la BD este lista para las conexiones
  late Future<Isar> db;

  IsarDatabaseDatasource(){
    db = openDb();
  }

  
  Future<Isar> openDb() async{
     final dir = await getApplicationDocumentsDirectory();


    if(Isar.instanceNames.isEmpty){
      return await Isar.open(
        [MovieSchema], 
        inspector: true, 
        directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

    @override
    Future<bool> isMovieFavorite(int movieId) async {
      final isar = await db;
      final Movie? isFavoriteMovie = await isar.movies.filter().idEqualTo(movieId).findFirst();

      return isFavoriteMovie != null ? true : false;
    }

    @override
    Future<void> toggleMovie(Movie movie) async {
      final isar = await db;
      final favoriteMovie = await isar.movies.filter().idEqualTo(movie.id).findFirst();

      if(favoriteMovie != null ){
        //Borrar
        isar.writeTxnSync(() => isar.movies.deleteSync( favoriteMovie.isarId!));
        return ;
      }
        isar.writeTxnSync(() => isar.movies.putSync(movie));
    }

    @override
    Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
      final isar = await db;
      return isar.movies.where()
      .offset(offset) // las paginas que tendremos
      .limit(limit) // el limit la cantidad de peliculas que nos traera
      .findAll();
    }

  }