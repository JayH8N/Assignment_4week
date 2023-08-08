//
//  LottoViewController.swift
//  Assignment_4week
//
//  Created by hoon on 2023/08/08.
//

import UIKit
import SwiftyJSON
import Alamofire

class LottoViewController: UIViewController {

    
    
    
    @IBOutlet var numberLabel: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMain()
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1079"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func setMain() {
        numberLabel.layer.borderColor = UIColor.black.cgColor
        numberLabel.layer.borderWidth = 3
        numberLabel.layer.cornerRadius = 5
    }
    
    
    
    
    
    
    
}


extension UIViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        <#code#>
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        <#code#>
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        <#code#>
    }
    
    
}
