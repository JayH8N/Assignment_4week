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
    var page = 1
    var isEnd = false
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
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
    
    func callRequest(query: String, page: Int) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)&size=30&page=\(page)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakakoBook.rawValue)"]
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    
                    self.isEnd = json["meta"]["is_end"].boolValue
                    
                    for item in json["documents"].arrayValue {
                        let title = item["title"].stringValue
                        let author = item["authors"][0].stringValue
                        let cover = item["thumbnail"].stringValue
                        
                        
                        let data = BookData(title: title, author: author, cover: cover)
                        self.bookList.append(data)
                    }
                    
                    self.collectionView.reloadData()
                    print(self.bookList)
                    
                } else {
                    print("문제가 발생했어요. 잠시 후 다시 시도해주세요!")
                }
                
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
        
        page = 1
        bookList.removeAll()
        
        guard let query = searchBar.text else { return }
        callRequest(query: query, page: page)
    }
}

extension BookwormViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if bookList.count - 1 == indexPath.row && page < 15 && !isEnd/*false라면*/ {
                page += 1
                callRequest(query: searchBar.text!, page: page)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("====취소: \(indexPaths)")
    }
    
}
