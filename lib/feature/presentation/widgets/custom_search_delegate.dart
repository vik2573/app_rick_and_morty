import 'package:app_rick_and_morti/feature/domain/entities/person_entity.dart';
// import 'package:app_rick_and_morti/feature/domain/usecases/search_person.dart';
import 'package:app_rick_and_morti/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:app_rick_and_morti/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:app_rick_and_morti/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:app_rick_and_morti/feature/presentation/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CastomSearchDelegate extends SearchDelegate {
  CastomSearchDelegate() : super(searchFieldLabel: 'Search for characters...');
  final _suggestions = [
    'rick',
    'Morty',
    'Summar',
    'Beth',
    'Jerry',
  ];
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print('Insade custom search delegate and search query is $query');
    BlocProvider.of<PersonSearchBloc>(context, listen: false)
      ..add(SearchPersons(query));

    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
        builder: (context, state) {
      if (state is PersonSearchLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PersonSearchLoaded) {
        final person = state.persons;
        if (person.isEmpty) {
          return _schowErorrText('No Characters with that name faund');
        }
        return Container(
          child: ListView.builder(
              itemCount: person.isNotEmpty ? person.length : 0,
              itemBuilder: (context, int index) {
                PersonEntity result = person[index];
                return SearchResult(personResult: result);
              }),
        );
      } else if (state is PersonSearchError) {
        return _schowErorrText(state.message);
      } else {
        return Center(
          child: Icon(Icons.now_wallpaper),
        );
      }
    });
  }

  Widget _schowErorrText(String errorMessage) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          errorMessage,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 0) {
      return Container();
    }
    return ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Text(
            _suggestions[index],
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: _suggestions.length);
  }
}
