import 'package:bubble/bubble.dart';
import 'package:final_chat_app/src/features/chat/widgets/display_message.dart';
import 'package:final_chat_app/src/models/message_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
  }) : super(key: key);
  final String message;
  final DateTime date;
  final MessageEnum type;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Bubble(
              key: UniqueKey(),
              borderColor: Theme.of(context).colorScheme.tertiaryContainer,
              nip: BubbleNip.leftBottom,
              margin: const BubbleEdges.symmetric(horizontal: 12, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 6,
                      top: 5,
                      bottom: 6,
                    ),
                    child: DisplayMessage(
                      message: message,
                      type: type,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat('dd-MM yy, kk:mm').format(date).toString(),
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
