import 'package:flutter_bloc/flutter_bloc.dart';

/// The base every cubit in this app extends.
///
/// A request started by a page can come back after that page is gone, and
/// `emit` on a closed cubit throws a `StateError`. Every cubit needs the same
/// guard, so it lives here once instead of in each `try` block.
abstract class BaseCubit<State> extends Cubit<State> {
  BaseCubit(super.initialState);

  /// Drops the emit if the cubit is already closed.
  @override
  void emit(State state) {
    if (isClosed) return;
    super.emit(state);
  }
}
