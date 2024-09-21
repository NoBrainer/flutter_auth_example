import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/client/cache_client.dart';
import '../data/repository/auth_repository.dart';
import 'auth/auth_bloc.dart';

class BusinessLogicLayer extends StatelessWidget {
  final Widget child;

  static CacheClient? globalCache;

  BusinessLogicLayer({super.key, required this.child}) {
    globalCache = globalCache ?? CacheClient();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(cache: globalCache),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
