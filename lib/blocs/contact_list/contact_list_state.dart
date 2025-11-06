import 'package:equatable/equatable.dart';
import 'package:sample_project/models/contact.dart';

abstract class ContactListState extends Equatable {
  const ContactListState();

  @override
  List<Object?> get props => [];
}

class ContactListInitial extends ContactListState {}

class ContactListLoading extends ContactListState {}

class ContactListLoaded extends ContactListState {
  final List<Contact> data;

  const ContactListLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class ContactListError extends ContactListState {
  final String message;

  const ContactListError(this.message);

  @override
  List<Object?> get props => [message];
}

class ContactListDeleted extends ContactListState {}
