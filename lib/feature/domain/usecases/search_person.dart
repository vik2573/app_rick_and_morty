import 'package:app_rick_and_morti/core/error/failure.dart';
import 'package:app_rick_and_morti/core/usecaces/usecase.dart';
import 'package:app_rick_and_morti/feature/domain/entities/person_entity.dart';
import 'package:app_rick_and_morti/feature/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SerchPerson extends UseCase<List<PersonEntity>, SerchPersonParams> {
  final PersonRepository personRepository;

  SerchPerson(this.personRepository);

  Future<Either<Failure, List<PersonEntity>>> call(
      SerchPersonParams params) async {
    return await personRepository.searchPersons(params.query);
  }
}

class SerchPersonParams extends Equatable {
  final String query;

  SerchPersonParams({required this.query});

  @override
  List<Object> get props => [query];
}
