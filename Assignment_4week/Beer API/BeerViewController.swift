//
//  BeerViewController.swift
//  Assignment_4week
//
//  Created by hoon on 2023/08/08.
//

import UIKit
import SwiftyJSON
import Alamofire

class BeerViewController: UIViewController {

    @IBOutlet var centerTitle: UILabel!
    @IBOutlet var beerImage: UIImageView!
    @IBOutlet var beerTitle: UILabel!
    @IBOutlet var beerInfo: UITextView!
    @IBOutlet var randomButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    setMain()
    callRequest()
        setButton()
    }
    
    
    func setMain() {
        centerTitle.textAlignment = .center
        centerTitle.font = UIFont.boldSystemFont(ofSize: 40)
        centerTitle.text = "오늘의 맥주 추천"
        centerTitle.layer.addBorder([.bottom], width: 4, color: UIColor.red.cgColor)
        centerTitle.layer.addBorder([.top], width: 4, color: UIColor.yellow.cgColor)
        centerTitle.layer.addBorder([.left], width: 4, color: UIColor.orange.cgColor)
        centerTitle.layer.addBorder([.right], width: 4, color: UIColor.green.cgColor)
        centerTitle.layer.cornerRadius = 5
        beerTitle.layer.addBorder([.bottom], width: 3, color: UIColor.black.cgColor)
        beerTitle.textAlignment = .center
        beerTitle.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func setButton() {
        randomButton.setTitle("다른 맥주 추천", for: .normal)
        randomButton.layer.borderColor = UIColor.orange.cgColor
        randomButton.layer.borderWidth = 1
        randomButton.layer.cornerRadius = 10
        randomButton.setImage(UIImage(systemName: "n.square"), for: .normal)
        randomButton.backgroundColor = .clear
        randomButton.tintColor = .orange
    }
    
    func callRequest() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let image = json[0]["image_url"].stringValue
                let title = json[0]["name"].stringValue
                let overView = json[0]["description"].stringValue
                

                let imageUrl = URL(string: image)
                guard let imageUrl else  { return }
                self.beerImage.load(url: imageUrl)
                self.beerTitle.text = title
                self.beerInfo.text = overView
                
            case .failure(let error):
                print(error)
            }
        }
    }

    
    
    
    @IBAction func randomButtonClicked(_ sender: UIButton) {
        callRequest()
    }
    
    
    

}
