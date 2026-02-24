import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:ebirth/core/network/network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasInternetAccess;
}

