//
//  CalculatorViewController.swift
//  WhatTheImpact
//
//  Created by Louis on 05/07/2019.
//  Copyright © 2019 twoprime. All rights reserved.
//

import Foundation
import UIKit
import CoreData


// NOTE: This View Controller is Currently Redundent until Transport and Home Sections are Added to the App
class CalculatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var foodPickerOne: UIPickerView!

    @IBOutlet weak var foodPickerTwo: UIPickerView!

    @IBOutlet weak var foodOutput: UILabel!

    @IBOutlet weak var calculateButton: UIButton!

    @IBOutlet weak var savetoDashButton: UIButton!

    var foodPickerOneData: [String] = [String]()
    var foodPickerTwoData: [String] = [String]()

    var foodItemSelected: Int = Int()
    var foodItemSelectedTwo: Int = Int()

    var yourImpactItemArray: [NSManagedObject] = []

    var yourImpactOutput: String = String()
    var yourImpactOutputOne: String = String()
    var yourImpactOutputTwo: String = String()
    var yourImpactOutputThree: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        addWTILogo2()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 72/255, green: 165/255, blue: 71/255, alpha: 1)

        self.savetoDashButton.isHidden = true

        // Connect data:
        self.foodPickerOne.delegate = self
        self.foodPickerOne.dataSource = self

        self.foodPickerTwo.delegate = self
        self.foodPickerTwo.dataSource = self

        foodPickerOneData = ["Apples", "Avocados", "Bananas", "Beans", "Beef", "Beer", "Berries and grapes", "Bread", "Cheese", "Chicken", "Chocolate (dark)", "Chocolate (milk)", "Oranges", "Coffee", "Eggs", "Fish (farmed)", "Lamb", "Milk (almond)", "Milk (dairy)", "Milk (oat)", "Milk (rice)", "Milk (soy)", "Nuts", "Oatmeal", "Pasta", "Peas", "Pork", "Potatoes", "Prawns (farmed)", "Rice", "Tea", "Tofu", "Tomatoes", "Wine"]

        foodPickerTwoData = ["1", "2", "3", "4", "5", "6", "7"]

        foodOutput.text = ""

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


    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1 {
            return 1
        } else {
            return 1
        }
    }

    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return foodPickerOneData.count
        } else {
            return foodPickerTwoData.count
        }

    }

    // Returns the required data for each row of pickerVFiew
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return foodPickerOneData[row]
        } else {
            return foodPickerTwoData[row]
        }

    }

    // Capture the picker view selection when user changes the picker selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView.tag == 1 {
            foodItemSelected = row

        } else {

            foodItemSelectedTwo = row

        }

    }

    // Food data
    @IBAction func foodButton1(_ sender: Any) {

        var foodCarbonValues = [[String]]()

        foodCarbonValues = [
            ["yearly CO2 (kg)", "CO2 (once a week), kg", "Water (once a week), litre"],
            ["Apples", "1.7", "749.3"],
            ["Avocados", "10.3", "2345.9"],
            ["Bananas", "3.6", "476.3"],
            ["Beans", "5.1", "1269.7"],
            ["Beef", "402.9", "0.0"],
            ["Beer", "34.7", "505.0"],
            ["Berries and grapes", "6.3", "1745.6"],
            ["Bread", "3.0", "1285.0"],
            ["Cheese", "50.3", "11814.7"],
            ["Chicken", "71.0", "4756.3"],
            ["Chocolate (dark)", "77.3", "1291.4"],
            ["Chocolate (milk)", "53.6", "3777.1"],
            ["Oranges", "1.6", "0.0"],
            ["Coffee", "22.1", "0.0"],
            ["Eggs", "28.9", "3587.1"],
            ["Fish (farmed)", "97.6", "26430.4"],
            ["Lamb", "226.0", "0.0"],
            ["Milk (almond)", "7.3", "3863.1"],
            ["Milk (dairy)", "32.7", "6533.3"],
            ["Milk (oat)", "9.3", "501.7"],
            ["Milk (rice)", "12.3", "2806.0"],
            ["Milk (soy)", "10.1", "0.0"],
            ["Nuts", "0.7", "6950.9"],
            ["Oatmeal", "5.4", "1071.9"],
            ["Pasta", "6.1", "2999.3"],
            ["Peas", "0.9", "0.0"],
            ["Pork", "93.7", "13679.4"],
            ["Potatoes", "2.3", "0.0"],
            ["Prawns (farmed)", "179.4", "23492.3"],
            ["Rice", "17.3", "8768.7"],
            ["Tea", "2.1", "0.0"],
            ["Tofu", "8.3", "391.1"],
            ["Tomatoes", "8.6", "1538.4"],
            ["Wine", "16.3", "718.0"]
        ]

        foodOutput.text = "Your consumption of \(foodCarbonValues[foodItemSelected + 1][0]) produces \n \(String(Int(Double(foodCarbonValues[foodItemSelected + 1][1])! * Double((foodItemSelectedTwo + 1))))) kg of CO2 \n and uses \(String(Int(Double(foodCarbonValues[foodItemSelected + 1][2])! * Double((foodItemSelectedTwo + 1))))) litres of Water per year."


        yourImpactOutput = "\(foodCarbonValues[foodItemSelected + 1][0]) | \(String(Int(Double(foodCarbonValues[foodItemSelected + 1][1])! * Double((foodItemSelectedTwo + 1))))) kg | \(String(Int(Double(foodCarbonValues[foodItemSelected + 1][2])! * Double((foodItemSelectedTwo + 1))))) L"

        yourImpactOutputOne = "\(foodCarbonValues[foodItemSelected + 1][0])"

        yourImpactOutputTwo = "\(String(Int(Double(foodCarbonValues[foodItemSelected + 1][1])! * Double((foodItemSelectedTwo + 1)))))"

        yourImpactOutputThree = "\(String(Int(Double(foodCarbonValues[foodItemSelected + 1][2])! * Double((foodItemSelectedTwo + 1)))))"

        self.savetoDashButton.isHidden = false

    }


    @IBAction func savetoDashButton(_ sender: Any) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "YourImpactStorage", in: managedContext)!
        let yourImpactItem = NSManagedObject(entity: entity, insertInto: managedContext)
        yourImpactItem.setValue(yourImpactOutputOne, forKeyPath: "name")
        yourImpactItem.setValue(yourImpactOutputTwo, forKeyPath: "co2")
        yourImpactItem.setValue(yourImpactOutputThree, forKeyPath: "water")
        //yourImpactItem.setValue(frequencyToSave, forKeyPath: "frequency")

        do {
            try managedContext.save()
            yourImpactItemArray.append(yourImpactItem)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }

}


@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
