//
//  MemeTableView.swift
//  Imgflip
//
//  Created by Andres Granados on 11/7/17.
//  Copyright © 2017 AFGranadosC. All rights reserved.
//

import Foundation
import UIKit

class MemeTableView: UITableViewController {

    
    var memeList:NSArray = []
    var memeObjects:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadMemes()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memeObjects.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let m = memeObjects[indexPath.row] as! meme
        
        let memeCell = self.tableView.dequeueReusableCell(withIdentifier: "memeCell", for: indexPath) as! memeTableViewCell
        
        let urlString :String = NSString(string: m.url).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let url = NSURL(string: urlString)!
        
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { () -> Void in
                
                memeCell.memeImageView.image = UIImage(data: data as Data)
            }
        }
        memeCell.messageLabel.text = m.name
//        memeCell.imageView =
        
        return memeCell
    }
    
    func loadMemes(){
        let nMemes = self.memeList.count
        
        for i in 0..<nMemes {
            let Meme = meme(jsonDictionary: self.memeList.object(at: i) as! NSDictionary )
            print(Meme)
            
            memeObjects.add(Meme)
            print(memeObjects[i] as! meme)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let m = memeObjects[indexPath.row] as! meme
        
        return CGFloat(m.height)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goMemeDetail", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goMemeDetail"{
            if let row = sender as? Int{
                
                if let detailMeme = segue.destination as? memeDetailViewController{
                    
                    detailMeme.selectedMeme = memeObjects[row] as! meme
                }
            }
        }
    }
    
}












