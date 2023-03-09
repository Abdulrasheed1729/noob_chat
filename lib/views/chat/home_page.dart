import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noob_chat/blocs/blocs.dart';
import 'package:noob_chat/repositories/repositories.dart';

import 'package:noob_chat/views/chat/message_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UsersListBloc(
            context.read<UserRepository>(),
          )..add(
              const UsersListSubscriptionRequested(),
            ),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersListBloc, UsersListState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == UsersListStatus.failure) {}
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Noob Chat 💬'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () =>
                  context.read<AppBloc>().add(const AppLogoutRequested()),
              icon: const Icon(
                Icons.exit_to_app,
              ),
              tooltip: 'Logout',
            ),
          ],
        ),
        body: BlocBuilder<UsersListBloc, UsersListState>(
          buildWhen: (previous, current) => previous.users != current.users,
          builder: (context, state) {
            final users = state.users;
            if (state.status == UsersListStatus.failure) {
              return AlertDialog(
                title: const Text('An error occured 😡'),
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Try again 🔁'),
                  ),
                ],
              );
            } else if (state.status == UsersListStatus.loading) {
              return const CircularProgressIndicator(color: Colors.indigo);
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 15,
                ),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(users[index].firstName!),
                          leading: CachedNetworkImage(
                            imageUrl: users[index].imageUrl!,
                            height: 60,
                            width: 50,
                            memCacheHeight: 60,
                            memCacheWidth: 50,
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              radius: 45,
                              backgroundImage: imageProvider,
                            ),
                          ),
                          trailing: const Icon(Icons.chat),
                          onTap: () async {
                            final room =
                                await context.read<ChatRepository>().createRoom(
                                      users[index].toAppUser,
                                    );
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (builer) =>
                                    MessagesListPage(room: room),
                              ),
                            );
                          },
                        ),
                        const Divider(),
                      ],
                    );
                  },
                  itemCount: users.length,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

extension JiffyX on int {}
