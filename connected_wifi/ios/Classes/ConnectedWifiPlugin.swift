import Flutter
import UIKit
import SystemConfiguration.CaptiveNetwork

public class ConnectedWifiPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "connected_wifi", binaryMessenger: registrar.messenger())
    let instance = ConnectedWifiPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "getWifiList":
      let connectedWifiList = getAvailableSSIDs();
      result(connectedWifiList as NSArray)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

   func getAvailableSSIDs() -> [String] {
        var ssidList: [String] = []
        
        if let interfaceNames = CNCopySupportedInterfaces() as NSArray? {
            for interfaceName in interfaceNames {
                if let interfaceName = interfaceName as? String,
                    let networkInfo = CNCopyCurrentNetworkInfo(interfaceName as CFString) as NSDictionary?,
                    let ssid = networkInfo[kCNNetworkInfoKeySSID as String] as? String {
                    ssidList.append(ssid)
                }
            }
        }
        
        return ssidList
    }
}
