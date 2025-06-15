//
//  APIService.swift
//  Image Feed
//
//  Created by praveen hiremath on 17/12/21.
//

import Foundation

typealias CompletionHandler = (_ error: Any?, _ result: Any?) -> Void

struct ImageData : Decodable {
    var format : String?
    var width : Int?
    var height : Int?
    var filename : String?
    var id : Int?
    var author : String?
    var author_url : String?
    var post_url: String?
}

class APIService {
    
    class func getPhotoList(completion: @escaping CompletionHandler) {
        
        let urlString = "https://picsum.photos/list"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                if let dataObject = data {
                    do {
                        let photoList = try JSONDecoder().decode([ImageData].self, from: dataObject)
                        completion(photoList, nil)
                    }catch{
                        let error = NSError(domain: "Parse Error", code: 1006, userInfo: nil)
                       completion(nil, error)
                    }
                }else{
                    let error = NSError(domain: "Data Not Found", code: 1007, userInfo: nil)
                    completion(nil, error)
                }
            }else{
                completion(nil, error)
            }
        }.resume()
        
    }
}


