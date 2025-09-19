import '../../../domain/entities/contact.dart';

class ContactState {
  final bool isLoading;
  final List<Contact> contacts;
  final String sortOption;
  final bool isListView;

  const ContactState({
    this.isLoading = false,
    this.contacts = const [],
    this.sortOption = "A-Z",
    this.isListView = true,
  });

  ContactState copyWith({
    bool? isLoading,
    List<Contact>? contacts,
    String? sortOption,
    bool? isListView,
  }) {
    return ContactState(
      isLoading: isLoading ?? this.isLoading,
      contacts: contacts ?? this.contacts,
      sortOption: sortOption ?? this.sortOption,
      isListView: isListView ?? this.isListView,
    );
  }

  List<Contact> get sortedContacts {
    List<Contact> sorted = [...contacts];
    switch (sortOption) {
      case "A-Z":
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case "Z-A":
        sorted.sort((a, b) => b.name.compareTo(a.name));
        break;
      case "Newest":
        sorted = sorted.reversed.toList();
        break;
      case "Oldest":
        break;
    }
    return sorted;
  }
}
