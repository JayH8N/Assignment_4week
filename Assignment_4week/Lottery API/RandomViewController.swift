//
//  RandomViewController.swift
//  Assignment_4week
//
//  Created by hoon on 2023/08/08.
//

import UIKit

class RandomViewController: UIViewController {
    
    static let identifier = "RandomViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .systemPink
        getRandomColor1()
        
    }
    func getRandomColor1() {

        UIView.animate(withDuration: 1, delay: 0.0, options:[.repeat, .autoreverse], animations: {
            self.view.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        }, completion:nil)
    }
    

}
