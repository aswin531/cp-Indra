import 'package:flutter/material.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_bloc.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_state.dart';
import 'package:indrajala/features/home/bloc/movie/movie_bloc.dart';
import 'package:indrajala/features/home/bloc/movie/movie_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/home/presentation/widgets/drawer.dart';
import 'package:indrajala/features/home/presentation/widgets/movie_displaywidget.dart';

class HomeScreenTest extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    final movieBloc = context.read<MovieBloc>();

    movieBloc.add(FetchAllMovies());

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoggedOut) {
          // print("Navigating to login screen...");
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: Scaffold(
          backgroundColor: IAppColors.black,
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: IAppColors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.menu,
                color: IAppColors.pink,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          drawer: HomeDrawer(),
          body: const MovieDisplayWidget()),
    );
  }
}
