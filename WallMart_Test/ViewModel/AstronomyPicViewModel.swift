//
//  AstronomyPicViewModel.swift
//  WallMart_Test
//
//  Created on 19/06/21.
//

import Foundation
import UIKit
class AstronomyPicViewModel {
    
    var AstronomyImageUrl : Observable<String>?
    var isDownloaded = Observable<Bool>(value: false)
    var astronomyPicofDay : Observable<PicOfDayData>?
    var  astronomyImage : Observable<UIImage>?
    var  showAlert : Observable<String>?

    var  astronomyCDAllOpration = AstronomyCDAllOpration()

    
    init()
    {
        self.getData()
    }
    func getData()
    {
        guard let  PicData = astronomyCDAllOpration.retrieveData() as? PicOfDayData else {
        
            self.DownloadData()
            return
        }
 
            print(Date.getCurrentDate())

            
                PicData.lastSeenDateAndTime = Date.getCurrentDateAndTime()
                
                astronomyPicofDay = Observable<PicOfDayData>(value: PicData)

                astronomyCDAllOpration.updateData(dateandtime : PicData.lastSeenDateAndTime!)
                
//                if let imageurl =  self.astronomyPicofDay?.value.imageUrl
//                {
//                DownloadImage(urlString: imageurl)
//                }
                
        
        
    }
  
    func DownloadData()
    {
        
        if(Reachability.isConnectedToNetwork())
        {
        AstronomyApiCall.getDataFromAPI { (data) in
            
            if var unwrappedData = data as? [String :String ]
            {
                DispatchQueue.main.async {
                    
                    self.astronomyCDAllOpration.deleteData()
                   if let output =   self.astronomyCDAllOpration.InsertData(data: unwrappedData) as? PicOfDayData
                   {
                    self.astronomyPicofDay?.value = output
                    
                    
                    
                   }
                }
                
            }
                    }
        }
        else
        {
            
            guard let  PicData = astronomyCDAllOpration.retrieveOldData() as? PicOfDayData else {
                showAlert = Observable<String>(value:  "We are not connected to the internet")
                    return
                }
                
                PicData.lastSeenDateAndTime = Date.getCurrentDateAndTime()
                astronomyPicofDay = Observable<PicOfDayData>(value: PicData)
                astronomyCDAllOpration.updateData(dateandtime : PicData.lastSeenDateAndTime!)
              showAlert = Observable<String>(value:  "We are not connected to the internet, showing you the last image we have.")

        }

       
        
       
    }
    
    func DownloadImage( urlString : String ,completion: @escaping( UIImage?) -> () )
   {
        if(Reachability.isConnectedToNetwork())
        {
        AstronomyApiCall.downloadImageFromURL(at: urlString) { (downloaded, image) in
                if let unwarppedimage = image
            {
                    self.saveImageInDocumentDirectory(image: unwarppedimage)
                    completion(unwarppedimage)
                   
                }
                completion(nil)
            }
        }
        else{
            
       
            if let image = self.getImageInDocumentDirectory() as? UIImage
                {

                   completion(image)

                }
            
        }
            
        
   }
    func saveImageInDocumentDirectory( image : UIImage)
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
                let imagePath = paths.appending("/Astronomy.jpg")
                
                if (FileManager.default.fileExists(atPath: imagePath))
                {
                    //remove file as its already existed
                    try!  FileManager.default.removeItem(atPath: imagePath)
                }
                else
                {
                    //write file as its not available
                    let imageData =  image.jpegData(compressionQuality: 1.0)
                    try! imageData?.write(to: URL.init(fileURLWithPath: imagePath), options: .atomicWrite)
                    
                }
    }
    func getImageInDocumentDirectory() -> Any
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
                let imagePath = paths.appending("/Astronomy.jpg")
                
                if (FileManager.default.fileExists(atPath: imagePath))
                {
                    if let Astronomyimage = UIImage(contentsOfFile: imagePath) as? UIImage
                    {
                      return Astronomyimage
                    }
                    //remove file as its already existed
                }
        
                return false
    }
}


