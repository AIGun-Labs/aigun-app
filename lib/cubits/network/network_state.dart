import 'package:equatable/equatable.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object?> get props => [];
}

// 初始状态
class NetworkInitial extends NetworkState {}

// 连接成功的状态
class NetworkSuccess extends NetworkState {
  final ConnectivityResult result;

  const NetworkSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}


class NetworkFailure extends NetworkState {

}
