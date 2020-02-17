//
//  ImageViewCollectionViewCell.swift
//  TestFetchImages
//
//  Created by Allen Savio on 2/14/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import UIKit

class ImageViewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func setup() {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(sender:)))
        imageView.addGestureRecognizer(pinch)
    }
    
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            let currentScale = self.imageView.frame.size.width / self.imageView.bounds.size.width
            let newScale = currentScale*sender.scale
            let transform = CGAffineTransform(scaleX: newScale, y: newScale)
            self.imageView.transform = transform
            sender.scale = 1
        }
    }
}
