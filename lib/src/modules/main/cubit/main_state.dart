part of 'main_cubit.dart';

sealed class MainState extends Equatable {
  const MainState();
}

final class MainInitial extends MainState {
  @override
  List<Object> get props => [];
}

class ChangePage extends MainState {
  final int index;

  const ChangePage(this.index);

  @override
  List<Object?> get props => [index];
}
