//
//  Extensions.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 01/02/2025.
//
import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        let strUniqueIdentifier_Initial = urlString
        self.accessibilityLabel = strUniqueIdentifier_Initial
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            let strUniqueIdentifier_Current = self.accessibilityLabel
            if strUniqueIdentifier_Initial != strUniqueIdentifier_Current {
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    DispatchQueue.main.async {
                        self.image = downloadedImage
                    }
                }
            })
        }).resume()
    }
}

extension Data {
    public func convertToJson() -> [String : Any]?{
        let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [String : Any]
        return json
    }
    
    public func convertToJsonArray() -> [[String : Any]]?{
        let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [[String : Any]]
        return json
    }
    
    public func convertTo<T: Decodable>(to: T.Type) -> T?{
        let decoder = JSONDecoder()
        return  try? decoder.decode(to.self, from: self)
    }
}

extension UIImageView {
    func imageViewLoading(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let activityIndicator = self.activityIndicator
        DispatchQueue.main.async {
            activityIndicator.startAnimating()
        }
        let strUniqueIdentifier_Initial = urlString
        self.accessibilityLabel = strUniqueIdentifier_Initial
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            DispatchQueue.main.async {
                self.image = cachedImage
                activityIndicator.stopAnimating()
            }
            return
        }        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            let strUniqueIdentifier_Current = self.accessibilityLabel
            if strUniqueIdentifier_Initial != strUniqueIdentifier_Current {
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    DispatchQueue.main.async {
                        self.image = downloadedImage
                        activityIndicator.stopAnimating()
                    }
                }
            })
        }).resume()
    }

    private var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        self.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        let centerX = NSLayoutConstraint(item: self,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        let centerY = NSLayoutConstraint(item: self,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        self.addConstraints([centerX, centerY])
        return activityIndicator
    }

}
