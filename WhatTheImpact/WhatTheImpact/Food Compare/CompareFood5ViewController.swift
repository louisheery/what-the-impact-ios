//
//  CompareFood5ViewController.swift
//  WhatTheImpact
//
//  Created by Louis on 13/07/2019.
//  Copyright © 2019 twoprime. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CompareFood5ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

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
        // Do any additional setup after loading the view.
        self.title = "Other"
        self.view.backgroundColor = UIColor(red: 0/255, green: 153/255, blue: 222/255, alpha: 1)


        // Connect data:
        self.foodPickerOne.delegate = self
        self.foodPickerOne.dataSource = self

        self.foodPickerTwo.delegate = self
        self.foodPickerTwo.dataSource = self

        // foodPickerOneData = ["Beef", "Lamb", "Chicken", "Chocolate"]
        foodPickerOneData = ["Chocolate", "Lentils", "Nuts", "Olive Oil", "Palm Oil", "Rapeseed Oil", "Soybean Oil", "Soymilk", "Sunflower Oil", "Tofu"]

        foodPickerTwoData = ["1", "2", "3", "4", "5", "6", "7"]

        portionText = "45g"
        foodPortionLabelA.text = "1 Portion\nNote: Each Portion = " + String(portionText)

        portionData = ["45g", "1/2 cup (100g)", "1 handful (30g)", "1 teaspoon (4.5g)", "1 teaspoon (4.5g)", "1 teaspoon (4.5g)", "1 teaspoon (4.5g)", "200ml", "1 teaspoon (4.5g)", "100g"]


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




    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }


    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.

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



    @IBAction func saveToDashboardButton(_ sender: Any) {

        var foodCarbonValues = [[String]]()

        foodCarbonValues =
            [
                ["Product", "CO2 Emissions", "Freshwater Withdrawals", "Acidifying Emissions", "Land Use"], ["Chocolate", "109.161", "1265.004", "108.342", "161.3664"],    ["Lentils", "9.308", "2265.64", "114.764", "80.964"],     ["Nuts", "0.6708", "6448.728", "70.434", "20.2176"],     ["Olive Oil", "1.26828", "501.1812", "8.79372", "6.15654"],     ["Palm Oil", "1.71288", "1.4976", "4.09968", "0.56628"],     ["Rapeseed Oil", "0.88218", "55.6218", "6.67134", "2.48742"],     ["Soybean Oil", "1.47888", "97.0164", "3.66678", "2.46168"],     ["Soymilk", "10.192", "289.12", "27.04", "6.864"],     ["Sunflower Oil", "0.8424", "235.8486", "6.54264", "4.13244"],     ["Tofu", "16.432", "772.72", "34.84", "18.304"]]


        yourImpactOutputOne = "\(foodCarbonValues[foodItemSelected + 1][0])"

        yourImpactOutputTwo = "\(String(Double(foodCarbonValues[foodItemSelected + 1][1])! * portionMultiplier * Double((foodItemSelectedTwo + 1))))"

        yourImpactOutputThree = "\(String(Double(foodCarbonValues[foodItemSelected + 1][2])! * portionMultiplier * Double((foodItemSelectedTwo + 1))))"

        yourImpactOutputFour = "food"

        yourImpactOutputSix = "\(String(Double(foodCarbonValues[foodItemSelected + 1][3])! * portionMultiplier * Double((foodItemSelectedTwo + 1))))"

        yourImpactOutputSeven = "\(String(Double(foodCarbonValues[foodItemSelected + 1][4])! * portionMultiplier * Double((foodItemSelectedTwo + 1))))"



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
        //yourImpactItem.setValue(frequencyToSave, forKeyPath: "frequency")

        do {
            try managedContext.save()
            yourImpactItemArray.append(yourImpactItem)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: false)

    }

}
