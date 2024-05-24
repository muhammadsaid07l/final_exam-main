import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../../assets/icons.dart';
import '../../../../core/widgets/w_app_bar.dart';
import '../../../../core/widgets/w_button.dart';
import '../../../authentication/domain/repository/authentication.dart';
import '../../../authentication/presentation/bloc/bloc/authentication_bloc.dart';
import '../../../authentication/presentation/pages/login_screen/login_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (_, state) {
      if (state.status == AuthenticationStatus.authenticated) {
        return Scaffold(
          appBar: const WAppBar(title: 'Chat'),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    tileMode: TileMode.mirror,
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Text(
                    'Coming soon...',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ),
              )
            ],
          ),
        );
      } else {
        return UnauthenticatedUser(theme: theme);
      }
    });
  }
}

class UnauthenticatedUser extends StatelessWidget {
  const UnauthenticatedUser({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.arrow),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Для полноценного использования войдите в аккаунт',
                    style: theme.headline1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          WButton(
            margin: const EdgeInsets.all(16),
            text: 'Войти',
            textStyle: theme.headline2!.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
            onTap: () {
              // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              //   builder: (_) => LoginScreen(
              //       repository:
              //           RepositoryProvider.of<AuthenticationRepository>(
              //               context)),
              // ));
            },
          )
        ],
      ),
    );
  }
}
