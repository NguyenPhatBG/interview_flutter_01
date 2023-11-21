import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:interview_flutter/bloc/person_bloc.dart';
import 'package:interview_flutter/widget/person_list.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons'),
        elevation: 5,
      ),
      body: BlocProvider(
        create: (_) =>
            PersonBloc(httpClient: http.Client())..add(PersonFetched()),
        child: const PersonList(),
      ),
    );
  }
}
