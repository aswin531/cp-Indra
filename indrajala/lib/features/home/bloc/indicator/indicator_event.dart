abstract class IndicatorEvent {}

class UpdateIndicator extends IndicatorEvent {
  final int index;
  UpdateIndicator(this.index);
}