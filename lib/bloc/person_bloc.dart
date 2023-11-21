import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_flutter/models/person.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:http/http.dart' as http;

part 'person_event.dart';
part 'person_state.dart';

const _personLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc({required this.httpClient}) : super(const PersonState()) {
    on<PersonFetched>(
      _onPersonFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onPersonFetched(
      PersonFetched event, Emitter<PersonState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PersonStatus.initial) {
        final persons = await _fetchPersons();
        return emit(state.copyWith(
          status: PersonStatus.success,
          persons: persons,
          hasReachedMax: false,
        ));
      }
      final persons = await _fetchPersons(state.persons.length);
      emit(
        persons.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: PersonStatus.success,
                persons: List.of(state.persons)..addAll(persons),
                hasReachedMax: false,
              ),
      );
    } catch (e) {
      emit(state.copyWith(status: PersonStatus.failure));
    }
  }

  Future<List<Person>> _fetchPersons([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'fakerapi.it',
        '/api/v1/persons',
        <String, String>{'_quantity': '$_personLimit'},
      ),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List data = body['data'] ?? [];
      List<Person> dataCovert =
          data.map((json) => Person.fromJson(json)).toList();

      return dataCovert;
    }
    throw Exception('Error fetching persons');
  }
}
