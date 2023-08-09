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
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var bookImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
}
