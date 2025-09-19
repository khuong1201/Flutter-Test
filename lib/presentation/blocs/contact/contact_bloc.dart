import 'package:flutter_bloc/flutter_bloc.dart';
import 'contact_event.dart';
import 'contact_state.dart';
import '../../../domain/repositories/contact_repository.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository repository;

  ContactBloc(this.repository) : super(const ContactState()) {
    on<LoadContactsEvent>(_onLoadContacts);
    on<AddContactEvent>(_onAddContact);
    on<UpdateContactEvent>(_onUpdateContact);
    on<DeleteContactEvent>(_onDeleteContact);
    on<ChangeSortEvent>(
      (event, emit) => emit(state.copyWith(sortOption: event.sortOption)),
    );
    on<ChangeViewEvent>(
      (event, emit) => emit(state.copyWith(isListView: event.isListView)),
    );
  }

  Future<void> _onLoadContacts(
    LoadContactsEvent event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final contacts = await repository
          .getContacts(); 
      emit(state.copyWith(contacts: contacts, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onAddContact(
    AddContactEvent event,
    Emitter<ContactState> emit,
  ) async {
    await repository.addContact(event.contact);
    add(LoadContactsEvent());
  }

  Future<void> _onUpdateContact(
    UpdateContactEvent event,
    Emitter<ContactState> emit,
  ) async {
    await repository.updateContact(event.contact);
    add(LoadContactsEvent());
  }

  Future<void> _onDeleteContact(
    DeleteContactEvent event,
    Emitter<ContactState> emit,
  ) async {
    await repository.deleteContact(event.id);
    add(LoadContactsEvent());
  }
}
