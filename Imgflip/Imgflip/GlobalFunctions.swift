//
//  GlobalFunctions.swift
//  Imgflip
//
//  Created by Andres Granados on 11/7/17.
//  Copyright © 2017 AFGranadosC. All rights reserved.
//

import Foundation
import UIKit


func displayAlert(viewp: UIViewController,title:String ,userMessage: String){
    
    let alert = UIAlertController(title: title, message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
    let doneAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default) {
        UIAlertAction in
        
        alert.dismiss(animated: true, completion: nil)
    }
    
    alert.addAction(doneAction)
    
    viewp.present(alert, animated: true, completion: nil)
}


func getDataFromUrl(url:NSURL, completion: @escaping ((_ data: NSData?, _ response: URLResponse?, _ error: NSError? ) -> Void)) {
    URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
        completion(data as NSData?, response, error as NSError?)
        }.resume()
}







