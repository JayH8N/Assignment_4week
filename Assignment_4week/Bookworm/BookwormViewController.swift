//
//  BookwormViewController.swift
//  Assignment_4week
//
//  Created by hoon on 2023/08/09.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher

class BookwormViewController: UIViewController {

    static let identifier = "BookwormViewController"
    
    var bookList: [BookData] = []
    
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        //callRequest(query: "아이유")
        configureCollectionViewlayout()
        searchBar.delegate = self
    }
    
    func configureCollectionViewlayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical  //.horizontal: 수평, .vertical: 수직
        layout.itemSize = CGSize(width: 120, height: 160) // 셀사이즈
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10) // CollectionView의 상하좌우 여백
        layout.minimumLineSpacing = 20

        collectionView.collectionViewLayout = layout
    }
    
    func callRequest(query: String) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakakoBook.rawValue)"]
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                
                for item in json["documents"].arrayValue {
                    let title = item["title"].stringValue
                    let author = item["authors"][0].stringValue
                    let cover = item["thumbnail"].stringValue
                    
                    
                    let data = BookData(title: title, author: author, cover: cover)
                    self.bookList.append(data)
                }
                
                print(self.bookList)
                
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookwormCollectionViewCell.identifier, for: indexPath) as? BookwormCollectionViewCell else { return UICollectionViewCell()}
        
        cell.backgroundColor = .lightGray
        cell.bookTitle.text = bookList[indexPath.item].title
        cell.bookAuthor.text = bookList[indexPath.item].author
        if let url = URL(string: bookList[indexPath.item].cover) {
            cell.bookImage.kf.setImage(with: url)
        }
        return cell
    }


}

extension BookwormViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //page = 1 //검색시 마다 page를 1로 초기화 해야된다., 새로운 검색어이기 때문에 page를 1로 변경
        bookList.removeAll()
        
        guard let query = searchBar.text else { return }
        callRequest(query: query)
    }
}
