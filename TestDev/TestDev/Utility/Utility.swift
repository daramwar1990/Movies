//
//  Utility.swift
//  TestDev
//
//  Created by Raghavendra Daramwar on 06/03/24.
//

import Foundation
import UIKit

class Utility {
    var shared : Utility = Utility()
    private init(){}
    
    //MARK: For downloading the image
    class func displayMoviePic(movie_pic_url: String?,activityIndicator: UIActivityIndicatorView,imageViewMoviePic: UIImageView,imageType: ImageTypes){
        
        var imageUrl : String?
        if imageType == .basePathForImageOriginal{
            Router.imageType = .basePathForImageOriginal
            imageUrl = Router.imageURL() + (movie_pic_url ?? "")
        }
        else {
            Router.imageType = .basePathForImagew500
            imageUrl = Router.imageURL() + (movie_pic_url ?? "")
        }
        
        DispatchQueue.global(qos: .background).async {
            
            if imageUrl != nil{
                
                DispatchQueue.main.async {
                    activityIndicator.isHidden = false
                    activityIndicator.startAnimating()
                }
                
                guard let imageUrl = URL(string: imageUrl!) else { return }
                if let data = try? Data(contentsOf: imageUrl){
                    let image = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        activityIndicator.stopAnimating()
                        activityIndicator.isHidden = true
                        imageViewMoviePic.image = image
                    }
                }else {
                    DispatchQueue.main.async {
                        activityIndicator.stopAnimating()
                        activityIndicator.isHidden = true
                        imageViewMoviePic.image = UIImage(systemName: "")
                    }
                }
            }
            
            else if imageUrl == nil || imageUrl == ""{
                
                DispatchQueue.main.async {
                    activityIndicator.isHidden = true
                    imageViewMoviePic.image = UIImage(systemName: "")
                }
                return
            }
        }
    }
}
