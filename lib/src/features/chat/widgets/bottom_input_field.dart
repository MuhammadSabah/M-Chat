import 'dart:async';
import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:final_chat_app/common/utils.dart';
import 'package:final_chat_app/src/features/chat/controller/chat_controller.dart';
import 'package:final_chat_app/src/models/message_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class BottomInputField extends ConsumerStatefulWidget {
  BottomInputField({
    super.key,
    required this.receiverUserId,
  });
  String receiverUserId;
  @override
  ConsumerState<BottomInputField> createState() => _BottomInputFieldState();
}

class _BottomInputFieldState extends ConsumerState<BottomInputField> {
  bool isFieldActive = false;
  String? fieldValue;
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  //
  FlutterSoundRecorder? soundRecorder;
  bool isRecorderInit = false;
  bool isRecording = false;
  bool isShowEmojiContainer = false;
  bool isKeyboardVisible = false;
  //
  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic not allowed');
    }
    await soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  FocusNode focusNode = FocusNode();
  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
      isKeyboardVisible = false;
    });
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showKeyboard() {
    focusNode.requestFocus();
  }

  void hideKeyboard() {
    focusNode.unfocus();
  }

  void toggleEmojiContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  //
  void sendTextMessage() async {
    if (isFieldActive) {
      ref.read(chatControllerProvider).sendTextMessage(
            textController.text,
            widget.receiverUserId,
          );
    }
  }

  void sendFileMessage(File file, MessageEnum messageEnum) {
    ref.read(chatControllerProvider).sentFileMessage(
          file: file,
          receiverUserId: widget.receiverUserId,
          messageEnum: messageEnum,
        );
  }

  void selectImage() async {
    File? image = await pickImageFromGallery();
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
    Get.back(closeOverlays: true);
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery();
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
    Get.back(closeOverlays: true);
  }

  void recordSound() async {
    Directory tempDir = await getTemporaryDirectory();
    var path = '${tempDir.path}/flutter_sound.aac';
    if (!isRecorderInit) {
      return;
    }
    if (isRecording) {
      await soundRecorder!.stopRecorder();
      sendFileMessage(File(path), MessageEnum.audio);
    } else {
      await soundRecorder!.startRecorder(
        toFile: path,
      );
    }
    setState(() {
      isRecording = !isRecording;
    });
    Get.back(closeOverlays: true);
  }

  //
  late StreamSubscription<bool> keyboardSubscription;
  @override
  void initState() {
    soundRecorder = FlutterSoundRecorder();
    openAudio();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool isKeyboardVisible) {
      setState(() {
        this.isKeyboardVisible = isKeyboardVisible;
        if (isKeyboardVisible && isShowEmojiContainer) {
          setState(() {
            isShowEmojiContainer = false;
          });
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    soundRecorder!.closeRecorder();
    isRecorderInit = false;
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isFieldActive = textController.text.isNotEmpty;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0).copyWith(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: () async => showChatDialog(context),
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(width: 1, color: Colors.grey.shade500),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Scrollbar(
                            controller: scrollController,
                            thumbVisibility: true,
                            child: TextField(
                              onChanged: (String? value) {
                                setState(() {
                                  fieldValue = value;
                                });
                              },
                              textDirection: TextDirection.ltr,
                              scrollController: scrollController,
                              controller: textController,
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.multiline,
                              cursorWidth: 1,
                              minLines: 1,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                hintText: 'Type a message...',
                                isCollapsed: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: IconButton(
                            onPressed: toggleEmojiContainer,
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              isFieldActive
                  ? const SizedBox()
                  : IconButton(
                      onPressed: selectImage,
                      icon: Icon(
                        Icons.image_outlined,
                        color: Theme.of(context).colorScheme.primary,
                        // color: iconColor,
                      ),
                    ),
              IconButton(
                onPressed: () {
                  if (isFieldActive) {
                    sendTextMessage();
                  }
                },
                icon: Icon(
                  Icons.send_outlined,
                  color: isFieldActive
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
        isShowEmojiContainer
            ? SizedBox(
                height: 280,
                child: EmojiPicker(
                  onEmojiSelected: ((category, emoji) {
                    setState(() {
                      textController.text = textController.text + emoji.emoji;
                    });
                  }),
                ),
              )
            : Container(),
      ],
    );
  }

  Future showChatDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: selectVideo,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Send a video'),
                Icon(
                  Icons.video_file,
                  size: 20,
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: recordSound,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Send a voice message'),
                Icon(
                  isRecording ? Icons.close : Icons.mic,
                  color: Colors.black,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
