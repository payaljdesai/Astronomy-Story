//
//  AstronomyApiCall.swift
//  WallMart_Test
//
//  Created on 19/06/21.
//

import Foundation
import UIKit

// ApiKey for get request
let aPiKey  =  "IqVQeTRTSf7JJabixKbwhirUwDHFehVjFq02cIhB"

class AstronomyApiCall {

    
    // Download Data From Api Using Session
class func getDataFromAPI(with completionHandler: @escaping (_ data : [String : String]) -> ()) {
   
   
   let urlString = "https://api.nasa.gov/planetary/apod?api_key=\(aPiKey)"
   let url = URL(string: urlString)
   guard let unwrappedURL = url else {return}
   // Cerate object of URLSession
   let session = URLSession.shared
    //StartTask for Downloading
   let task = session.dataTask(with: unwrappedURL) { (data, response, error) in
       
       guard let downloadeddata = data else {return}
       
       do {
          // convert Data to Dict using JSONSerialization
          if let responseJSON = try JSONSerialization.jsonObject(with: downloadeddata, options: []) as? [String : String]
          {
           completionHandler(responseJSON)

          }

           
       } catch {
   // Print Error
           print(error)
           
       }
       
   }
   task.resume()
   
}
    
    class func downloadImageFromURL(at urlString: String, completion: @escaping (Bool, UIImage?) -> ()) {
         
        // let urlString "
         let url = URL(string: urlString)
         guard let imageURL = url else {return}
     
         let request = URLRequest(url: imageURL)
         
         let session = URLSession.shared
         
         let task = session.dataTask(with: request) { data, response, error in
             
             guard let data = data, let image = UIImage(data: data) else { completion(false, nil); return }
     
            completion(true, image)
         
         }
         task.resume()
     }
    
}
