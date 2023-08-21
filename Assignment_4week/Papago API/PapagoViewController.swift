//
//  PapagoViewController.swift
//  Assignment_4week
//
//  Created by hoon on 2023/08/10.
//

import UIKit
import SwiftyJSON
import Alamofire

class PapagoViewController: UIViewController {
    
    let sources = ["언어", "ko", "en", "ja", "zh-CN", "zh-TW", "vi", "id", "th", "de", "ru", "es", "it", "fr"]
    var targets = ["언어", "en", "ja", "zh-CN", "zh-TW", "vi", "id", "th", "de", "ru", "es", "it", "fr", "ko"]
    var source = ""
    var target = ""
    
    
    @IBOutlet var sourceLan: UITextField!
    @IBOutlet var targetLan: UITextField!
    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var targetTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPickerView()
        setTitle()
        setMain()
        setButton(title: "번역하기", image: "arrowtriangle.down")
    }
    
    func setPickerView() {
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView2.delegate = self
        pickerView2.dataSource = self
        sourceLan.inputView = pickerView1 //텍스트필드를 누르면 피커뷰가 나온다.
        sourceLan.tintColor = .clear //텍스트필드 커서 깜빡거림
        targetLan.inputView = pickerView2
        targetLan.tintColor = .clear
    }
    
    func setTitle() {
        self.title = "Papago 번역"
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.green]
    }

    func setMain() {
        sourceLan.font = .boldSystemFont(ofSize: 15)
        sourceLan.textAlignment = .center
        sourceLan.borderStyle = .none
        sourceLan.text = "선택해주세요"
        sourceLan.backgroundColor = .white
        sourceLan.textColor = .blue
        targetLan.font = .boldSystemFont(ofSize: 15)
        targetLan.textAlignment = .center
        targetLan.borderStyle = .none
        targetLan.text = "선택해주세요"
        targetLan.backgroundColor = .white
        targetLan.textColor = .blue
        sourceTextView.layer.cornerRadius = 10
        sourceTextView.layer.borderColor = UIColor.black.cgColor
        sourceTextView.layer.borderWidth = 3
        sourceTextView.font = .boldSystemFont(ofSize: 20)
        sourceTextView.textAlignment = .center
        targetTextView.layer.cornerRadius = 10
        targetTextView.layer.borderColor = UIColor.black.cgColor
        targetTextView.layer.borderWidth = 3
        targetTextView.font = .boldSystemFont(ofSize: 20)
        targetTextView.textAlignment = .center
    }
    
    func setButton(title: String, image: String) {
        translateButton.setTitle(title, for: .normal)
        translateButton.layer.borderColor = UIColor.green.cgColor
        translateButton.layer.borderWidth = 3
        translateButton.layer.cornerRadius = 10
        translateButton.setImage(UIImage(systemName: image ), for: .normal)
        translateButton.backgroundColor = .black
        translateButton.tintColor = .green
        translateButton.setTitleColor(.green, for: .normal)
    }
    
    func lan(title: String) -> String {
        switch title {
        case "en": return "영어"
        case "ja": return "일본어"
        case "zh-CN": return "중국어간체"
        case "zh-TW": return "중국어번체"
        case "vi": return "베트남어"
        case "id": return "인도네시아어"
        case "th": return "태국어"
        case "de": return "독일어"
        case "ru": return "러시아어"
        case "es": return "스페인어"
        case "it": return "이탈리아어"
        case "fr": return "프랑스어"
        case "ko": return "한국어"
        default: return "언어"
        }
    }
    
    func showAlertView(title: String, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .cancel, handler: handler)

        alert.addAction(ok)

        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func translateButtonClicked(_ sender: UIButton) {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverClientID.rawValue,
            "X-Naver-Client-Secret": APIKey.naverClientSecret.rawValue
        ]
        let parameters: Parameters = [
            "source": source,
            "target": target,
            "text": sourceTextView.text ?? ""
        ]
        AF.request(url, method: .post, parameters: parameters  ,headers: headers).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    let data = json["message"]["result"]["translatedText"].stringValue
                    self.targetTextView.text = data
                } else {
                    self.showAlertView(title: "처리하지 못했습니다.")
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}






extension PapagoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == pickerView1 {
            return sources.count
        } else {
            return targets.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title: String?
        if pickerView == pickerView1 {
            title = sources[row]
        } else if pickerView == pickerView2 {
            title = targets[row]
        }
        return lan(title: title!)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var title: String?
        if pickerView == pickerView1 {
            title = sources[row]
            sourceLan.text = lan(title: title!)
            source = sources[row]
        } else if pickerView == pickerView2 {
            title = targets[row]
            targetLan.text = lan(title: title!)
            target = targets[row]
        }
    }


}
