import 'dart:async';

import 'package:async/async.dart';

class CustomCancelableOperation<T> {
  CancelableOperation<T>? cancelableOperation;

  final Future<T> Function({Map<String, dynamic>? args}) loadingFn;
  FutureOr<void> Function(T, CancelableCompleter<T>)? onValue;
  FutureOr<void> Function(Object, StackTrace, CancelableCompleter<T>)? onError;
  FutureOr<void> Function(CancelableCompleter<T>)? onCancel;

  //final FutureOr<dynamic> Function()? onCancel;
  final FutureOr<dynamic> Function()? onStartOperation;
  //final FutureOr<void> Function(T val)? whenComplete;
  CustomCancelableOperation(this.loadingFn, {this.onCancel, this.onValue, this.onStartOperation, this.onError});

  Future<T> load({Map<String, dynamic>? args}) async {
    if (cancelableOperation == null) {
      cancelableOperation = CancelableOperation<T>.fromFuture(
        loadingFn(args: args),
        onCancel: () async {
          cancelableOperation = null;
        },
      );
      cancelableOperation!.thenOperation(onValue ?? (p0, p1) => null, onCancel: onCancel, onError: onError);
      if (onStartOperation != null) {
        onStartOperation!();
      }

      cancelableOperation!.value.whenComplete(() {
        cancelableOperation = null;
      });

      T val = await cancelableOperation!.value;

      return val;
    } else {
      T val = await cancelableOperation!.value;
      return val;
    }
  }
}
