import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SnackBarBloc extends Bloc<SnackbarEvent, SnackbarState> {
  // Test test = GetIt.instance();
  SnackBarBloc() : super(InitialSnackbarState());

  @override
  Stream<SnackbarState> mapEventToState(SnackbarEvent event) async* {
    // print(test.a);
    if (event is ShowSnackbarEvent) {
      yield ShowSnackBarState(
        content: event.content,
        type: event.type,
      );
    }
  }
}

abstract class SnackbarEvent {}

class ShowSnackbarEvent extends SnackbarEvent {
  String content;
  SnackBarType type;

  ShowSnackbarEvent({
    this.content,
    this.type,
  });
}

enum SnackBarType { success, error }

class ShowSnackBarState extends SnackbarState {
  ShowSnackBarState({
    @required type,
    String content,
  }) : super(
          type: type,
          content: content ?? '',
        );
}

abstract class SnackbarState {
  final String content;
  final SnackBarType type;

  SnackbarState({
    this.content,
    this.type,
  });
}

class InitialSnackbarState extends SnackbarState {}
