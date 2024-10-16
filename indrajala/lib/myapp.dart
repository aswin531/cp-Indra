import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/dependency_injection/service_locator.dart';
import 'package:indrajala/core/router/approutes.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_bloc.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_event.dart';
import 'package:indrajala/features/auth/bloc/visibilitybloc/visibility_bloc.dart';
import 'package:indrajala/features/details/bloc/moviebloc/moviedetail_bloc.dart';
import 'package:indrajala/features/home/bloc/indicator/indicator_bloc.dart';
import 'package:indrajala/features/home/bloc/movie/movie_bloc.dart';
import 'package:indrajala/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:indrajala/features/splash/presentation/splash_screen.dart';
import 'package:indrajala/features/subscription/bloc/paymentbloc/payment_bloc.dart';
import 'package:indrajala/features/subscription/bloc/subscriptionbloc/subscription_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(InitializeAuthEvent()),
        ),
        BlocProvider(
          create: (context) => sl<PasswordVisibilityBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<MovieBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<IndicatorBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SubscriptionBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<PaymentBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Indrajala',
        initialRoute: IAppRoutes.splash,
        onGenerateRoute: IAppRoutes.generateRoute,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: IAppColors.pink),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
