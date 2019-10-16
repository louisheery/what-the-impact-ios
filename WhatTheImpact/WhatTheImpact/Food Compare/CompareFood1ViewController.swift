//
//  CompareFood1ViewController.swift
//  WhatTheImpact
//
//  Created by Louis on 13/07/2019.
//  Copyright © 2019 twoprime. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CompareFood1ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var foodPickerLabelOne: UILabel!
    @IBOutlet weak var foodPickerLabelTwo: UILabel!


    @IBOutlet weak var foodPickerLabelPortion: UILabel!
    @IBOutlet weak var portionSlider: UISlider!
    @IBOutlet weak var saveToDashboardButton: UIButton!
    @IBOutlet weak var foodPickerOne: UIPickerView!
    @IBOutlet weak var foodPickerTwo: UIPickerView!

    @IBOutlet weak var foodPortionLabelA: UILabel!

    var foodPickerOneData: [String] = [String]()
    var foodPickerTwoData: [String] = [String]()
    var portionData: [String] = [String]()

    var foodItemSelected: Int = Int()
    var foodItemSelectedTwo: Int = Int()

    var yourImpactItemArray: [NSManagedObject] = []
    var yourImpactOutput: String = String()
    var yourImpactOutputOne: String = String()
    var yourImpactOutputTwo: String = String()
    var yourImpactOutputThree: String = String()
    var yourImpactOutputFour: String = String()
    var yourImpactOutputFive: String = String()
    var yourImpactOutputSix: String = String()
    var yourImpactOutputSeven: String = String()

    var portionText:String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        addWTILogo2()
        self.title = "Fruit & Vegetables"
        self.view.backgroundColor = UIColor(red: 0/255, green: 153/255, blue: 222/255, alpha: 1)

        // Connect data:
        self.foodPickerOne.delegate = self
        self.foodPickerOne.dataSource = self

        self.foodPickerTwo.delegate = self
        self.foodPickerTwo.dataSource = self

        // Items to Display in Food Picker
        foodPickerOneData = ["Apples", "Bananas", "Berries", "Cabbage", "Carrots", "Oranges", "Leeks", "Onions", "Peas", "Tomatoes"]
        foodPickerTwoData = ["1", "2", "3", "4", "5", "6", "7"]

        portionText = "1 fruit (130g)"
        foodPortionLabelA.text = "1 Portion\nNote: Each Portion = " + String(portionText)

        portionData = ["1 fruit (130g)", "1 fruit (110g)", "1 handful (35g)", "1 cup (90g)", "1 cup (130g)", "1 fruit (70g)", "1 vegetable (90g)", "1 medium (110g)", "80g", "1 fruit (100g)"]

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

        // Non iOS13 Style
            } else {
                let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                statusBar?.backgroundColor = UIColor.black
            }

        }

        override var preferredStatusBarStyle : UIStatusBarStyle {
            return UIStatusBarStyle.lightContent

        }



    // Number of columns of data to display in each PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {

        if pickerView.tag == 1 {
            return 1
        } else {
            return 1
        }
    }

    // The number of rows of data to display in each PickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return foodPickerOneData.count
        } else {
            return foodPickerTwoData.count
        }

    }

    // Define layout of text and images on each pickerView item
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        if pickerView.tag == 1 {
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width - 30, height: 40))

            let myImageView = UIImageView(frame: CGRect(x: (pickerView.bounds.width - 30) / 4, y: 5, width: 30, height: 30))

            var rowString = String()

            rowString = foodPickerOneData[row]
            myImageView.image = UIImage(named:rowString)

            let myLabel = UILabel(frame: CGRect(x: (pickerView.bounds.width - 30) / 2, y: 0, width: pickerView.bounds.width - 90, height: 40))
            myLabel.font = UIFont.systemFont(ofSize: 21.0)
            myLabel.textColor = UIColor.white
            myLabel.text = rowString

            myView.addSubview(myLabel)
            myView.addSubview(myImageView)

            return myView

        } else {
            let myView = UIView(frame: CGRect(x: (pickerView.bounds.width - 30) / 2, y: 0, width: pickerView.bounds.width - 30, height: 40))

            var rowString = String()

            rowString = foodPickerTwoData[row]

            let myLabel = UILabel(frame: CGRect(x: (pickerView.bounds.width - 30) / 2, y: 0, width: pickerView.bounds.width - 90, height: 40))
            myLabel.font = UIFont.systemFont(ofSize: 21.0)
            myLabel.textColor = UIColor.white
            myLabel.text = rowString

            myView.addSubview(myLabel)
            return myView
        }
    }

    // Define height of each pickerView item
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }


    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        if pickerView.tag == 1 {

            foodItemSelected = row
            portionText = portionData[row]

            if portionMultiplier == 0.5 {foodPortionLabelA.text = "½ Portion\nNote: Each Portion = " + String(portionText)}

            if portionMultiplier == 1.0 {foodPortionLabelA.text = "1 Portion\nNote: Each Portion = " + String(portionText)}

            else {foodPortionLabelA.text = String(Int(portionMultiplier)) + " Portions\nNote: Each Portion = " + String(portionText)}

        } else {

            foodItemSelectedTwo = row

        }


    }

    var portionMultiplier:Double = 1.0

    // Change Portion slider & Text which changes as user edits portion size
    @IBAction func changePortion(_ sender: UISlider) {
        if portionSlider.value < 0.75 {
            portionSlider.value = 0.5
            portionMultiplier = Double(portionSlider.value)

            foodPortionLabelA.text = "½ Portion\nNote: Each Portion = " + String(portionText)
        } else {
            portionSlider.value = roundf(portionSlider.value)
            portionMultiplier = Double(portionSlider.value)

            if portionMultiplier == 1.0 {
                foodPortionLabelA.text = "1 Portion\nNote: Each Portion = " + String(portionText)
            }
            else {
                foodPortionLabelA.text = String(Int(portionMultiplier)) + " Portions\nNote: Each Portion = " + String(portionText)
            }
        }

    }

    // Button which Saves Food/Drink item to the Core Data stack -> then displayed in Your Impact Tab
    @IBAction func saveToDashboardButton(_ sender: Any) {

        var foodCarbonValues = [[String]]()

        // Data on each food item
        foodCarbonValues = [
            ["Product", "CO2 Emissions", "Freshwater Withdrawals", "Acidifying Emissions", "Land Use"],     ["Apples", "2.9068", "1217.476", "23.7952", "4.2588"],     ["Bananas", "4.9192", "654.94", "36.322", "11.0396"],     ["Berries", "2.88405", "790.946", "23.16665", "4.54285"],     ["Cabbage", "2.3868", "558.792", "38.4228", "2.574"],     ["Carrots", "2.9068", "191.984", "19.604", "2.2308"],     ["Oranges", "1.4196", "301.028", "14.7056", "3.1304"],     ["Leeks", "2.34", "66.924", "16.9884", "1.8252"],     ["Onions", "2.86", "81.796", "20.7636", "2.2308"],     ["Peas", "4.0768", "1649.856", "35.3184", "31.0336"],     ["Tomatoes", "10.868", "1922.96", "89.492", "4.16"]]

        yourImpactOutputOne = "\(foodCarbonValues[foodItemSelected + 1][0])"

        yourImpactOutputTwo = "\(String(Double(foodCarbonValues[foodItemSelected + 1][1])! * portionMultiplier * Double((foodItemSelectedTwo + 1))))"

        yourImpactOutputThree = "\(String(Double(foodCarbonValues[foodItemSelected + 1][2])! * portionMultiplier * Double((foodItemSelectedTwo + 1))))"

        yourImpactOutputFour = "food"

        yourImpactOutputSix = "\(String(Double(foodCarbonValues[foodItemSelected + 1][3])! * portionMultiplier * Double((foodItemSelectedTwo + 1))))"

        yourImpactOutputSeven = "\(String(Double(foodCarbonValues[foodItemSelected + 1][4])! * portionMultiplier * Double((foodItemSelectedTwo + 1))))"


        // Saving Food/Drink item to Core Data Stack
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer2.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CompareStorage", in: managedContext)!
        let yourImpactItem = NSManagedObject(entity: entity, insertInto: managedContext)
        yourImpactItem.setValue(yourImpactOutputOne, forKeyPath: "name")
        yourImpactItem.setValue(yourImpactOutputTwo, forKeyPath: "co2")
        yourImpactItem.setValue(yourImpactOutputThree, forKeyPath: "water")
        yourImpactItem.setValue(yourImpactOutputFour, forKeyPath: "type")

        yourImpactItem.setValue(yourImpactOutputSix, forKeyPath: "so2")

        yourImpactItem.setValue(yourImpactOutputSeven, forKeyPath: "land")

        do {
            try managedContext.save()

            let otherVCValue = CompareViewController.GlobalVariable.compareItemEdited

            print("U" + String(otherVCValue))
            if otherVCValue == -1 {
                print("UUU" + String(otherVCValue))
                yourImpactItemArray.append(yourImpactItem)


            }

            else {
                print("UUU" + String(otherVCValue))
                yourImpactItemArray.append(yourImpactItem)

            }

        // If problem with CoreData saving occurs
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

        // After data is saved, user is automatically taken to the CompareViewController
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: false)

    }

}
