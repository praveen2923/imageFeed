//
//  ImageView.swift
//  Image Feed
//
//  Created by praveen hiremath on 17/12/21.
//

import UIKit

class ImageView: UICollectionViewCell {
    
    static let cellIdentifier = "ImageView"
    static let xibName = "ImageView"
    
    
    @IBOutlet weak var imageFeed: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
