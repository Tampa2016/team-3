//
//  ExploreViewController.swift
//  Code_For_Good
//
//  Created by Nicholas Miller on 2/5/16.
//  Copyright © 2016 team3. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var categoryNames: [String] = ["Emergency", "Food", "Hotels", "Transportation", "Entertainment", "Beach", "Park", "Music", "Art", "other"]
    
    var categoryImages: [UIImage] = [UIImage(named: "ic_local_hospital")!, UIImage(named: "ic_restaurant_menu")!, UIImage(named: "ic_hotel")!, UIImage(named: "ic_directions_subway")!, UIImage(named: "ic_videogame_asset")!, UIImage(named: "ic_beach_access")!, UIImage(named: "ic_insert_photo")!, UIImage(named: "ic_audiotrack")!, UIImage(named: "ic_toys")!, UIImage(named: "ic_whatshot")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        flowLayout.scrollDirection = .Vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 8, 10, 8)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryNames.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ExploreCollectionViewCell", forIndexPath: indexPath) as! ExploreCollectionViewCell
        
        cell.categoryNameLabel.text = categoryNames[indexPath.row]
        cell.categoryImageView.image = categoryImages[indexPath.row]
        
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let totalwidth = collectionView.bounds.size.width;
//        let numberOfCellsPerRow = 3
//        let dimensions = CGFloat(Int(totalwidth) / numberOfCellsPerRow)
//        return CGSizeMake(dimensions, dimensions)
//    }

}
