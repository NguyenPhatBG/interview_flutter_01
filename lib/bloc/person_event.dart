part of 'person_bloc.dart';

sealed class PersonEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PersonFetched extends PersonEvent {}

final class PersonRefreshed extends PersonEvent {}
