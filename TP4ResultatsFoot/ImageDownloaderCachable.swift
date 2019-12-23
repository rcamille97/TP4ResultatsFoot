//
//  ImageDownloaderCachable.swift
//  TP4ResultatsFoot
//
//  Created by Camille on 22/12/2019.
//  Copyright © 2019 Camille Rubio. All rights reserved.
//


//Extension de UIImageView afin de télécharger les images de façon asynchrone, permet de gérer le cache et les erreurs de logo
//Tiré de: https://github.com/jamesrochabrun/JSONTutorialFinal/tree/master/JSONTutorialFinal
import Foundation
import UIKit

//1 Create the protocol
protocol Cachable {}

//2 creating a imageCache private instance
private  let imageCache = NSCache<NSString, UIImage>()

//3 UIImageview conforms to Cachable
extension UIImageView: Cachable {}

//4 creating a protocol extension to add optional function implementations,
extension Cachable where Self: UIImageView {
    
    //5 creating the function
    typealias SuccessCompletion = (Bool) -> ()
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?, completion: @escaping SuccessCompletion) {
        
        //Gestion du cache
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            DispatchQueue.main.async {
                self.image = cachedImage
                completion(true)
            }
            return
        }
        self.image = placeHolder
        
        //Téléchargement de l'image à partir de l'url, une image par défaut est mise si le lien est inaccessible
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                if httpResponse.statusCode == 200 {
                    
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            DispatchQueue.main.async {
                                self.image = downloadedImage
                                completion(true)
                            }
                        }
                    }
                } else {
                    self.image = placeHolder
                }
            }).resume()
        } else {
            self.image = placeHolder
        }
    }
}


