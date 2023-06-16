// import 'package:flutter_test/flutter_test.dart';
// import 'package:connected_wifi/connected_wifi.dart';
// import 'package:connected_wifi/connected_wifi_platform_interface.dart';
// import 'package:connected_wifi/connected_wifi_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockConnectedWifiPlatform
//     with MockPlatformInterfaceMixin
//     implements ConnectedWifiPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final ConnectedWifiPlatform initialPlatform = ConnectedWifiPlatform.instance;

//   test('$MethodChannelConnectedWifi is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelConnectedWifi>());
//   });

//   test('getPlatformVersion', () async {
//     ConnectedWifi connectedWifiPlugin = ConnectedWifi();
//     MockConnectedWifiPlatform fakePlatform = MockConnectedWifiPlatform();
//     ConnectedWifiPlatform.instance = fakePlatform;

//     expect(await connectedWifiPlugin.getPlatformVersion(), '42');
//   });
// }
