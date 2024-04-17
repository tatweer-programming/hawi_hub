import 'package:flutter/material.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/auth/presentation/widgets/widgets.dart';
import 'package:hawihub/src/modules/chat/data/models/message.dart';
import 'package:sizer/sizer.dart';
import 'package:voice_message_package/voice_message_package.dart';

class ChatScreen extends StatelessWidget {
  final String receiverId;
  final String receiverName;
  final String imageProfile;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
    required this.imageProfile,
  });

  @override
  Widget build(BuildContext context) {
    Message message = Message(
      dateOfMessage: "05:00 PM",
      receiverId: "",
      senderId: "",
      imageUrl:
          "https://static.wikia.nocookie.net/hunterxhunter/images/3/3e/HxH2011_EP147_Gon_Portrait.png/revision/latest?cb=20230904181801",
      messageId: "",
    );
    Message message2 = Message(
      dateOfMessage: "05:00 PM",
      receiverId: "",
      senderId: "",
      messageId: "",
      message: "hello",
    );
    Message message3 = Message(
      dateOfMessage: "05:00 PM",
      receiverId: "",
      senderId: "",
      messageId: "",
      voiceNoteUrl: "https://dl.musichi.ir/1401/06/21/Ghors%202.mp3",
    );
    List<Message> messages = [message, message2, message3];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _appBar(context: context, receiverName: receiverName, imageProfile: imageProfile),
          Expanded(
              child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _messageWidget(message: messages[index], isSender: true),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      messages[index].dateOfMessage,
                      style: TextStyleManager.getCaptionStyle().copyWith(fontSize: 10.sp),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 2.h,
            ),
            itemCount: messages.length,
          )),
          _sendButton(),
        ],
      ),
    );
  }
}

Widget _appBar({
  required BuildContext context,
  required String receiverName,
  required String imageProfile,
}) {
  return Container(
    height: 18.h,
    width: double.infinity,
    color: ColorManager.grey3.withOpacity(0.6),
    child: Padding(
      padding: EdgeInsetsDirectional.only(
        start: 5.w,
        end: 5.w,
        bottom: 3.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          backIcon(context),
          SizedBox(
            width: 5.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 16.sp,
                backgroundColor: ColorManager.primary,
                backgroundImage: NetworkImage(imageProfile),
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                receiverName,
                style: TextStyleManager.getSubTitleBoldStyle()
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _messageWidget({required Message message, required bool isSender}) {
  if (message.message != null) {
    return _textWidget(isSender: isSender, message: message.message!);
  }
  if (message.imageUrl != null) {
    return _imageWidget(isSender: isSender, image: message.imageUrl!);
  }
  if (message.voiceNoteUrl != null) {
    return _voiceWidget(isSender: isSender, voice: message.voiceNoteUrl!);
  }
  return Container();
}

Widget _textWidget({required bool isSender, required String message}) {
  return Align(
    alignment: isSender ? AlignmentDirectional.topEnd : AlignmentDirectional.topStart,
    child: Container(
      decoration: BoxDecoration(
        color: ColorManager.grey3.withOpacity(0.4),
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(15.sp),
          topEnd: Radius.circular(15.sp),
          bottomEnd: isSender ? Radius.zero : Radius.circular(15.sp),
          bottomStart: isSender ? Radius.circular(15.sp) : Radius.zero,
        ),
      ),
      padding: EdgeInsetsDirectional.only(
        start: 5.w,
        end: 10.w,
        top: 2.h,
        bottom: 2.h,
      ),
      child: Text(
        message,
        style: TextStyleManager.getRegularStyle().copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}

Widget _imageWidget({required bool isSender, required String image}) {
  return Align(
    alignment: isSender ? AlignmentDirectional.topEnd : AlignmentDirectional.topStart,
    child: Container(
      height: 20.h,
      width: 60.w,
      decoration: BoxDecoration(
        color: ColorManager.grey3.withOpacity(0.4),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(15.sp),
          topEnd: Radius.circular(15.sp),
          bottomEnd: isSender ? Radius.zero : Radius.circular(15.sp),
          bottomStart: isSender ? Radius.circular(15.sp) : Radius.zero,
        ),
      ),
    ),
  );
}

Widget _voiceWidget({
  required bool isSender,
  required String voice,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Align(
        alignment: isSender ? AlignmentDirectional.topEnd : AlignmentDirectional.topStart,
        child: Directionality(
          textDirection: isSender ? TextDirection.rtl : TextDirection.ltr,
          child: VoiceMessageView(
            controller: VoiceController(
              audioSrc: voice,
              maxDuration: const Duration(seconds: 200),
              isFile: true,
              onComplete: () {
                /// do something on complete
              },
              onPause: () {
                /// do something on pause
              },
              onPlaying: () {
                /// do something on playing
              },
              onError: (err) {
                /// do somethin on error
              },
            ),
            innerPadding: 10.sp,
            cornerRadius: 15.sp,
            circlesColor: ColorManager.primary,
            backgroundColor: ColorManager.grey3.withOpacity(0.4),
            activeSliderColor: ColorManager.primary,
          ),
        ),
      ),
    ],
  );
}

Widget _sendButton() {
  return Padding(
    padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w, vertical: 2.h),
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CircleAvatar(
              backgroundColor: ColorManager.third,
              radius: 19.sp,
            ),
            CircleAvatar(
              backgroundColor: ColorManager.white,
              radius: 15.sp,
              child: Icon(
                Icons.add,
                size: 20.sp,
                color: ColorManager.primary,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 3.w,
        ),
        Expanded(
          child: SizedBox(
            height: 6.h,
            child: TextField(
              decoration: InputDecoration(
                fillColor: ColorManager.grey3.withOpacity(0.3),
                filled: true,
                contentPadding: EdgeInsetsDirectional.symmetric(
                  horizontal: 5.w,
                ),
                hintText: "Write a message ....",
                hintStyle: TextStyleManager.getCaptionStyle().copyWith(
                  fontSize: 10.sp,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
