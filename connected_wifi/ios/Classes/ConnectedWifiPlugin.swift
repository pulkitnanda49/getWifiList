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

    func getAvailableNetworks() -> [[String: String]] {
        var networkList: [[String: String]] = []

        if let interfaceNames = CNCopySupportedInterfaces() as NSArray? {
            for interfaceName in interfaceNames {
                if let interfaceName = interfaceName as? String,
                    let networkInfo = CNCopyCurrentNetworkInfo(interfaceName as CFString) as NSDictionary?,
                   let ssid = networkInfo[kCNNetworkInfoKeySSID as String] as? String,
                   let bssid = networkInfo[kCNNetworkInfoKeyBSSID as String] as? String,
                   let frequency = getFrequency(for: interfaceName) {
                    
                    // Check if the frequency is 2.4GHz
                    if frequency <= 2500 {
                        let network: [String: String] = [
                            "ssid": ssid,
                            "bssid": bssid,
                            "frequency": "\(frequency) MHz"
                        ]
                        print("network \(network)")
                        networkList.append(network)
                    }
                }
                   
            }
        }

        return networkList
    }

    // Helper function to get the frequency of the connected network
    func getFrequency(for interfaceName: String) -> Int? {
        if let supportedInterfaces = CNCopySupportedInterfaces() as? [String] {
            if supportedInterfaces.contains(interfaceName) {
                if let interface = CNCopyCurrentNetworkInfo(interfaceName as CFString) as NSDictionary?,
                    let info = interface[kCNNetworkInfoKeySSID as String] as? [AnyHashable: Any],
                    let frequency = info[kCNNetworkInfoKeyFrequency as String] as? NSNumber {
                    return frequency.intValue
                }
            }
        }
        return nil
    }
}
