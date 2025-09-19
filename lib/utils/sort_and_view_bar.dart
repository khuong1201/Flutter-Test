import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SortAndViewBar extends StatelessWidget {
  final String sortOption;
  final bool isListView;
  final ValueChanged<String> onSortChanged;
  final ValueChanged<bool> onViewChanged;

  const SortAndViewBar({
    super.key,
    required this.sortOption,
    required this.isListView,
    required this.onSortChanged,
    required this.onViewChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Sort
        Row(
          children: [
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: const Text("Sort"),
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: PopupMenuButton<String>(
                onSelected: onSortChanged,
                itemBuilder: (context) => const [
                  PopupMenuItem(value: "A-Z", child: Text("A-Z")),
                  PopupMenuItem(value: "Z-A", child: Text("Z-A")),
                  PopupMenuItem(value: "Newest", child: Text("Newest")),
                  PopupMenuItem(value: "Oldest", child: Text("Oldest")),
                ],
                child: Row(
                  children: [
                    Text(sortOption),
                    const Icon(FontAwesomeIcons.chevronDown, size: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.list,
                  size: 18,
                  color: isListView ? Colors.black : Colors.grey,
                ),
                onPressed: () => onViewChanged(true),
              ),
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.thLarge,
                  size: 18,
                  color: !isListView ? Colors.black : Colors.grey,
                ),
                onPressed: () => onViewChanged(false),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
