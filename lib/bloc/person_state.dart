part of 'person_bloc.dart';

enum PersonStatus { initial, success, failure }

final class PersonState extends Equatable {
  const PersonState({
    this.status = PersonStatus.initial,
    this.persons = const <Person>[],
    this.hasReachedMax = false,
  });

  final PersonStatus status;
  final List<Person> persons;
  final bool hasReachedMax;

  PersonState copyWith({
    PersonStatus? status,
    List<Person>? persons,
    bool? hasReachedMax,
  }) {
    return PersonState(
      status: status ?? this.status,
      persons: persons ?? this.persons,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PersonState { status: $status, hasReachedMax: $hasReachedMax, posts: ${persons.length} }''';
  }

  @override
  List<Object> get props => [status, persons, hasReachedMax];
}
