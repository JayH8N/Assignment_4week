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

    @IBOutlet var lottoImage: UIImageView!
    @IBOutlet var numberLabel: UITextField!
    @IBOutlet var winnerNumber: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var bonusNumber: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var firstWinamnt: UILabel!
    
    
    let last = 1079
    var list: [Int] = Array(1...1079).reversed()
    
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setMain()
        heavenButton()
        callRequest(number: last)
        numberLabel.text = "\(last)회"
        
        numberLabel.inputView = pickerView //텍스트필드 누르면 피커뷰 뜬다.
        numberLabel.tintColor = .clear //텍스트필드 커서 깜빡거림
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//            setTitle()
//    }
    
    override func awakeAfter(using coder: NSCoder) -> Any? {
            navigationItem.backButtonDisplayMode = .minimal
            return super.awakeAfter(using: coder)
        }
    
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
    
    func setTitle() {
        self.title = "-----인 · 생 · 한 · 방-----"
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: getRandomColor()]
    }
    
    func heavenButton() {
        let heaven = UIImage(systemName: "wand.and.stars")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: heaven, style: .plain, target: self, action: #selector(heavenButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .systemPink
    }
    
    @objc
    func heavenButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Lottery", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: RandomViewController.identifier) as! RandomViewController
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //돈단위 함수
    func decimalWon(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))! + "원"
            
            return result
        }
    
    func getRandomColor() -> UIColor{
            
            let randomRed:CGFloat = CGFloat(drand48())
            
            let randomGreen:CGFloat = CGFloat(drand48())
            
            let randomBlue:CGFloat = CGFloat(drand48())
            
            return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
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
        let imageUrl = URL(string: "https://storage.cobak.co/uploads/1535087318434001_faa9ab3abf.jpeg")
        lottoImage.load(url: imageUrl!)
        lottoImage.contentMode = .scaleToFill
        
        
    }
    
    @IBAction func tapGeusture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
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
        numberLabel.text = "\(list[row])회"
        callRequest(number: list[row])
    }

    
    
    
    
}
