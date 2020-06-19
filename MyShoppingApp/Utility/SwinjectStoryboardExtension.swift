//
//  SwinjectStoryboardExtension.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 18/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

extension SwinjectStoryboard {
   @objc class func setup() {
    defaultContainer.register(Networking.self) { _ in
        WebServices()
    }
    defaultContainer.storyboardInitCompleted(ItemListViewController.self) { (resolver, controlller) in
        controlller.webServices = resolver.resolve(Networking.self)!
    }
   }
}
