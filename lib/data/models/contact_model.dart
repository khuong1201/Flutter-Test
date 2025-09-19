import '../../domain/entities/contact.dart';

class ContactModel extends Contact {
  ContactModel({super.id, required super.name, required super.email, required super.phone});

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'] as int?,
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
