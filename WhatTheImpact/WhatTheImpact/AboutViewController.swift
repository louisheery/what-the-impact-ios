//
//  AboutViewController.swift
//  WhatTheImpact
//
//  Created by Louis on 31/07/2019.
//  Copyright © 2019 twoprime. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class AboutViewController: UIViewController  {

    @IBOutlet weak var dataProvidersLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        addWTILogo2()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 0/255, green: 153/255, blue: 222/255, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
        textChange()

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

    func textChange () {
        let stringOne = "Data provided by\n"
        let stringTwo = "Poore, J., and T. Nemecek. “Reducing Food’s Environmental Impacts through Producers and Consumers.” Science, vol. 360, no. 6392, Science, 2018, pp. 987–92.\n\n"
        let stringThree = "Food Icons and Images provided by\n"
        let stringFour = "The Noun Project (http://thenounproject.com)"
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        let originalString = NSMutableAttributedString(string:stringOne, attributes: attrs)
        var extraString = NSMutableAttributedString(string:stringTwo, attributes: attrs2)

        originalString.append(extraString)
        extraString = NSMutableAttributedString(string:stringThree, attributes: attrs)
        originalString.append(extraString)
        extraString = NSMutableAttributedString(string:stringFour, attributes: attrs2)
        originalString.append(extraString)
        dataProvidersLabel.attributedText = originalString
    }
}
