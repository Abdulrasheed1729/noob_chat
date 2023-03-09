import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noob_chat/blocs/app/app_bloc.dart';
import 'package:noob_chat/blocs/blocs.dart';
import 'package:noob_chat/cubits/cubits.dart';
import 'package:noob_chat/firebase_options.dart';
import 'package:noob_chat/repositories/repositories.dart';
import 'package:noob_chat/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final chatRepository = ChatRepository();
  final userRepository = UserRepository();
  final storageRepository = StorageRepository();
  final connectivityManager = ConnectivityManager();
  final authRepository = AuthRepository();
  await authRepository.user.first;

  runApp(
    NoobChat(
      authRepository: authRepository,
      chatRepository: chatRepository,
      storageRepository: storageRepository,
      connectivityManager: connectivityManager,
      userRepository: userRepository,
    ),
  );
}

class NoobChat extends StatelessWidget {
  ///
  const NoobChat({
    required AuthRepository authRepository,
    required ChatRepository chatRepository,
    required UserRepository userRepository,
    required StorageRepository storageRepository,
    required ConnectivityManager connectivityManager,
    super.key,
  })  : _authRepository = authRepository,
        _chatRepository = chatRepository,
        _connectivityManager = connectivityManager,
        _userRepository = userRepository,
        _storageRepository = storageRepository;

  final AuthRepository _authRepository;
  final ChatRepository _chatRepository;
  final UserRepository _userRepository;
  final StorageRepository _storageRepository;
  final ConnectivityManager _connectivityManager;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authRepository,
        ),
        RepositoryProvider.value(
          value: _chatRepository,
        ),
        RepositoryProvider.value(
          value: _userRepository,
        ),
        RepositoryProvider.value(
          value: _storageRepository,
        ),
        RepositoryProvider.value(
          value: _connectivityManager,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(authRepository: _authRepository),
          ),
          BlocProvider(
            create: (context) => ConnectivityCubit(_connectivityManager),
          ),
        ],
        child: const NoobChatView(),
      ),
    );
  }
}

class NoobChatView extends StatelessWidget {
  const NoobChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listener: (context, state) {},
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade100,
          primaryColor: Colors.indigo,
          useMaterial3: true,
        ),
        home: const NoobChatAuthFlowView(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (mounted) {
          final isAuthenticated =
              context.read<AppBloc>().state.status == AppStatus.authenticated;

          if (isAuthenticated) {
            context.go(context.namedLocation('chats-list-page'));
          } else {
            context.go(context.namedLocation('login-page'));
          }
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Noob Chat',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class NoobChatAuthFlowView extends StatelessWidget {
  const NoobChatAuthFlowView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<AppStatus>(
      state: context.select((AppBloc bloc) => bloc.state.status),
      onGeneratePages: onGenerateAppViewPages,
    );
  }
}
