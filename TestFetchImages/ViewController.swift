//
//  ViewController.swift
//  TestFetchImages
//
//  Created by Allen Savio on 2/10/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import UIKit

class Authentication {
    private init() {}
    static var shared = Authentication()
    var accessToken: String = ""
}

class ViewController: UIViewController   {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var toggleToList: Bool = true
    //    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        Request.login.execute().fetchJSON(success: { (json) in
//            print(json)
//            let dict = json.dictionary
//            Authentication.shared.accessToken = "Bearer " + (dict?["access_token"]?.stringValue  ?? "")
//            Request.getImages(of: "kitties").execute().fetchJSON(success: { (json) in
//                print(json)
//            }, failure: { (error) in
//                print(error)
//            })
//
//        }, failure: { (error) in
//            print(error)
//        })
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if toggleToList {
            return 1
        } else {
            return 2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if toggleToList {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
            cell.imageName.text = "Apple"
            cell.imageDetail.text = "Fruit"
            cell.imageView.image = UIImage(named: "images")
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
            cell.imageView.image = UIImage(named: "images")
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.size.width
        if toggleToList {
            return CGSize(width: screenWidth, height: 64)
        } else {
            return CGSize(width: screenWidth/2.5, height: screenWidth/2.5)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let imageController = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController else { return }
        imageController.index = indexPath.section
        self.present(imageController, animated: true) 
    }
    
}




