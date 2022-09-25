import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyMessageCard extends StatelessWidget {
  const MyMessageCard({
    Key? key,
    // required this.message,
    // required this.date,
  }) : super(key: key);
  // final String message;
  // final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Bubble(
              key: UniqueKey(),
              borderColor: Theme.of(context).colorScheme.primaryContainer,
              nip: BubbleNip.rightBottom,
              margin: const BubbleEdges.symmetric(horizontal: 12, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 6,
                      top: 5,
                      bottom: 6,
                    ),
                    child: Text(
                      "Anything lorea jaklf akdjfka dfjakld flka f alf kdjasfipsum askjdfka sdfjdaskf adskf afjas dfjasdfjsad fsadj adskfljsadkf sdjfklas ",
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  // DateFormat('dd-MM yy, kk:mm').format(date).toString(),
                  'Date',
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.done_all,
                  size: 20,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 12),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
