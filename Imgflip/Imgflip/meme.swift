//
//  meme.swift
//  Imgflip
//
//  Created by Andres Granados on 11/7/17.
//  Copyright © 2017 AFGranadosC. All rights reserved.
//

import Foundation


class meme: NSObject {
    
    var id:String = ""
    var name:String = ""
    var url:String = ""
    var width:Int = 0
    var height:Int = 0

    init(jsonDictionary: NSDictionary) {
        super.init()
        self.update(jsonDictionary: jsonDictionary)
    }
    
    func update(jsonDictionary: NSDictionary) {
        for (key, value) in jsonDictionary {
            let keyName:String = key as! String
            let keyValue = value
            
            // If property exists
            if self.responds(to: NSSelectorFromString(keyName)){
                //                let valor = self.value(forKey: keyName)
                self.setValue(keyValue, forKey: keyName)
            }
        }
    }
    
}
