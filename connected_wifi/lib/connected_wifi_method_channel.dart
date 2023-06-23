import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'connected_wifi_platform_interface.dart';

/// An implementation of [ConnectedWifiPlatform] that uses method channels.
class MethodChannelConnectedWifi extends ConnectedWifiPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('connected_wifi');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<List<Map>> getWifiList() async {
    final list = await methodChannel.invokeMethod<List>('getWifiList');
    return (list ?? []).map((e) => Map.from(e)).toList();
  }
}
