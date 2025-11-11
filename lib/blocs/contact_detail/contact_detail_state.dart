import 'package:equatable/equatable.dart';
import 'package:sample_project/models/contact.dart';

abstract class ContactDetailState extends Equatable {
  const ContactDetailState();

  Contact? get contact => null;
  int? get index => null;

  @override
  List<Object?> get props => [];
}

class ContactDetailInitial extends ContactDetailState {}

class ContactDetailLoading extends ContactDetailState {}

class ContactDetailLoaded extends ContactDetailState {
  final Contact screenContact;
  final int screenIndex;

  const ContactDetailLoaded(this.screenContact, this.screenIndex);

  @override
  Contact? get contact => screenContact;
  @override
  int? get index => screenIndex;

  @override
  List<Object?> get props => [screenContact, screenIndex];
}

class ContactDetailDeleted extends ContactDetailState {}

class ContactDetailError extends ContactDetailState {
  final String message;

  const ContactDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
