//
//  V2EXNavigationController.swift
//  V2ex-Swift
//
//  Created by huangfeng on 1/13/16.
//  Copyright © 2016 Fin. All rights reserved.
//

import UIKit

import YYText

class V2EXNavigationController: UINavigationController {
    
    /// 毛玻璃效果的 navigationBar 背景
    var frostedView:UIToolbar = UIToolbar()
    /// navigationBar 阴影
    var shadowImage:UIImage?
    /// navigationBar 背景透明度
    var navigationBarAlpha:CGFloat {
        get{
            return  self.frostedView.superview?.alpha ?? 0
        }
        set {
            var value = newValue
            if newValue > 1 {
                value = 1
            }
            else if value < 0 {
                value = 0
            }
            self.frostedView.superview?.alpha = newValue
            if(value == 1){
                if self.navigationBar.shadowImage != nil{
                    self.navigationBar.shadowImage = nil
                }
            }
            else {
                if self.navigationBar.shadowImage == nil{
                    self.navigationBar.shadowImage = UIImage()
                }
            }
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get {
            return .default
        }
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .fullScreen
    }
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.modalPresentationStyle = .fullScreen
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        self.navigationBar.setBackgroundImage(createImageWithColor(UIColor.clear), for: .default)

        let maskingView = UIView()
        
        maskingView.isUserInteractionEnabled = false
        self.navigationBar.superview!.insertSubview(maskingView, belowSubview: self.navigationBar)
        maskingView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: NavigationBarHeight)


        self.frostedView.isUserInteractionEnabled = false
        self.frostedView.clipsToBounds = true
        maskingView.addSubview(self.frostedView);
        self.frostedView.snp.makeConstraints{ (make) -> Void in
            make.top.bottom.left.right.equalTo(maskingView);
        }
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : v2Font(18),
            NSAttributedString.Key.foregroundColor : XZSwiftColor.topicListTitleColor
        ]
        
        maskingView.backgroundColor = UIColor(white: 0, alpha: 0.0);
        if #available(iOS 13.0, *) {
            self.frostedView.overrideUserInterfaceStyle = .light
        } else {
            self.frostedView.barStyle = .default
        }

        
        //全局键盘颜色
        UITextView.appearance().keyboardAppearance = .light
        UITextField.appearance().keyboardAppearance = .light
        YYTextView.appearance().keyboardAppearance = .light
    }
}
