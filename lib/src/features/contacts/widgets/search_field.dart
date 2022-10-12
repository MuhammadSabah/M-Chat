import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.hintText,});
final String hintText;

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
              style: TextStyle(fontSize: 17),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isCollapsed: true,
                prefixIcon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 17),
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
