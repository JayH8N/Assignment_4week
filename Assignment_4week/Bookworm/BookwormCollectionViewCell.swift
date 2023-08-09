//
//  BookwormCollectionViewCell.swift
//  Assignment_4week
//
//  Created by hoon on 2023/08/09.
//

import UIKit

class BookwormCollectionViewCell: UICollectionViewCell {

    static let identifier = "BookwormCollectionViewCell"
    
    
    @IBOutlet var bookTitle: UILabel!
    @IBOutlet var bookAuthor: UILabel!
    @IBOutlet var bookImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellStyle()
        
    }
    
    func setCellStyle() {
        bookTitle.font = .boldSystemFont(ofSize: 15)
        bookTitle.layer.addBorder([.bottom], width: 0.3, color: UIColor.black.cgColor)
        bookAuthor.font = .systemFont(ofSize: 10)
        bookAuthor.layer.addBorder([.bottom], width: 0.3, color: UIColor.black.cgColor)
        bookImage.layer.cornerRadius = 10
        bookImage.layer.shadowColor = UIColor.black.cgColor   //그림자 색깔
        bookImage.layer.shadowOffset = CGSize(width: 0, height: 0)  //태양이 보는 시점
        bookImage.layer.shadowRadius = 10  //그림자 코너깎임정도
        bookImage.layer.shadowOpacity = 0.5   //그림자 투명도


        //기본적으로 UIView의 clipsToBounds의 default값은 false다.
        bookImage.clipsToBounds = true //false면 View가 깍이지 않게되고 true면 깍인다.
    }
    
}
