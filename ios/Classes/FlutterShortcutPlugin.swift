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
        case "pushShortcutItem":
            guard let args = call.arguments as? Dictionary<String,Any>  else {return}
            let item =  getShortcutItem(args)
            if (UIApplication.shared.shortcutItems == nil) {
                UIApplication.shared.shortcutItems = [item]
            }else {
                UIApplication.shared.shortcutItems?.append(item)
            }
            result(nil)
        case "pushShortcutItems":
            guard let args = call.arguments as? [Dictionary<String, Any>?] else { return  }
            let  items = args.map { dict in
                return getShortcutItem(dict!);
            }
            if (UIApplication.shared.shortcutItems == nil) {
                UIApplication.shared.shortcutItems = items
            }else {
                UIApplication.shared.shortcutItems?.append(contentsOf: items)
            }
            result(nil)
        case "updateShortcutItem":
            guard let args = call.arguments as? Dictionary<String,Any>  else {return}
            let item =  getShortcutItem(args)
            if (UIApplication.shared.shortcutItems == nil) {
                UIApplication.shared.shortcutItems = [item]
            }else {
                let index =  UIApplication.shared.shortcutItems!.firstIndex(where: { _item in
                    return _item.type == item.type
                })
                if (index == nil ) {
                    UIApplication.shared.shortcutItems?.append(item)
                }else {
                    UIApplication.shared.shortcutItems![index!] = item
                }
            }
            result(nil)
        case "updateShortcutItems":
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
        var shortcutIcon:UIApplicationShortcutIcon?
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
        return UIApplicationShortcutItem.init(
            type: dict["action"] as! String,
            localizedTitle: dict["shortLabel"] as! String ,
            localizedSubtitle: dict["longLabel"] as? String,
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
