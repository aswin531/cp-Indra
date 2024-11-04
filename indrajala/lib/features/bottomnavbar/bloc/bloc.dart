import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/bottomnavbar/bloc/event.dart';
import 'package:indrajala/features/bottomnavbar/bloc/state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavState> {
  BottomNavBarBloc() : super(BottomNavState(0)) {
    on<SelectedTabEvent>((event, emit) => emit(BottomNavState(event.tab)));
  }
}
