
import UIKit

// Changing bar
extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // to start app
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

  
        let todoStore = TodoStore()
        
        // get first controller
        let taskViewController = window?.rootViewController?.children.first as? TaskViewController

        taskViewController?.todoStore = todoStore
        
        return true
    }
    
    // Active and inactive state
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    // To undone shared resources
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    // TO change form backgrund to active state
    func applicationWillEnterForeground(_ application: UIApplication) {

    }
    // To restart
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    // To close and save the data 
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    
}

