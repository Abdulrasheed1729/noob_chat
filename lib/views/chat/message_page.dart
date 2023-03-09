import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:noob_chat/blocs/blocs.dart';
import 'package:noob_chat/repositories/repositories.dart';

class MessagesListPage extends StatelessWidget {
  const MessagesListPage({required this.room, super.key});

  final types.Room room;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MessagesBloc(
            context.read<ChatRepository>(),
            room,
          )..add(
              const MessagesListSubscriptionRequested(),
            ),
        ),
      ],
      child: MessagesListView(
        room: room,
      ),
    );
  }
}

class MessagesListView extends StatelessWidget {
  const MessagesListView({required this.room, super.key});
  final types.Room room;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MessagesBloc, MessagesState>(
          listenWhen: (previous, current) =>
              previous.messages != current.messages,
          listener: (context, state) {},
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade700,
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            centerTitle: true,
            title: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: room.users[0].imageUrl!,
                  height: 60,
                  width: 50,
                  memCacheHeight: 60,
                  memCacheWidth: 50,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 45,
                    backgroundImage: imageProvider,
                  ),
                ),
              ],
            ),
          ),
          body: BlocBuilder<MessagesBloc, MessagesState>(
            buildWhen: (previous, current) =>
                previous.messages != current.messages,
            builder: (context, state) {
              return SizedBox(
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Chat(
                    messages: state.messages,
                    onSendPressed: (message) =>
                        context.read<MessagesBloc>().add(
                              TextMessageSent(message),
                            ),
                    user: context.read<AuthRepository>().currentUser.toUser,
                    showUserAvatars: true,
                    useTopSafeAreaInset: true,
                    emojiEnlargementBehavior: EmojiEnlargementBehavior.single,
                    hideBackgroundOnEmojiMessages: false,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    theme: DefaultChatTheme(
                      backgroundColor: Colors.grey.shade700,
                      inputMargin:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                      inputBorderRadius: BorderRadius.circular(10),
                      primaryColor: Colors.indigo,
                      secondaryColor: Colors.black12,
                      deliveredIcon: const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.grey,
                      ),
                      sentMessageBodyTextStyle: const TextStyle(
                        color: neutral7,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                      receivedMessageBodyTextStyle: const TextStyle(
                        color: neutral7,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
