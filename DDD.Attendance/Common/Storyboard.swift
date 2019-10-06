//
//  Storyboard.swift
//  DDD.Attendance
//
//  Created by seongjun.park on 08/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
    case home = "Home"
    case account = "SignUp"
    case login = "Login"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(_ viewControllerClass: T.Type) -> T {
        return instance.instantiateViewController(withIdentifier: viewControllerClass.reuseIdentifier) as! T
    }
}
