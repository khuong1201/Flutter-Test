import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/contact.dart';
import '../blocs/contact/contact_bloc.dart';
import '../blocs/contact/contact_event.dart';

class UserDetailScreen extends StatefulWidget {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String avatar;

  const UserDetailScreen({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
  });

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.name);
    _emailCtrl = TextEditingController(text: widget.email);
    _phoneCtrl = TextEditingController(text: widget.phone);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _saveContact() {
    final contact = Contact(
      id: widget.id,
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      avatar: "https://i.pravatar.cc/150?u=$_nameCtrl",
      phone: _phoneCtrl.text.trim(),
    );

    final bloc = context.read<ContactBloc>();

    if (widget.id == null) {
      bloc.add(AddContactEvent(contact));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Contact added")));
    } else {
      bloc.add(UpdateContactEvent(contact));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Contact updated")));
    }

    Navigator.pop(context, contact);
  }

  void _deleteContact() {
    final bloc = context.read<ContactBloc>();
    if (widget.id != null) {
      bloc.add(DeleteContactEvent(widget.id!));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Contact deleted")));
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? "Add Contact" : "Edit Contact"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: widget.avatar.isNotEmpty
                  ? NetworkImage(widget.avatar)
                  : null,
              child: widget.avatar.isEmpty
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneCtrl,
              decoration: const InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: TextButton(
                    onPressed: _saveContact,
                    child: Text(
                      widget.id == null ? "Add Contact" : "Update Contact",
                    ),
                  ),
                ),
                if (widget.id != null) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    child: TextButton(
                      onPressed: _deleteContact,
                      child: const Text(
                        "Delete Contact",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
