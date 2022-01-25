//
//  LaunchViewController.swift
//  xxx
//
//  Created by Burak Pala on 25.01.2022.
//
import Foundation
import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}




class LaunchViewController: UIViewController {
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var flightNumberLbl: UILabel!
    
    @IBOutlet weak var launchYearLbl: UILabel!
    
    @IBOutlet weak var detailLbl: UILabel!
    
    
    var launch:LaunchStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        launchYearLbl.text = launch?.launch_year
        flightNumberLbl.text = "Flight Number: \((launch?.flight_number)!)"
        detailLbl.text = launch?.details
        
        let urlString = ""+(launch?.links?.mission_patch)!
        let url = URL(string: urlString)
        
        imageView.downloaded(from: url!)
        
        //if let url = launch?.links?.mission_patch?.applyQueryParameters(params: ["width":120]).asURL() {
          //              imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "default_image"))
            //        }
              //      else {
                        //imageView.image = UIImage(named: "default_image")
                //    }
        
        

    }
    
    
   

}
/*extension String{
    public static func from(_ value:Any?) -> String? {
            if let nonNil = value, !(nonNil is NSNull) {
                return String(describing: nonNil)
            }
            return nil
        }
func applyQueryParameters(params: [String:Any]) -> String {
        var result = "(self)?"

        var index: Int = 0
        for (key, value) in params {
            if let value = String.from(value)?.addingPercentEncoding(withAllowedCharacters: .alphanumerics) {
                result = "(result)(key)=(value)"
            }

            if index < (params.count - 1) {
                result = "(result)&"
            }

            index += 1
        }
        return result
    }
func asURL() -> URL? {
        return URL(string: self)
    }

}
*/




