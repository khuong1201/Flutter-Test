import 'package:contact_list/injection.dart';
import 'package:contact_list/presentation/blocs/auth/auth_bloc.dart';
import 'package:contact_list/presentation/blocs/contact/contact_bloc.dart';
import 'package:contact_list/presentation/blocs/contact/contact_event.dart';
import 'package:contact_list/presentation/blocs/contact/contact_state.dart';
import 'package:contact_list/presentation/pages/profile_page.dart';
import 'package:contact_list/presentation/pages/user_detail.dart';
import 'package:contact_list/utils/card_info.dart';
import 'package:contact_list/utils/custom_appbar.dart';
import 'package:contact_list/utils/sort_and_view_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    super.initState();
    final bloc = getIt<ContactBloc>();
    bloc.add(LoadContactsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomBar(
        onAddContact: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailScreen(
                id: null,
                name: '',
                email: '',
                phone: '',
                avatar: '',
              ),
            ),
          );
        },
        onProfile: () {
          final user = context.read<AuthBloc>().state.user;
          if (user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProfilePage(user: user)),
            );
          }
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text("Loading contacts..."),
                  ],
                ),
              );
            }
            return Column(
              children: [
                SortAndViewBar(
                  sortOption: state.sortOption,
                  isListView: state.isListView,
                  onSortChanged: (val) =>
                      context.read<ContactBloc>().add(ChangeSortEvent(val)),
                  onViewChanged: (val) =>
                      context.read<ContactBloc>().add(ChangeViewEvent(val)),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: state.isListView
                      ? ContactListView(contacts: state.sortedContacts)
                      : ContactGridView(contacts: state.sortedContacts),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ContactListView extends StatelessWidget {
  final List contacts;
  const ContactListView({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: contacts.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final c = contacts[index];
        return CardInfo(
          id: c.id,
          avatar: "https://i.pravatar.cc/150?u=${c.id}",
          name: c.name,
          email: c.email,
          phone: c.phone,
          isGrid: false,
          onTap: () {
            if (c.id != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserDetailScreen(
                    id: c.id,
                    name: c.name,
                    email: c.email,
                    phone: c.phone,
                    avatar: "https://i.pravatar.cc/150?u=${c.id}",
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}

class ContactGridView extends StatelessWidget {
  final List contacts;
  const ContactGridView({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final c = contacts[index];
        return CardInfo(
          id: c.id,
          avatar: "https://i.pravatar.cc/150?u=${c.id}",
          name: c.name,
          email: c.email,
          phone: c.phone,
          isGrid: true,
          onTap: () {
            if (c.id != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserDetailScreen(
                    id: c.id,
                    name: c.name,
                    email: c.email,
                    phone: c.phone,
                    avatar: "https://i.pravatar.cc/150?u=${c.id}",
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
