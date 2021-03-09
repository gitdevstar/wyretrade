//
//  SplashController.swift
//  wyretrade
//
//  Created by maxus on 3/7/21.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import SlideMenuControllerSwift

class SplashController: UIViewController {
    
    var window: UIWindow?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkLogin()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func checkLogin() {

        if defaults.bool(forKey: "isLogin") {
//            self.appDelegate.moveToMain()
            self.moveToMain()
        }
        else {
//            self.appDelegate.moveToLogin()
            self.moveToLogin()
        }
    }
    
    func moveToMain() {

        let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainController") as! MainController
         let leftVC = storyboard?.instantiateViewController(withIdentifier: "LeftController") as! LeftController
         let navi : UINavigationController = UINavigationController(rootViewController: mainVC)
         let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftVC)
//        self.window?.rootViewController = slideMenuController
        //        self.window?.makeKeyAndVisible()
        navigationController?.pushViewController(slideMenuController, animated: true)
    }
    
    func moveToLogin() {

        let loginVC = storyboard?.instantiateViewController(withIdentifier: "SigninController") as! SigninController
        let nav: UINavigationController = UINavigationController(rootViewController: loginVC)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        navigationController?.pushViewController(loginVC, animated: true)
    }
}