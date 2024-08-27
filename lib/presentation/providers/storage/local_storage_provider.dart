import 'package:cinemapedia/infrastructure/datasources/isar_database_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/loca_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) {
  //instancias para poder acceder a los metodos que creamos con isar para los cabios de favorite en la app
  return LocalStorageRepositoryImpl(IsarDatabaseDatasource());
});