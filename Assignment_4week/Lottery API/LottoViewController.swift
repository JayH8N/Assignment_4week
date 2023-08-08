//
//  LottoViewController.swift
//  Assignment_4week
//
//  Created by hoon on 2023/08/08.
//

import UIKit
import SwiftyJSON
import Alamofire

class LottoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var numberLabel: UITextField!
    @IBOutlet var winnerNumber: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var bonusNumber: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var firstWinamnt: UILabel!
    
    
    
    var list: [Int] = Array(1...1066).reversed()
    
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMain()
        callRequest(number: 1066)
        numberLabel.inputView = pickerView //텍스트필드 누르면 피커뷰 뜬다.
        numberLabel.tintColor = .clear //텍스트필드 커서 깜빡거림
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//
//    }
    
    func callRequest(number: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //
                let date = json["drwNoDate"].stringValue
                //
                let bonusNumber = json["bnusNo"].intValue
                //
                let num1 = json["drwtNo1"]
                let num2 = json["drwtNo2"]
                let num3 = json["drwtNo3"]
                let num4 = json["drwtNo4"]
                let num5 = json["drwtNo5"]
                let num6 = json["drwtNo6"]
                //
                let firstWinamnt = json["firstWinamnt"].intValue
                
                self.winnerNumber.text = "\(num1)  \(num2)  \(num3)  \(num4)  \(num5)  \(num6)"
                self.dateLabel.text = date
                self.bonusNumber.text = "\(bonusNumber)"
                let money = self.decimalWon(value: firstWinamnt)
                self.firstWinamnt.text = "1등 당첨금 : \(money)"
                
                
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //돈단위 함수
    func decimalWon(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))! + "원"
            
            return result
        }
    
    func setMain() {
        numberLabel.layer.addBorder([.bottom], width: 3, color: UIColor.systemPink.cgColor)
        numberLabel.layer.cornerRadius = 5
        numberLabel.layer.borderColor = UIColor.systemPink.cgColor
        numberLabel.layer.borderWidth = 1
        numberLabel.font = UIFont.boldSystemFont(ofSize: 25)
        numberLabel.textAlignment = .center
        image.image = UIImage(systemName: "plus.circle.fill")
        image.tintColor = .systemPink
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        winnerNumber.layer.addBorder([.bottom], width: 1, color: UIColor.lightGray.cgColor)
        winnerNumber.textAlignment = .center
        bonusNumber.layer.borderWidth = 5
        bonusNumber.layer.cornerRadius = 10
        bonusNumber.layer.borderColor = UIColor.systemPink.cgColor
        bonusNumber.textAlignment = .center
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.boldSystemFont(ofSize: 14)
        firstWinamnt.textAlignment = .center
    }
    
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(list[row])"
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberLabel.text = "\(list[row])"
        callRequest(number: list[row])
    }

    
    
    
    
}
