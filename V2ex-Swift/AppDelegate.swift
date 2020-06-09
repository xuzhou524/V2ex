//
//  AppDelegate.swift
//  V2ex-Swift
//
//  Created by huangfeng on 1/8/16.
//  Copyright © 2016 Fin. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        URLProtocol.registerClass(WebViewImageProtocol.self)
        

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

        
        self.window = V2Window();
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
        
        /**
        DEBUG 模式下不统计任何信息，如果你需要使用Crashlytics ，请自行申请账号替换我的Key
        */
        #if DEBUG
        #else
            Fabric.with([Crashlytics.self])
        #endif
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
        V2EXColor.sharedInstance.refreshStyleIfNeeded()
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

class V2Window: UIWindow {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if UIApplication.shared.applicationState == .active{
            //这里有个问题，APP返回到后台后，traitCollection.userInterfaceStyle 会从 light 切换到 night 再切换回来，导致V2EXColor以为需要更新主题，但其实不需要更新
            //所以只在程序在前台时，才响应。程序从后台返回前台如果要更改主题，则在 applicationDidBecomeActive 里判断
            V2EXColor.sharedInstance.refreshStyleIfNeeded()
        }
    }
}
