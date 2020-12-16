//
//  GalleryCollectionViewCell.swift
//  FinalProject
//
//  Created by nagato on 12/15/20.
//  Copyright © 2020 nagato. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColorView.layer.cornerRadius = 10.0
        backgroundColorView.layer.masksToBounds = true
        posterImageView.layer.cornerRadius = 10.0
        posterImageView.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 19
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        self.clipsToBounds = false
    }
}
