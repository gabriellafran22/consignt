import 'package:consignt/core/exception/api_exception.dart';
import 'package:flutter/material.dart';

enum AsyncStatus { uninitialized, loading, fail, success }

class Async<T> {
  T? data;
  ApiException? error;
  final ValueNotifier<AsyncStatus> state;

  Async(this.data, this.error, this.state);

  Async.initial()
      : data = null,
        error = null,
        state = ValueNotifier(AsyncStatus.uninitialized);

  Async loading() {
    state.value = AsyncStatus.loading;
    return this;
  }

  Async fail(ApiException error) {
    state.value = AsyncStatus.fail;
    this.error = error;
    return this;
  }

  Async success(T data) {
    state.value = AsyncStatus.success;
    this.data = data;
    return this;
  }

  bool hasData() => data != null;

  bool get isLoading => state.value == AsyncStatus.loading;

  bool get isFail => state.value == AsyncStatus.fail;

  bool get isSuccess => state.value == AsyncStatus.success;

  bool get isUninitialized => state.value == AsyncStatus.uninitialized;

  bool get isUninitializedOrLoading =>
      state.value == AsyncStatus.loading ||
      state.value == AsyncStatus.uninitialized;

  @override
  bool operator ==(Object other) {
    return other is Async && other.state == state;
  }

  @override
  int get hashCode => state.hashCode;
}

Async<T> uninitialized<T>() {
  return Async<T>.initial();
}

isInitializeOrLoading(AsyncStatus status) {
  return status == AsyncStatus.loading || status == AsyncStatus.uninitialized;
}
