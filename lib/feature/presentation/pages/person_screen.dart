import 'package:app_rick_and_morti/feature/presentation/widgets/custom_search_delegate.dart';
import 'package:app_rick_and_morti/feature/presentation/widgets/persons_list_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CastomSearchDelegate());
            },
            icon: Icon(Icons.search),
            color: Colors.white,
          )
        ],
      ),
      body: PersonsList(),
    );
  }
}
