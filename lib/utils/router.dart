// ignore_for_file: inference_failure_on_instance_creation

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noob_chat/blocs/blocs.dart';
import 'package:noob_chat/main.dart';
import 'package:noob_chat/views/views.dart';
import 'package:page_transition/page_transition.dart';

class NoobChatRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  final BotToastNavigatorObserver botToastNavigatorObserver =
      BotToastNavigatorObserver();

  late final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    observers: [botToastNavigatorObserver],
    initialLocation: '/',
    routes: [
      GoRoute(
        name: '/',
        path: '/',
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return PageTransition(child: child, type: PageTransitionType.fade)
                .child;
          },
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        name: 'login-page',
        path: '/login-page',
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return PageTransition(
              child: child,
              type: PageTransitionType.fade,
            ).child;
          },
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        name: 'signup-page',
        path: '/signup-page',
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return PageTransition(
              child: child,
              type: PageTransitionType.fade,
            ).child;
          },
          child: const SignUpPage(),
        ),
      ),
      GoRoute(
        name: 'chats-list-page',
        path: '/signup-page',
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return PageTransition(
              child: child,
              type: PageTransitionType.fade,
            ).child;
          },
          child: const HomePage(),
        ),
      ),
    ],
  );
}

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
