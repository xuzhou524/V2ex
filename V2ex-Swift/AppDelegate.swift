//
//  AppDelegate.swift
//  V2ex-Swift
//
//  Created by huangfeng on 1/8/16.
//  Copyright © 2016 Fin. All rights reserved.
//

import UIKit
import GoogleMobileAds
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        URLProtocol.registerClass(WebViewImageProtocol.self)
        #if DEBUG
        #else
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        #endif

        let tabBarController = LDTabBarController()
        
         let vc1 = HomeViewController()
        let nav1 = LDNavigationController(rootViewController: vc1)
        
        nav1.tabBarItem = UITabBarItem(title: "首页", image: UIImage(named: "tabar_home"), selectedImage: UIImage(named: "tabar_home_sel")?.withRenderingMode(.alwaysOriginal))

        let vc2 = RightViewController()
        let nav2 = LDNavigationController(rootViewController: vc2)
        nav2.tabBarItem = UITabBarItem(title: "分类", image: UIImage(named: "tabar_class"), selectedImage: UIImage(named: "tabar_class_sel")?.withRenderingMode(.alwaysOriginal))
        
        let vc4 = UserViewController()
        let nav4 = LDNavigationController(rootViewController: vc4)
        nav4.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "tabar_me"), selectedImage: UIImage(named: "tabar_me_sel")?.withRenderingMode(.alwaysOriginal))
         tabBarController.viewControllers = [nav1,nav2,nav4]
        
        // 设置字体大小
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10.0)], for: UIControl.State.normal)
        // 设置字体偏移
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: 0.0)
        // 设置图标选中时颜色
        UITabBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().isTranslucent = false

        
        self.window = UIWindow();
        V2Client.sharedInstance.window = self.window
        self.window?.frame=UIScreen.main.bounds
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = tabBarController
        
        V2Client.sharedInstance.centerTabBarController = tabBarController
        
        #if DEBUG
            let fpsLabel = V2FPSLabel(frame: CGRect(x: 15, y: SCREEN_HEIGHT-40,width: 55,height: 20));
            self.window?.addSubview(fpsLabel);
        #else
        #endif
        
        SVProgressHUD.setForegroundColor(UIColor(white: 1, alpha: 1))
        SVProgressHUD.setBackgroundColor(UIColor(white: 0.15, alpha: 0.85))
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.setContainerView(self.window!)
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    fileprivate var lastPasteString: String?
    func applicationDidBecomeActive(_ application: UIApplication) {
        //如果剪切板内有 帖子URL ，则询问用户是否打开
        if let pasteString = UIPasteboard.general.string {
            guard lastPasteString != pasteString else {
                return
            }
            self.lastPasteString = pasteString
            
            let result = AnalyzURLResultType(url: pasteString)
            switch result {
                
            case .member(let member):
                let controller = UIAlertController(title: "是否打开用户主页?", message: pasteString, preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "打开", style: .default, handler: { (_) in
                    member.run()
                }))
                controller.addAction(UIAlertAction(title: "忽略", style: .cancel, handler: nil))
                V2Client.sharedInstance.topNavigationController.present(controller, animated: true, completion: nil)
                
            case .topic(let topic):
                let controller = UIAlertController(title: "是否打开帖子?", message: pasteString, preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "打开", style: .default, handler: { (_) in
                    topic.run()
                }))
                controller.addAction(UIAlertAction(title: "忽略", style: .cancel, handler: nil))
                V2Client.sharedInstance.topNavigationController.present(controller, animated: true, completion: nil)
                
            default : return
            }
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

