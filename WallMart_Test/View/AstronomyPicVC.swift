//
//  AstronomyPicVC.swift
//  WallMart_Test
//
//  Created on 19/06/21.
//

import UIKit

class AstronomyPicVC: UIViewController {

    @IBOutlet var titleLbl : UILabel!
    @IBOutlet var explanationLbl : UILabel!
    @IBOutlet var dayPicImagView : UIImageView!
    
    
    var  viewModel: AstronomyPicViewModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initBinding()

        // Do any additional setup after loading the view.
    }
    func initBinding() {
        self.viewModel = AstronomyPicViewModel()

     
        viewModel?.astronomyPicofDay?.addObserver { [unowned self] (data) in
            titleLbl.text = viewModel?.astronomyPicofDay?.value.title
            explanationLbl.text = viewModel?.astronomyPicofDay?.value.explanation
            if let imageurl = viewModel?.astronomyPicofDay?.value.imageUrl
            {
            viewModel?.DownloadImage(urlString: imageurl, completion: { (downloadimage) in
                DispatchQueue.main.async {
                    if let image = downloadimage as? UIImage
               {
                    self.dayPicImagView.image = image
                  }
                    
                }
            })
            }
            
        }
        viewModel?.showAlert?.addObserver { [unowned self] (Alert) in
            
  
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Alert", message: Alert ?? "" , preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        

                
            }

        }
    }
    func getDateFormate( date : String)
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

       
    }
    func getDateAndTimeFormate( date : String)
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-yyyy HH:mm:ss"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "E, d MMM yyyy HH:mm:ss Z"

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
