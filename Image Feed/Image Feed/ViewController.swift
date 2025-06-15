//
//  ViewController.swift
//  Image Feed
//
//  Created by praveen hiremath on 17/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var photoList : [ImageData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPhotoList()
    }
    
    func loadPhotoList()  {
        // Show Loading
        APIService.getPhotoList { result, error in
                // Dismiss Loading
            if error == nil {
                if let imageData = result as? [ImageData] {
                    self.photoList = imageData
                    DispatchQueue.main.async {
                        self.setupCollection()
                    }
                }else{
                    // Show Error Message
                }
            }else{
                // Show Error Mesage
            }
        }
    }
}

extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func setupCollection()  {
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.register(UINib(nibName: ImageView.xibName, bundle: nil), forCellWithReuseIdentifier: ImageView.cellIdentifier)
        let width = (view.frame.width-20)/3
        let layout = self.imageCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageView.xibName, for: indexPath) as? ImageView {
            cell.contentView.layer.cornerRadius = 20.0
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.masksToBounds = true
            let imageid =  self.photoList[indexPath.row].id ?? 0
            ImageLoader.shared.getImageWithPath(imageid) { (image) in
                if let updateCell = self.imageCollectionView.cellForItem(at: indexPath) as?  ImageView {
                    updateCell.imageFeed.image = image
                }
            }
            return cell
        }else{
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (view.frame.width - 20)/3
        return CGSize(width: width, height: width)
    }
    
    
}

