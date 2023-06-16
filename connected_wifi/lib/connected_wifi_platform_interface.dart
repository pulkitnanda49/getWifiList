import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'connected_wifi_method_channel.dart';

abstract class ConnectedWifiPlatform extends PlatformInterface {
  /// Constructs a ConnectedWifiPlatform.
  ConnectedWifiPlatform() : super(token: _token);

  static final Object _token = Object();

  static ConnectedWifiPlatform _instance = MethodChannelConnectedWifi();

  /// The default instance of [ConnectedWifiPlatform] to use.
  ///
  /// Defaults to [MethodChannelConnectedWifi].
  static ConnectedWifiPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ConnectedWifiPlatform] when
  /// they register themselves.
  static set instance(ConnectedWifiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<String>> getWifiList() {
    throw UnimplementedError(
        'getWifiList() has been implemented only for ios.');
  }
}
