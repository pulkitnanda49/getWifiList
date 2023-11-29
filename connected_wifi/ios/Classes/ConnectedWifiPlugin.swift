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
                let frequency = getFrequency(fromBSSID: bssid) {

                // Check if the frequency is 2.4GHz
                if frequency <= 3 {
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

// Helper function to extract frequency from BSSID
func getFrequency(fromBSSID bssid: String) -> Int? {
    // Assuming that the frequency is included in the BSSID string
    // You may need to adjust this based on your actual BSSID format
    // For example, some BSSID formats include the frequency information
    // as the last two characters. Adjust the substring range accordingly.
    if let frequencySubstring = bssid.suffix(2).first {
        return Int(String(frequencySubstring), radix: 16)
    }
    return nil
}

}
