//
//  AppDelegate.swift
//  WhatTheImpact
//
//  Created by Louis on 05/07/2019.
//  Copyright © 2019 twoprime. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().backgroundColor = UIColor.black
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes  = [NSAttributedString.Key.foregroundColor:UIColor.white]

        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)


        // Only way to add an Image to ALL the Navigation bars and stop the flashing image
        // is to use a BackgroundImage for the Navigation bar which is black but includes
        // the globe WTI logo on it
        // tutorial: https://developer.apple.com/documentation/uikit/uinavigationbar/1624968-setbackgroundimage
        return true
    }


    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        self.saveContext() // COREDATA
        self.saveContext2() // COREDATA
    }

    // Core Data Storage 1
    lazy var persistentContainer: NSPersistentContainer = {
        // The persistent container for the application.
        let container = NSPersistentContainer(name: "Storage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


    // Core Data Storage: Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


    // Core Data Storage 2
    lazy var persistentContainer2: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Storage2")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


    // Core Data Storage: Saving support
    func saveContext2 () {
        let context = persistentContainer2.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// Adds the WhatTheImpact Logo to the top of All View Controllers
extension UIViewController {
    func addWTILogo() {
        let logo = UIImage(named: "icon_NoBgkd")
        let screenWidth = self.view.frame.size.width
        let container = UIView(frame: CGRect(x: 0, y: -100, width: 182, height: 70))
        container.backgroundColor = UIColor.clear

        let imageView = UIImageView(frame:  CGRect(x: screenWidth/2 - 50, y: 38, width: 182, height: 45))
        imageView.contentMode = .scaleAspectFit
        imageView.image = logo

        container.addSubview(imageView)

        self.navigationItem.titleView = container
    }

    func addWTILogo2() {
        let titleLbl = UILabel()
        titleLbl.text = ""
        titleLbl.textColor = UIColor.white
        titleLbl.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        let imageView = UIImageView(image: UIImage(named: "icon_NoBgkd")!)
        imageView.contentMode = .scaleAspectFit
        imageView.semanticContentAttribute = .forceRightToLeft

        let titleView = UIStackView(arrangedSubviews: [titleLbl, imageView])
        titleView.axis = .horizontal
        //titleView.semanticContentAttribute = .right
        titleView.spacing = 10.0
        navigationItem.titleView = titleView
    }
}

// Adds ability to add Hex colours to GUI
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

// Adds ability to round numbers to a certain number of decimal places
extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
