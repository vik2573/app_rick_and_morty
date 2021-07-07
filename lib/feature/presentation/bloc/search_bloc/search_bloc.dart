import 'package:app_rick_and_morti/core/error/failure.dart';
import 'package:app_rick_and_morti/feature/domain/usecases/search_person.dart';
import 'package:app_rick_and_morti/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:app_rick_and_morti/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SerchPerson searchPerson;
  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty());

  @override
  Stream<PersonSearchState> mapEventToState(PersonSearchEvent event) async* {
    if (event is SearchPersons) {
      yield* _mapFetchPersonsToState(event.personQuery);
    }
  }

  Stream<PersonSearchState> _mapFetchPersonsToState(String personQuery) async* {
    yield PersonSearchLoading();

    final failureOrPerson =
        await searchPerson(SerchPersonParams(query: personQuery));
    yield failureOrPerson.fold(
        (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
        (person) => PersonSearchLoaded(persons: person));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
