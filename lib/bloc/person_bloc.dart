import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_flutter/models/person.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:http/http.dart' as http;

part 'person_event.dart';
part 'person_state.dart';

var numberFetch = 0;
const startIndex = 10;
const personLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(const PersonState()) {
    on<PersonFetched>(
      _onPersonFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<PersonRefreshed>(_onPersonRefreshed);
  }

  final http.Client httpClient = http.Client();

  Future<void> _onPersonRefreshed(_, Emitter<PersonState> emit) async {
    numberFetch = 0;
    emit(state.copyWith(
      status: PersonStatus.initial,
      persons: [],
      hasReachedMax: false,
    ));
    await _onPersonFetched(_, emit);
  }

  Future<void> _onPersonFetched(_, Emitter<PersonState> emit) async {
    numberFetch++;
    if (state.hasReachedMax || numberFetch > 4) {
      return emit(state.copyWith(hasReachedMax: true));
    }

    try {
      final personLength = state.persons.length;
      if (state.status == PersonStatus.initial) {
        final persons = await _fetchPersons(startIndex);
        return emit(state.copyWith(
          status: PersonStatus.success,
          persons: persons,
          hasReachedMax: false,
        ));
      }

      final persons = await _fetchPersons(personLength == startIndex
          ? personLength + startIndex
          : personLength);
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

  Future<List<Person>> _fetchPersons([int startIndex = 10]) async {
    final response = await httpClient.get(
      Uri.https(
        'fakerapi.it',
        '/api/v1/persons',
        <String, String>{
          '_quantity': '${startIndex != 10 ? personLimit : startIndex}'
        },
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
