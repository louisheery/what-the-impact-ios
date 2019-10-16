//
//  CompareFoodViewController.swift
//  WhatTheImpact
//
//  Created by Louis on 12/07/2019.
//  Copyright © 2019 twoprime. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CompareFoodViewController: UIViewController  {

    @IBOutlet weak var collectionView: UICollectionView!

    var collectionData = ["Fruit/Veg", "Meat/Fish", "Carbohydrates", "Dairy", "Other", "Drinks"]

    let exploreImages: [UIImage] = [UIImage(named: "diet")!, UIImage(named: "fish")!, UIImage(named: "Bread")!, UIImage(named: "Cheese")!, UIImage(named: "Nuts")!, UIImage(named: "soda")!]

    var identities = ["CompareA1", "CompareA2", "CompareA3", "CompareA4", "CompareA5", "CompareA6"]

    override func viewDidLoad() {
        super.viewDidLoad()
        addWTILogo2()

        self.title = "Food"
        self.view.backgroundColor = UIColor(red: 0/255, green: 153/255, blue: 222/255, alpha: 1)

        collectionView.delegate = self
        collectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()

        let screenSize = UIScreen.main.bounds
        let size = (screenSize.width - 26 - 26) * 0.47
        let sizeHeight = (screenSize.height - 250) * 0.3

        let cellSize = CGSize(width: size, height: min(sizeHeight, size))

        layout.itemSize = cellSize

        let totalCellWidth = size * 2
        let totalSpacingWidth = (screenSize.width - 26 - 26) * 0.03 * (2 - 1)

        let leftInset = ((screenSize.width - 26 - 26) - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        layout.sectionInset = UIEdgeInsets(top: 1, left: leftInset, bottom: 1, right: rightInset)
        layout.minimumLineSpacing = (screenSize.width - 26 - 26) * 0.03
        layout.minimumInteritemSpacing = (screenSize.width - 26 - 26) * 0.03
        collectionView.setCollectionViewLayout(layout, animated: false)

    // Sets status bar colour to black
    if #available(iOS 13.0, *) {
                let app = UIApplication.shared
                let statusBarHeight: CGFloat = app.statusBarFrame.size.height

                let statusbarView = UIView()
                statusbarView.backgroundColor = UIColor.black
                view.addSubview(statusbarView)

                statusbarView.translatesAutoresizingMaskIntoConstraints = false
                statusbarView.heightAnchor
                    .constraint(equalToConstant: statusBarHeight).isActive = true
                statusbarView.widthAnchor
                    .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
                statusbarView.topAnchor
                    .constraint(equalTo: view.topAnchor).isActive = true
                statusbarView.centerXAnchor
                    .constraint(equalTo: view.centerXAnchor).isActive = true

            } else {
                let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                statusBar?.backgroundColor = UIColor.black
            }

        }

        override var preferredStatusBarStyle : UIStatusBarStyle {
            return UIStatusBarStyle.lightContent

        }

}

// Defines attributes of custom CollectionView
extension CompareFoodViewController: UICollectionViewDelegate, UICollectionViewDataSource {

   // Number of items in the CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }

    // Images and Text displayed in each collection view item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        cell.layer.cornerRadius = 20

        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = collectionData[indexPath.row]
        }

        if let photo = cell.viewWithTag(101) as? UIImageView {
            photo.image = exploreImages[indexPath.row]
        }

        return cell
    }

    // Defines ViewController to load when a collectionView item is selected by user
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let item = indexPath[1]
        print(collectionData[item])

        let vcName = identities[item]
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)

    }

}
