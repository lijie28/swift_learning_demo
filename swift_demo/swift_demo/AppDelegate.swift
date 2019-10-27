//
//  AppDelegate.swift
//  swift_demo
//
//  Created by JackLee on 2018/12/19.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit




extension Notification.Name {
    static let applicationDidEnterBackground = Notification.Name("applicationDidEnterBackground")
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var backgroundTaskID: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("applicationWillResignActive")
        //バックグラウンドで行いたい処理があるとき
        self.backgroundTaskID = application.beginBackgroundTask {
            [weak self] in
            application.endBackgroundTask((self?.backgroundTaskID)!)
            self?.backgroundTaskID = UIBackgroundTaskIdentifier.invalid
        }
    }
    
    

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        
    
        //it will print the time how long tha app could be active in the background
        print(UIApplication.shared.backgroundTimeRemaining)
        
        
        NotificationCenter.default.post(name: .applicationDidEnterBackground, object: nil)
        
//        application.task
        
        
        print("applicationDidEnterBackground")
        
//        let taskID = application.beginBackgroundTask {
//            // Code to ensure your background processing stops executing
//            // so it reaches the call to endBackgroundTask:
//            print("taskID = application.beginBackgroundTask")
//        }
//
//        let task2 = application.beginBackgroundTask(withName: "fortest") {
//            print("test2 ")
//        }
//
        // Put the code you want executed in the background here
        print("Put the code you want executed in the background here")
        
//        if (taskID != UIBackgroundTaskIdentifier.invalid) {
//            print("taskID != UIBackgroundTaskIdentifier.invalid")
////            UIApplication.shared.endBackgroundTask(taskID)
////            [[UIApplication sharedApplication] endBackgroundTask:taskID];
//        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive")
        //タスクの解除
        application.endBackgroundTask(self.backgroundTaskID)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

