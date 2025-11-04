import 'package:equatable/equatable.dart';
import 'package:sample_project/models/contact.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object?> get props => [];
}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final List<Contact> data;
  final Contact? myContact;

  const DataLoaded(this.data, {this.myContact});

  @override
  List<Object?> get props => [data, myContact];
}

class DataError extends DataState {
  final String message;
  final Contact? myContact;

  const DataError(this.message, {this.myContact});

  @override
  List<Object?> get props => [message, myContact];
}
