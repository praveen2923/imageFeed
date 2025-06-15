//
//  ImageLoader.swift
//  Image Feed
//
//  Created by praveen hiremath on 17/12/21.
//

import Foundation
import UIKit

typealias ImageHandler = ((UIImage) -> ())

class ImageLoader {
    static let shared = ImageLoader()
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<NSString, UIImage> = NSCache()
    
    init() {
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.cache = NSCache()
    }
    
    func getImageWithPath(_ imageid: Int, completionHandler: @escaping ImageHandler) {
        let imagePath = "https://picsum.photos/200/300?image=\(imageid)"
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            let placeholder = UIImage()
            DispatchQueue.main.async {
                completionHandler(placeholder)
            }
            let url: URL! = URL(string: imagePath)
            task = session.downloadTask(with: url, completionHandler: { (location, response, error) in
                if let data = try? Data(contentsOf: url) {
                    let img: UIImage! = UIImage(data: data)
                    self.cache.setObject(img, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(img)
                    }
                }
            })
            task.resume()
        }
    }
}
