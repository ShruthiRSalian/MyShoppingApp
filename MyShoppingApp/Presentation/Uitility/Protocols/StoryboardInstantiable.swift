//
//  StoryboardInstantiable.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 23/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import UIKit

public protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> T
}

public extension StoryboardInstantiable where Self: UIViewController {
    static var defaultFileName: String {
        return "Main"
    }
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        let vcName = NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
        guard let vc = storyboard.instantiateViewController(identifier: vcName) as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return vc
    }
}

