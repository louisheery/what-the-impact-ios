//
//  FoodViewController.swift
//  WhatTheImpact
//
//  Created by Louis on 12/07/2019.
//  Copyright © 2019 twoprime. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FoodViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    @IBOutlet weak var collectionView: UICollectionView!

    // Defines items to be displayed in the CollectionView, and their corresponding images
    var collectionData = ["Fruit/Veg", "Meat/Fish", "Carbohydrates", "Dairy", "Other", "Drinks"]

    let exploreImages: [UIImage] = [UIImage(named: "diet")!, UIImage(named: "fish")!, UIImage(named: "Bread")!, UIImage(named: "Cheese")!, UIImage(named: "Nuts")!, UIImage(named: "soda")!]

    var identities = ["A1", "A2", "A3", "A4", "A5", "A6"]

    override func viewDidLoad() {
        super.viewDidLoad()
        addWTILogo2()
        // Do any additional setup after loading the view.
        self.title = "Food"
        self.view.backgroundColor = UIColor(red: 0/255, green: 153/255, blue: 222/255, alpha: 1)

        collectionView.delegate = self
        collectionView.dataSource = self

        // Defines size of collectionView relative to size of iPhone the user is running app on
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

        navigationController?.navigationBar.barStyle = .black


    // Set status bar colour to black
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

    // Number of items in collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }

    // Image and text displayed in each collectionView item
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

    // Defines action of displaying a different viewController when a particular CollectionView item is clicked on
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let item = indexPath[1]
        print(collectionData[item])

        let vcName = identities[item]
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)

    }

}

// Fixes transition between different Views of TabBarController
extension FoodViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MyTransition(viewControllers: tabBarController.viewControllers)
    }
}

// Fixes transition between different Views of TabBarController
class MyTransition: NSObject, UIViewControllerAnimatedTransitioning {

    let viewControllers: [UIViewController]?
    let transitionDuration: Double = 1

    init(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndex(forViewController: toVC)
            else {
                transitionContext.completeTransition(false)
                return
        }

        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart

        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: self.transitionDuration, animations: {
                fromView.frame = fromFrameEnd
                toView.frame = frame
            }, completion: {success in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
        }
    }

    func getIndex(forViewController vc: UIViewController) -> Int? {
        guard let vcs = self.viewControllers else { return nil }
        for (index, thisVC) in vcs.enumerated() {
            if thisVC == vc { return index }
        }
        return nil
    }
}
