//
//  BookwormViewController.swift
//  Assignment_4week
//
//  Created by hoon on 2023/08/09.
//

import UIKit
import SwiftyJSON
import Alamofire

class BookwormViewController: UIViewController {

    static let identifier = "BookwormViewController"
    
    var bookList: [BookData] = []
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func callRequest() {
        let url = "https://dapi.kakao.com/v3/search/book"
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
    
    func registerNib() {
        let nibName = UINib(nibName: BookwormCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: BookwormCollectionViewCell.identifier)
    }
    

}

extension BookwormViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
