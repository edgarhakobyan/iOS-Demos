//
//  PhotoCollectionViewController.swift
//  PhotoTaps
//
//  Created by Edgar on 11.12.20.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    private let photos = ["dog1", "dog2", "dog3", "dog4", "dog5", "dog6", "dog7", "dog8", "dog9", "dog10"]
    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: 70, height: 70)
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//        layout.minimumLineSpacing = 1
//        layout.minimumInteritemSpacing = 1
//        layout.scrollDirection = .vertical
//        collectionView.showsVerticalScrollIndicator = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "photoSegue" else { return }
        let destinationVC = segue.destination as! PhotoViewController
        let cell = sender as! PhotoCell
        destinationVC.dogImage = cell.dogImageView.image
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        let photoName = photos[indexPath.item]
        let image = UIImage(named: photoName)
        
        cell.dogImageView.image = image
        
        return cell
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    // Item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    // Item margins
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    // Spacing between successive rows or columns of a section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

    // Spacing between successive items in the rows or columns of a section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
