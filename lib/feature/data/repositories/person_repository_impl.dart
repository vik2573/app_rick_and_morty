import 'package:app_rick_and_morti/core/error/exception.dart';
import 'package:app_rick_and_morti/core/platform/network_info.dart';
import 'package:app_rick_and_morti/feature/data/datasources/person_local_data_source.dart';
import 'package:app_rick_and_morti/feature/data/datasources/person_remote_data_source.dart';
import 'package:app_rick_and_morti/feature/data/models/person_model.dart';
import 'package:app_rick_and_morti/feature/domain/entities/person_entity.dart';
import 'package:app_rick_and_morti/core/error/failure.dart';
import 'package:app_rick_and_morti/feature/domain/repositories/person_repository.dart';

import 'package:dartz/dartz.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSouce;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.remoteDataSouce,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() {
      return remoteDataSouce.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPersons(
      String query) async {
    return await _getPersons(() {
      return remoteDataSouce.searchPerson(query);
    });
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotPerson = await getPersons();
        localDataSource.personsToCache(remotPerson);
        return Right(remotPerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationPerson = await localDataSource.getLastPersonsFromCache();
        return Right(locationPerson);
      } on CachException {
        return Left(CacheFailure());
      }
    }
  }
}
