//
//  ItemModel.swift
//  Todoey
//
//  Created by Nayak, Anuved on 21/10/18.
//  Copyright © 2018 Nayak, Anuved. All rights reserved.
//

import Foundation
class ItemModel: NSObject {
    var itemName =  String()
    var done : Bool = false
    
    convenience init(name: String, checked: Bool) {
        self.init()
        self.itemName = name
        self.done = checked
    }
    
}
