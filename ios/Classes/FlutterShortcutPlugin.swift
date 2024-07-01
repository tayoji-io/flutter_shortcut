import Flutter
import UIKit

public class FlutterShortcutPlugin: NSObject, FlutterPlugin {
    private var channel: FlutterMethodChannel
    private var registrar: FlutterPluginRegistrar
    
    init(channel: FlutterMethodChannel,registrar: FlutterPluginRegistrar) {
        self.channel = channel
        self.registrar = registrar
        
    }
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.tayoji.flutter_shortcut", binaryMessenger: registrar.messenger())
        
        let instance = FlutterShortcutPlugin(channel: channel,registrar: registrar);
        registrar.addApplicationDelegate(instance)
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        
    }
    
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setShortcutItems":
            setShortcutItems(call, result)
        case "clearShortcutItems":
            UIApplication.shared.shortcutItems = []
            result(nil)
        case "pushShortcutItem","pushShortcutItems","updateShortcutItem", "updateShortcutItems":
            guard let args = call.arguments as? [Dictionary<String, Any>?] else { return  }
            let  items = args.map { dict in
                return getShortcutItem(dict!);
            }
            if (UIApplication.shared.shortcutItems == nil) {
                UIApplication.shared.shortcutItems = items
            }else {
                items.forEach { item in
                    let index =  UIApplication.shared.shortcutItems!.firstIndex(where: { _item in
                        return _item.type == item.type
                    })
                    if (index == nil ) {
                        UIApplication.shared.shortcutItems?.append(item)
                    }else {
                        UIApplication.shared.shortcutItems![index!] = item
                    }
                }
            }
            result(nil)
        default:
            result(nil)
            
        }
    }
    private func setShortcutItems(_ call: FlutterMethodCall,_ result: @escaping FlutterResult){
        guard let args = call.arguments as? [Dictionary<String, Any>?] else { return  }
        let  items = args.map { dict in
            return getShortcutItem(dict!);
        }
        UIApplication.shared.shortcutItems = items
    }
    
    private func getShortcutItem(_ dict:Dictionary<String, Any>) ->UIApplicationShortcutItem{
        let shortcutIconType = dict["shortcutIconType"] as? String
        let action =  dict["action"] as! String
        var shortcutIcon:UIApplicationShortcutIcon?
        var longLabel = dict["longLabel"] as? String

        if  let icon = dict["icon"] as? String {
            switch shortcutIconType {
            case "0":
                shortcutIcon = UIApplicationShortcutIcon(templateImageName: icon)
                break
            case "1":
                shortcutIcon = UIApplicationShortcutIcon(templateImageName: registrar.lookupKey(forAsset: icon))
                break;
            default:
                break;
            }
        }
       if let item = UIApplication.shared.shortcutItems?.first(where: { item in
            return item.type == action
       }) {
           if (shortcutIcon == nil) {
               shortcutIcon = item.icon
           }
           if (longLabel == nil || longLabel?.count == 0) {
               longLabel = item.localizedSubtitle;
           }
       }
        return UIApplicationShortcutItem.init(
            type: action,
            localizedTitle: dict["shortLabel"] as! String ,
            localizedSubtitle: longLabel,
            icon:shortcutIcon)
        
    }
    
    public func application(
        _ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
    ) -> Bool {
        self.channel.invokeMethod("launch", arguments: shortcutItem.type) { data in
        }
        return true
    }
    
}
