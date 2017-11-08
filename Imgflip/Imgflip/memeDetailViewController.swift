//
//  memeDetailViewController.swift
//  Imgflip
//
//  Created by Andres Granados on 11/7/17.
//  Copyright © 2017 AFGranadosC. All rights reserved.
//

import Foundation
import UIKit

class memeDetailViewController: UIViewController {
    
    var selectedMeme:meme!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = selectedMeme.name
        
        shareButton.addTarget(self, action: #selector(shareMeme), for: .touchUpInside)
        
        let urlString :String = NSString(string: selectedMeme.url).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let url = NSURL(string: urlString)!
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { () -> Void in
                
                self.memeImageView.image = UIImage(data: data as Data)
            }
        }
        
        messageLabel.text = selectedMeme.name

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    func shareMeme(){
        
        let url = "Hola, te comparto un meme '\(selectedMeme.name)', sigue este link:\n \(selectedMeme.url)"
        // set up activity view controller
        let textToShare = [ url ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
}




