import 'package:app_rick_and_morti/feature/domain/entities/person_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object?> get props => [];
}

class PersonEmpty extends PersonState {
  @override
  List<Object?> get props => [];
}

class PersonLoading extends PersonState {
  final List<PersonEntity> oldPersonsList;
  final bool isFirstFetch;

  PersonLoading(this.oldPersonsList, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldPersonsList];
}

class PersonLoaded extends PersonState {
  final List<PersonEntity> personList;

  PersonLoaded(this.personList);

  @override
  List<Object?> get props => [personList];
}

class PersonError extends PersonState {
  final String message;

  PersonError({required this.message});
}
