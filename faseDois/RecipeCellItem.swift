//
//  RecipeCellItem.swift
//  zaffaripoc
//
//  Created by Companhia Zaffari on 28/08/2019.
//  Copyright © 2019 Companhia Zaffari. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

let cache = NSCache<NSString, ImageCache>()

class RecipeCellItem: UITableViewCell {
    
    @IBOutlet public weak var title: UILabel!
    
    @IBOutlet private var backgroundImage: UIImageView!
    
    @IBOutlet private weak var preparationTime: UILabel!
    
    @IBOutlet private var classification: UILabel!
    
    private var imageUrl: String?
    
    public func setTitle(_ title:String){
        self.title?.text = title
    }
    
    public func getTitle() -> String {
        return self.title!.text! 
    }
    
    public func setBackgroundImage(_ backgroundImage:URL){
        self.backgroundImage.setImage(UIImage(named: "Recipe")!, animationDuration: 0)
        self.backgroundImage.downloaded(from: backgroundImage, contentMode: .scaleAspectFill)
    }
    
    public func setPreparationTime(_ preparationTime:String){
        self.preparationTime.text = preparationTime
    }
    
    public func setClassification(_ classification:String){
        if classification == "1" {
            self.classification.text = "⭐︎"
            return;
        }
        if classification == "2" {
            self.classification.text = "⭐︎⭐︎"
            return;
        }
        if classification == "3" {
            self.classification.text = "⭐︎⭐︎⭐︎"
            return;
        }
        if classification == "4" {
            self.classification.text = "⭐︎⭐︎⭐︎⭐︎"
            return;
        }
        if classification == "5" {
            self.classification.text = "⭐︎⭐︎⭐︎⭐︎⭐︎"
            return;
        }
        self.classification.text = ""
    }
    
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        if let imageFromCache = cache.object(forKey: url.absoluteString as NSString)  {
            setImage(imageFromCache.image, animationDuration: 0, contentMode: mode)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            self.setImage(image, animationDuration: 0.5, contentMode: mode)
            let cacheImage = ImageCache()
            cacheImage.image = image
            cache.setObject(cacheImage, forKey: url.absoluteString as NSString)
        }.resume()
           
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    func setImage( _ image:UIImage, animationDuration: TimeInterval = 0 , contentMode mode: UIView.ContentMode = .scaleAspectFit){
        DispatchQueue.main.async() {
            CATransaction.begin()
            CATransaction.setAnimationDuration(animationDuration)
            
            let transition = CATransition()
            transition.type = CATransitionType.fade
            /*
             transition.type = kCATransitionPush
             transition.subtype = kCATransitionFromRight
             */
            self.layer.add(transition, forKey: kCATransition)
            self.image = image
            self.contentMode = mode
            
            CATransaction.commit()
        }
    }
    
   
}
