import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/core/models/question.dart';
import 'package:flutter_template/presentation/screens/game_screen.dart';
import 'package:flutter_template/presentation/screens/home_screen.dart';
import 'package:flutter_template/presentation/screens/how_to_play_screen.dart';
import 'package:flutter_template/presentation/screens/main_screen.dart';
import 'package:flutter_template/presentation/screens/settings_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: GameRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: HowToPlayRoute.page),
      ];
}
