import 'package:contact_list/utils/email_session.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppCustomBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onAddContact;
  final VoidCallback? onProfile;

  const AppCustomBar({super.key, this.onAddContact, this.onProfile});

  @override
  State<AppCustomBar> createState() => _AppCustomBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppCustomBarState extends State<AppCustomBar> {
  String? email;

  @override
  void initState() {
    super.initState();
    loadEmail();
  }

  Future<void> loadEmail() async {
    final storedEmail = await LocalStorage.getEmail();
    setState(() {
      email = storedEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    final avatar = email != null
        ? "https://ui-avatars.com/api/?name=${email!.split('@')[0]}&background=random"
        : "";
    return AppBar(
      backgroundColor: Colors.blue.shade100,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(40),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: widget.onAddContact,
                icon: const Icon(
                  FontAwesomeIcons.plus,
                  size: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const Text(
            "Contact",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: widget.onProfile,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: avatar.isNotEmpty
                  ? Image.network(
                      avatar,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.person, size: 50),
            ),
          ),
        ],
      ),
    );
  }
}
