import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_stack_iteem_model.freezed.dart';

@freezed
class RouteStackIteemModel<T> with _$RouteStackIteemModel {
  const RouteStackIteemModel._();
  const factory RouteStackIteemModel({
    required String name,
    T? args,
  }) = _RouteStackIteemModel;

  factory RouteStackIteemModel.fromRoute(Route route) => RouteStackIteemModel(name: route.settings.name!, args: route.settings.arguments as T);
}
