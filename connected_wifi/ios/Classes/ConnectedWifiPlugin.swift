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
            let connectedWifiList = getAvailableNetworks()
            result(connectedWifiList as NSArray)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    func getAvailableNetworks() -> [[String: Any]] {
        var networkList: [[String: Any]] = []

        if let interfaceNames = CNCopySupportedInterfaces() as NSArray? {
            for interfaceName in interfaceNames {
                if let interfaceName = interfaceName as? String,
                   
                   let ssid = networkInfo[kCNNetworkInfoKeySSID as String] as? String,
                   let bssid = networkInfo[kCNNetworkInfoKeyBSSID as String] as? String {
                    let network: [String: Any] = [
                        "ssid": ssid,
                        "bssid": bssid,
                        
                    ]
                    print("network \(network)")
                    
                    networkList.append(network)
                }
            }
        }

        return networkList
    }
}
