//
//  TableListItem.swift
//  ZZSnapMutipleViewSetup
//
//  Created by zerry on 2021/9/30.
//

import UIKit

final class TableListItem: NSObject {
    
    let name: String
    let controllerClass: UIViewController.Type
    
    init(
        name: String,
        controllerClass: UIViewController.Type
    ) {
        self.name = name
        self.controllerClass = controllerClass
    }
    
}
