import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/home/bloc/indicator/indicator_event.dart';
import 'package:indrajala/features/home/bloc/indicator/indicator_state.dart';

class IndicatorBloc extends Bloc<IndicatorEvent, IndicatorState> {
  IndicatorBloc() : super(IndicatorState(0)) {
    on<UpdateIndicator>((event, emit) {
      emit(IndicatorState(event.index));
    });
  }
}
