import 'connected_wifi_platform_interface.dart';

class ConnectedWifi {
  Future<String?> getPlatformVersion() {
    return ConnectedWifiPlatform.instance.getPlatformVersion();
  }

  Future<List<String>> getWifiList() {
    return ConnectedWifiPlatform.instance.getWifiList();
  }
}
