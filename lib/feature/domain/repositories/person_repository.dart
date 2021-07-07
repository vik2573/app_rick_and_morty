import 'package:app_rick_and_morti/core/error/failure.dart';
import 'package:app_rick_and_morti/feature/domain/entities/person_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page);
  Future<Either<Failure, List<PersonEntity>>> searchPersons(String query);
}
