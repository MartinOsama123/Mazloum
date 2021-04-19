import UIKit
import Flutter
import MPGSDK

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
                 [weak self] (call: FlutterMethodCall, result:  FlutterResult) -> Void in
                 
                 // Note: this method is invoked on the UI thread.
                     if (call.method == "printy"){
                        
                        let sb = UIStoryboard(name: "AR", bundle: nil)
                        let nav = sb.instantiateViewController(withIdentifier: "AR")
                        if let vc = nav.children.first as? ViewController {
                          //  vc.bodyTitle = "AR BITCH"
                        }
                        controller.present(nav, animated: true, completion: nil)
                     } else if (call.method == "payment") {
                        guard let args = call.arguments else { return }
                        
                        let myArgs = args as? [String: Any]
                        let group = DispatchGroup()
                        var request = GatewayMap()
                        request[at: "sourceOfFunds.provided.card.nameOnCard"] = myArgs?["cardName"] as? String
                        request[at: "sourceOfFunds.provided.card.number"] = myArgs?["cardNumber"] as? String
                        request[at: "sourceOfFunds.provided.card.securityCode"] = myArgs?["CVV"] as? String
                        request[at: "sourceOfFunds.provided.card.expiry.month"] = myArgs?["expireMonth"] as? String
                        request[at: "sourceOfFunds.provided.card.expiry.year"] = myArgs?["expireYear"] as? String
                        
                        let gateway = Gateway(region: GatewayRegion.asiaPacific, merchantId: myArgs?["merchantID"] as? String ?? "")
                        var temp: String = "Error"
                        group.enter()
                        gateway.updateSession(myArgs?["sessionID"] as? String ?? "", apiVersion: String(myArgs?["api"] as? String ?? "49"),payload: request) { (value) in
                            switch value {
                            case .success(let response):
                                print("Success:")
                                temp = "Success"
                                print(myArgs?["sessionID"] as? String)
                                print(myArgs?["merchantID"] as? String)
                                print(myArgs?["api"] as? String)
                                print(myArgs?["cardName"] as? String)
                                print(myArgs?["cardNumber"] as? String)
                                print(myArgs?["CVV"] as? String)
                                print(myArgs?["expireMonth"] as? String)
                                print(myArgs?["expireYear"] as? String)
                                group.leave()
                            
                            case .error(let error):
                                print("Errorrr:")
                                print(myArgs?["sessionID"] as? String)
                                print(myArgs?["merchantID"] as? String)
                                print(myArgs?["api"] as? String)
                                print(myArgs?["cardName"] as? String)
                                print(myArgs?["cardNumber"] as? String)
                                print(myArgs?["CVV"] as? String)
                                print(myArgs?["expireMonth"] as? String)
                                print(myArgs?["expireYear"] as? String)
                                group.leave()
                            }
                        
                            
                        }
                        group.wait()
                            result(temp)
                        
                       
                     
                     }
                     else {
                        result(FlutterMethodNotImplemented)
                  return
                 }
             //  self?.receiveBatteryLevel(result: result)
             })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

