//
//  ViewController.swift
//  Imgflip
//
//  Created by Andres Granados on 11/7/17.
//  Copyright © 2017 AFGranadosC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var getMemesButton: UIButton!
    @IBOutlet weak var randomMemeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getMemesButton.addTarget(self, action: #selector(getMemes), for: .touchUpInside)
        randomMemeButton.addTarget(self, action: #selector(selectRandomMeme), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func serviceGetMemes(isRandomMeme:Bool){
        
        let myUrl = NSURL(string: "https://api.imgflip.com/get_memes")
        //        let myUrl = NSURL(string: "\(HostPort)v1/user/getPassword?access_token=\(accessToken)")
        let request = NSMutableURLRequest(url: myUrl! as URL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            
            data, response, error in
            
            if error != nil {
                
                return
            }
            print(data)
            print (response)
            
            print(request)
            
            //Print out response body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("response data = \(responseString)")
            
            do {   let json =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if (json != nil) {
                    
                    print("json: \(json)")
                    if let data = (json?.object(forKey: "data")) as? NSDictionary {
                        
                        print("data = \(data)")
                        
                        if let memes = (data.object(forKey: "memes")) as? NSArray {
                            
                            if isRandomMeme{
                                let row = self.selectRandomIndex(memesNumber: memes.count)
                                let m = meme(jsonDictionary: memes.object(at: row) as! NSDictionary)
                                self.performSegue(withIdentifier: "goDetailMeme", sender: m)
                            }else{
                                self.performSegue(withIdentifier: "goMemesList", sender: memes)
                            }
                        }
                    }else if (json?.object(forKey: "error")) != nil {
                        
                        
                    }else{
                        
                    }
                }
                
            } catch let error as NSError {
                
                DispatchQueue.main.async() { () -> Void in
                    
                    displayAlert(viewp: self, title: "Error", userMessage: error.localizedDescription)
                }
                print(error)
            };
            
        }
        
        task.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goMemesList"{
            if let memeTableView = segue.destination as? MemeTableView{
                
                if let memes = sender as? NSArray{
                    memeTableView.memeList = memes
                }
                
            }
        }else if segue.identifier == "goDetailMeme"{
            if let detailMeme = segue.destination as? memeDetailViewController{
                
                if let m = sender as? meme {
                    
                    detailMeme.selectedMeme = m
                }
            }
        }
    }
    
    func selectRandomIndex(memesNumber:Int) -> Int{
        print(arc4random() )
        let n:Int = Int(arc4random_uniform(UInt32(memesNumber)))
        return n
        
    }
    
    func getMemes(){
        serviceGetMemes(isRandomMeme: false)
    }
    
    func selectRandomMeme(){
        serviceGetMemes(isRandomMeme: true)
    }

}

