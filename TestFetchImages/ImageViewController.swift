//
//  ImageViewController.swift
//  TestFetchImages
//
//  Created by Allen Savio on 2/14/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var arrImages: [String] = ["images", "images1", "images2", "images3"]
    var index: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        jumpToImage(at: index)
    }
    
    func jumpToImage(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageViewCell", for: indexPath) as? ImageViewCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.image = UIImage(named: arrImages[indexPath.item])
        cell.setup()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = UIImage(named: arrImages[indexPath.item])
        let imageToShare = [ image!]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash


        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
}
