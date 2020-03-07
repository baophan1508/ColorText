//
//  ImageCollectionViewCell.swift
//  ColorText1
//
//  Created by MacBook Pro 15" on 2/27/20.
//  Copyright © 2020 MacBook Pro 15". All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var image: Image?
    
    func setImage(_ image: Image) {
        self.image = image
        imageView.image = UIImage(named: image.imageName)
    }
}
