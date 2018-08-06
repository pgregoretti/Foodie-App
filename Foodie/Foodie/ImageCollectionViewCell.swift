//
//  ImageCollectionViewCell.swift
//  Foodie
//
//  Created by Pamelons on 11/21/16.
//  Copyright © 2016 Pam. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
