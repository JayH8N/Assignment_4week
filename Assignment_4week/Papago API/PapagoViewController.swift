//
//  PapagoViewController.swift
//  Assignment_4week
//
//  Created by hoon on 2023/08/10.
//

import UIKit

class PapagoViewController: UIViewController {
    
    
    @IBOutlet var sourceLan: UILabel!
    @IBOutlet var targetLan: UILabel!
    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var targetTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setMain()
        setButton(title: "번역하기", image: "arrowtriangle.down")
    }
    
    func setTitle() {
        self.title = "Papago 번역"
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.green]
    }

    func setMain() {
        sourceLan.font = .boldSystemFont(ofSize: 14)
        sourceLan.textAlignment = .center
        sourceLan.text = "Lan"
        sourceLan.backgroundColor = .white
        targetLan.font = .boldSystemFont(ofSize: 14)
        targetLan.textAlignment = .center
        targetLan.text = "Lan"
        targetLan.backgroundColor = .white
        sourceTextView.layer.cornerRadius = 10
        sourceTextView.layer.borderColor = UIColor.black.cgColor
        sourceTextView.layer.borderWidth = 3
        targetTextView.layer.cornerRadius = 10
        targetTextView.layer.borderColor = UIColor.black.cgColor
        targetTextView.layer.borderWidth = 3
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
    
    
}
