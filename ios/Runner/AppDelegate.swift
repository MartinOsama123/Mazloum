import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
       let batteryChannel = FlutterMethodChannel(name: "com.flutter.epic/epic",
                                                 binaryMessenger: controller.binaryMessenger)
      
                 batteryChannel.setMethodCallHandler({
                 [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
                 
                 // Note: this method is invoked on the UI thread.
                     if (call.method == "printy"){
                        let sb = UIStoryboard(name: "AR", bundle: nil)
                        let nav = sb.instantiateViewController(withIdentifier: "AR")
                        if let vc = nav.children.first as? ViewController {
                          //  vc.bodyTitle = "AR BITCH"
                        }
                        controller.present(nav, animated: true, completion: nil)
                    } else {
                  result(FlutterMethodNotImplemented)
                  return
                 }
             //  self?.receiveBatteryLevel(result: result)
             })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    private func openSecondPage(param: String) {
      
    }
}

