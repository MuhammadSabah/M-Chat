import 'package:flutter/material.dart';

class TopSearchField extends StatelessWidget {
  const TopSearchField({super.key, required this.hintText, required this.name});
  final String hintText;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          onTap: () {},
          child: Ink(
            child: TextField(
              style: const TextStyle(fontSize: 18),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                isCollapsed: true,
                prefixIcon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    child: Text(
                      name.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                hintText: hintText,
                hintStyle: const TextStyle(fontSize: 17),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
