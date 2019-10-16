//
//  FirstViewController.swift
//  WhatTheImpact
//
//  Created by Louis on 05/07/2019.
//  Copyright © 2019 twoprime. All rights reserved.
//
// FirstViewController

import Foundation
import UIKit
import CoreData


// NOTE: This View Controller is Currently Redundent until Transport and Home Sections are Added to the App
class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!

    var collectionData = ["Food", "Transport", "Home"]

    let exploreImages: [UIImage] = [UIImage(named: "food")!, UIImage(named: "transport")!, UIImage(named: "home")!, UIImage(named: "lifestyle")!]

    var identities = ["A", "B", "C"]

    override func viewDidLoad() {
        super.viewDidLoad()
        addWTILogo2()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 0/255, green: 153/255, blue: 222/255, alpha: 1)

        let layout = UICollectionViewFlowLayout()
        let size = Int(self.collectionView.bounds.width * 0.2)
        let cellSize = CGSize(width: size, height: size)

        layout.itemSize = cellSize
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.reloadData()

        // Sets status bar color to black
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

    // Defines collection view style
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }

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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let item = indexPath[1]
        print(collectionData[item])

        let vcName = identities[item]
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)

    }

}
