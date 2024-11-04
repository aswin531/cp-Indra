abstract class BottomNavBarEvent {}

class SelectedTabEvent extends BottomNavBarEvent {
  final int tab;
  SelectedTabEvent(this.tab);
}

