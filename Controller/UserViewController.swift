//
//  UserViewController.swift
//  V2ex-Swift
//
//  Created by gozap on 2020/6/8.
//  Copyright © 2020 Fin. All rights reserved.
//

import UIKit

class UserViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var tableView: UITableView = {
        let tableView = UITableView();
        tableView.backgroundColor = V2EXColor.colors.v2_backgroundColor
        tableView.separatorStyle = .none
        
        regClass(tableView, cell: LeftUserHeadCell.self)
        regClass(tableView, cell: LeftNodeTableViewCell.self)
        regClass(tableView, cell: LeftNotifictionCell.self)
        
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        self.view.backgroundColor = V2EXColor.colors.v2_backgroundColor
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView);
        self.tableView.snp.makeConstraints{ (make) -> Void in
            make.top.right.bottom.left.equalTo(self.view);
        }
        
        if V2User.sharedInstance.isLogin {
            self.getUserInfo(V2User.sharedInstance.username!)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [1,3,2][section]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 1 && indexPath.row == 2){
            return 55 + 15
        }
        return [150, 55+SEPARATOR_HEIGHT, 55+SEPARATOR_HEIGHT][indexPath.section]
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgView = UIView()
        bgView.backgroundColor = V2EXColor.colors.v2_backgroundColor
        return bgView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if  indexPath.row == 0 {
                let cell = getCell(tableView, cell: LeftUserHeadCell.self, indexPath: indexPath);
                return cell ;
            }else {
                return UITableViewCell()
            }
        }else if (indexPath.section == 1) {
            if indexPath.row == 1 {
                let cell = getCell(tableView, cell: LeftNotifictionCell.self, indexPath: indexPath)
                cell.nodeImageView.image = UIImage(named: "ic_notifications_none")
                return cell
            }else {
                let cell = getCell(tableView, cell: LeftNodeTableViewCell.self, indexPath: indexPath)
                cell.nodeNameLabel.text = [NSLocalizedString("me"),"",NSLocalizedString("favorites")][indexPath.row]
                let names = ["ic_face","","ic_turned_in_not"]
                cell.nodeImageView.image = UIImage(named: names[indexPath.row])
                return cell
            }
        }else {
            let cell = getCell(tableView, cell: LeftNodeTableViewCell.self, indexPath: indexPath)
            cell.nodeNameLabel.text = [NSLocalizedString("nodes"),NSLocalizedString("version")][indexPath.row]
            let names = ["ic_navigation","ic_settings_input_svideo"]
            cell.nodeImageView.image = UIImage(named: names[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                if !V2User.sharedInstance.isLogin {
                    let loginViewController = LoginViewController()
                    self.navigationController?.present(loginViewController, animated: true, completion: nil);
                }else{
                    let memberViewController = MyCenterViewController()
                    memberViewController.username = V2User.sharedInstance.username
                    self.navigationController?.pushViewController(memberViewController, animated: true)
                }
            }
        }else if indexPath.section == 1 {
            if !V2User.sharedInstance.isLogin {
                let loginViewController = LoginViewController()
                self.navigationController?.present(loginViewController, animated: true, completion: nil);
                return
            }
            if indexPath.row == 0 {
                let memberViewController = MyCenterViewController()
                memberViewController.username = V2User.sharedInstance.username
                self.navigationController?.pushViewController(memberViewController, animated: true)
            }else if indexPath.row == 1 {
                let notificationsViewController = NotificationsViewController()
                self.navigationController?.pushViewController(notificationsViewController, animated: true)
            }else if indexPath.row == 2 {
                let favoritesViewController = FavoritesViewController()
                self.navigationController?.pushViewController(favoritesViewController, animated: true)
            }
        }else if indexPath.section == 2 {
            if indexPath.row == 0 {
                let nodesViewController = NodesViewController()
                self.navigationController?.pushViewController(nodesViewController, animated: true)
            }
        }
    }
        
    // MARK: 获取用户信息
    func getUserInfo(_ userName:String){
        UserModel.getUserInfoByUsername(userName) {(response:V2ValueResponse<UserModel>) -> Void in
            if response.success {
//                self?.tableView.reloadData()
                NSLog("获取用户信息成功")
            }else{
                NSLog("获取用户信息失败")
            }
        }
    }
}
