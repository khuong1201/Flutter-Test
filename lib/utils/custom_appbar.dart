import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppCustomBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onAddContact;
  final VoidCallback? onProfile;

  const AppCustomBar({super.key, this.onAddContact, this.onProfile});

  @override
  Widget build(BuildContext context) {
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
                onPressed: onAddContact,
                icon: const Icon(
                  FontAwesomeIcons.plus,
                  size: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Tiêu đề
          const Text(
            "Contact",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: onProfile,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                "https://hocdohoacaptoc.com/wp-content/uploads/2022/02/avata-dep-nam-2.jpg",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
