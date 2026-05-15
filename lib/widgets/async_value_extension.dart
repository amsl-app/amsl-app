import 'package:amsl_app/widgets/loading/skeleton_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'error/error_bar.dart';

extension AsyncValueHandler<T> on AsyncValue<T> {
  Widget build(
    BuildContext context, {
    required Widget Function(BuildContext context, T? data) builder,
    Widget Function(BuildContext context, Object error, StackTrace stackTrace)?
    errorBuilder,
    Widget Function(BuildContext context)? loadingBuilder,
    bool showDataOnError = true,
  }) {
    switch (this) {
      case AsyncLoading():
        if (loadingBuilder != null) {
          return loadingBuilder(context);
        }
        return const SkeletonLoadingScreen();
      case AsyncData(value: final value):
        return builder(context, value);

      // No data available and error
      case AsyncError(
        error: final error,
        stackTrace: final stackTrace,
        value: final value,
      ):
        showException(context, error);
        if (showDataOnError && value != null) {
          return builder(context, value);
        }
        if (errorBuilder != null) {
          return errorBuilder(context, error, stackTrace);
        }
        return const SkeletonLoadingScreen();
    }
  }

  void handle(
    BuildContext context, {
    required Function(T? data) onData,
    required Function(Object error, StackTrace stackTrace) onError,
    required Function() onLoading,
    bool showDataOnError = true,
  }) {
    switch (this) {
      case AsyncLoading():
        onLoading();
        break;
      case AsyncData(value: final value):
        onData(value);
        break;
      case AsyncError(
        error: final error,
        stackTrace: final stackTrace,
        value: final value,
      ):
        showException(context, error);
        if (showDataOnError && value != null) {
          onData(value);
        } else {
          onError(error, stackTrace);
        }
        break;
    }
  }
}

extension FutureHandler<T> on Future<T> {
  Widget build(
    BuildContext context, {
    required Widget Function(BuildContext context, T? data) builder,
    Widget Function(BuildContext context, Object error, StackTrace stackTrace)?
    errorBuilder,
    Widget Function(BuildContext context)? loadingBuilder,
    bool showDataOnError = true,
  }) {
    return FutureBuilder<T>(
      future: this,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          if (loadingBuilder != null) {
            return loadingBuilder(context);
          }
          return const SkeletonLoadingScreen();
        } else if (snapshot.hasError) {
          final error = snapshot.error!;
          final stackTrace = snapshot.stackTrace!;
          showException(context, error);
          if (errorBuilder != null) {
            return errorBuilder(context, error, stackTrace);
          }
          return const SkeletonLoadingScreen();
        } else {
          return builder(context, snapshot.data);
        }
      },
    );
  }

  void handle(
    BuildContext context, {
    Function(T data)? onData,
    Function(Object error, StackTrace stackTrace)? onError,
  }) {
    then((value) {
      if (onData != null) {
        onData(value);
      }
    }).catchError((error, stackTrace) {
      if (onError == null) {
        if (context.mounted) {
          showException(context, error);
        }
      } else {
        onError(error, stackTrace);
      }
    });
  }
}
