import '../../domain/entities/contact.dart';
import '../../domain/repositories/contact_repository.dart';
import '../datasources/contact_local_datasource.dart';
import '../models/contact_model.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactLocalDataSource localDataSource;

  ContactRepositoryImpl(this.localDataSource);

  @override
  Future<void> addContact(Contact contact) async {
    await localDataSource.insertContact(ContactModel(
      name: contact.name,
      email: contact.email,
      phone: contact.phone,
    ));
  }

  @override
  Future<void> deleteContact(int id) async {
    await localDataSource.deleteContact(id);
  }

  @override
  Future<List<Contact>> getContacts() async {
    return await localDataSource.getContacts();
  }

  @override
  Future<void> updateContact(Contact contact) async {
    await localDataSource.updateContact(ContactModel(
      id: contact.id,
      name: contact.name,
      email: contact.email,
      phone: contact.phone,
    ));
  }
}
