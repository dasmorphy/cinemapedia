import 'package:flutter_application_1/infraestructure/datasources/local_storage_datasource_impl.dart';
import 'package:flutter_application_1/infraestructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) => 
  LocalStorageRepositoryImpl(LocalStorageDatasourceImpl()));