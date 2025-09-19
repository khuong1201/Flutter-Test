import '../../../domain/entities/contact.dart';

abstract class ContactEvent {}

class LoadContactsEvent extends ContactEvent {}

class AddContactEvent extends ContactEvent {
  final Contact contact;
  AddContactEvent(this.contact);
}

class UpdateContactEvent extends ContactEvent {
  final Contact contact;
  UpdateContactEvent(this.contact);
}

class DeleteContactEvent extends ContactEvent {
  final int id;
  DeleteContactEvent(this.id);
}

class ChangeSortEvent extends ContactEvent {
  final String sortOption;
  ChangeSortEvent(this.sortOption);
}

class ChangeViewEvent extends ContactEvent {
  final bool isListView;
  ChangeViewEvent(this.isListView);
}
