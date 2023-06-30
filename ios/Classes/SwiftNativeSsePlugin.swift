import Flutter
import IKEventSource
import UIKit

public class SwiftNativeSsePlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    
    var sink:  FlutterEventSink?
    var eventSource : EventSource?
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        if (sink != nil) {
            
            do {
                eventSource?.disconnect()
            } catch {
                print("Error when disconnect \(error)")
            }
            
            eventSource = nil;

        }
        sink = events
        let serverURL = URL(string: (arguments as! NSDictionary)["url"] as! String);
        
        var headers : NSMutableDictionary = [:];
        
    
        
        (arguments as! NSDictionary).forEach { (key: Any, value: Any) in
            if (key as! String != "url") {
                headers.setObject(value, forKey: key as! NSCopying);
            }
        }
        eventSource = EventSource(url: serverURL!, headers: headers as! [String : String])
            eventSource?.connect()
        eventSource?.onMessage({ id, event, data in
            self.sink?(data);
        })
        return nil
        
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sink = nil
        if (eventSource != nil){
            eventSource?.disconnect()
            eventSource = nil
        }
        return nil
    
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "native_sse", binaryMessenger: registrar.messenger())
    let eventChannel = FlutterEventChannel(name: "native_sse_event", binaryMessenger: registrar.messenger())
    let instance = SwiftNativeSsePlugin()
    eventChannel.setStreamHandler(instance)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
