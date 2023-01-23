import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_chat_app/src/features/chat/widgets/video_player_widget.dart';
import 'package:final_chat_app/src/models/message_enum.dart';
import 'package:flutter/material.dart';

class DisplayMessage extends StatelessWidget {
  const DisplayMessage({
    super.key,
    required this.message,
    required this.type,
  });
  final String message;
  final MessageEnum type;
  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();

    return type == MessageEnum.text
        ? Padding(
            padding: const EdgeInsets.only(
              left: 5,
              right: 6,
              top: 5,
              bottom: 6,
            ),
            child: Text(message),
          )
        : type == MessageEnum.audio
            ? StatefulBuilder(
                builder: ((context, setState) {
                  return IconButton(
                    constraints: const BoxConstraints(
                      minHeight: 40,
                    ),
                    onPressed: () async {
                      if (isPlaying) {
                        await audioPlayer.pause();
                        setState(() {
                          isPlaying = false;
                        });
                      }
                      {
                        await audioPlayer.play(UrlSource(message));
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    },
                    icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle),
                  );
                }),
              )
            : type == MessageEnum.video
                ? VideoPlayerWidget(videoUrl: message)
                : CachedNetworkImage(
                    imageUrl: message,
                    progressIndicatorBuilder: (context, url, progress) {
                      return const CircularProgressIndicator();
                    },
                  );
  }
}
