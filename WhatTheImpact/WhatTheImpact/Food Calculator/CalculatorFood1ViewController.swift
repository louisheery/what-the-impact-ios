//
//  CalculatorFood1ViewController.swift
//  WhatTheImpact
//
//  Created by Louis on 13/07/2019.
//  Copyright © 2019 twoprime. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CalculatorFood1ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    // CollectionView which graphically represent e.g. CO2 impact as # of images of Airplanes
    // There are 4 different CollectionViews: Labelled as, 11, 12, 13, other
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        // Defines number of item displayed in each collectionView
        if collectionView.tag == 11 {
            return numberOfCO2ItemsInCollection
        }
        if collectionView.tag == 12 {
            return numberOfWaterItemsInCollection
        }
        if collectionView.tag == 13 {
            return numberOfSO2ItemsInCollection
        }
        else  {
            return numberOfLandItemsInCollection
        }

    }

    // Defines number of items to display in each CollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView.tag == 11 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)


            if indexPath.row == Int(numberOfCO2ItemsInCollection - 1) {
                let imageName = String("airplane" + String(extraCO2CollectionItem))

                if let photo = cell.viewWithTag(101) as? UIImageView {

                    photo.image = UIImage(named: imageName)!

                }
            } else {
                if let photo = cell.viewWithTag(101) as? UIImageView {

                    photo.image = UIImage(named: "co2image")!

                }

            }

            return cell
        }

        if collectionView.tag == 12 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)


            if indexPath.row == Int(numberOfWaterItemsInCollection - 1) {
                let imageName = String("bath" + String(extraWaterCollectionItem))

                if let photo = cell.viewWithTag(101) as? UIImageView {
                    photo.image = UIImage(named: imageName)!


                }
            } else {
                if let photo = cell.viewWithTag(101) as? UIImageView {
                    photo.image = UIImage(named: "waterimage")!

                }

            }

            return cell
        }

        if collectionView.tag == 13 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)


            if indexPath.row == Int(numberOfSO2ItemsInCollection - 1) {
                let imageName = String("tv" + String(extraSO2CollectionItem))

                if let photo = cell.viewWithTag(101) as? UIImageView {

                    photo.image = UIImage(named: imageName)!


                }
            } else {
                if let photo = cell.viewWithTag(101) as? UIImageView {

                    photo.image = UIImage(named: "so2image")!

                }

            }

            return cell
        }

        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)


            if indexPath.row == Int(numberOfLandItemsInCollection - 1) {
                let imageName = String("tennis" + String(extraLandCollectionItem))

                if let photo = cell.viewWithTag(101) as? UIImageView {

                    photo.image = UIImage(named: imageName)!


                }
            } else {
                if let photo = cell.viewWithTag(101) as? UIImageView {

                    photo.image = UIImage(named: "landimage")!

                }

            }

            return cell
        }

    }


    @IBOutlet weak var foodPickerLabelOne: UILabel!
    @IBOutlet weak var foodPickerLabelTwo: UILabel!

    @IBOutlet weak var foodResultLabelOne: UILabel!

    @IBOutlet weak var foodResultLabelTwo: UILabel!
    @IBOutlet weak var foodResultLabelTwoB: UILabel!
    @IBOutlet weak var foodResultLabelTwoC: UILabel!
    @IBOutlet weak var foodResultLabelTwoD: UILabel!
    @IBOutlet weak var foodResultLabelTwoE: UILabel!
    @IBOutlet weak var foodResultLabelTwoF: UILabel!
    @IBOutlet weak var foodResultLabelTwoG: UILabel!
    @IBOutlet weak var foodResultLabelTwoH: UILabel!


    @IBOutlet weak var foodPortionLabelA: UILabel!

    @IBOutlet weak var totalCO2Label: UIButton!
    @IBOutlet weak var totalWaterLabel: UIButton!
    @IBOutlet weak var totalSO2Label: UIButton!
    @IBOutlet weak var totalLandLabel: UIButton!

    @IBOutlet weak var pieChartBgndView: UIView!
    var calculatedResultView: String = String()

    @IBOutlet weak var foodResultLabelThree: UILabel!
    @IBOutlet weak var foodResultLabelFour: UILabel!
    @IBOutlet weak var foodResultLabelFive: UILabel!
    @IBOutlet weak var foodResultLabelSix: UILabel!

    @IBOutlet weak var portionSlider: UISlider!

    @IBOutlet weak var foodPickerLabelPortion: UILabel!

    @IBOutlet weak var saveToDashboardButton: UIButton!

    @IBOutlet weak var foodPickerOne: UIPickerView!

    @IBOutlet weak var foodPickerTwo: UIPickerView!

    @IBOutlet weak var calculateButton: UIButton!

    @IBOutlet weak var co2CollectionView: UICollectionView!
    @IBOutlet weak var waterCollectionView: UICollectionView!
    @IBOutlet weak var so2CollectionView: UICollectionView!
    @IBOutlet weak var landCollectionView: UICollectionView!

    @IBOutlet weak var overflowView: UIImageView!

    var numberOfCO2ItemsInCollection:Int = Int()
    var extraCO2CollectionItem:Float = Float()
    var numberOfWaterItemsInCollection:Int = Int()
    var extraWaterCollectionItem:Float = Float()
    var numberOfSO2ItemsInCollection:Int = Int()
    var extraSO2CollectionItem:Float = Float()
    var numberOfLandItemsInCollection:Int = Int()
    var extraLandCollectionItem:Float = Float()

    var extraCollec:Int = Int()

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

    var co2Value:Double = Double()
    var waterValue:Double = Double()
    var so2Value:Double = Double()
    var landValue:Double = Double()

    var co2RecommendValue:Double = Double()
    var waterRecommendValue:Double = Double()
    var so2RecommendValue:Double = Double()
    var landRecommendValue:Double = Double()

    var portionText:String = String()

    @IBOutlet weak var co2RecommendLabel: UILabel!
    @IBOutlet weak var waterRecommendLabel: UILabel!
    @IBOutlet weak var so2RecommendLabel: UILabel!
    @IBOutlet weak var landRecommendLabel: UILabel!

    @IBOutlet weak var thatEquivalentLabel: UILabel!


    @IBOutlet weak var recommendationView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addWTILogo2()
        // Do any additional setup after loading the view.
        self.title = "Fruit & Vegetables"
        self.view.backgroundColor = UIColor(red: 0/255, green: 153/255, blue: 222/255, alpha: 1)

        numberOfCO2ItemsInCollection = 0


        // ViewController objects which are initally hidden when loaded

        self.foodResultLabelOne.isHidden = true
        self.foodResultLabelTwo.isHidden = true
        self.foodResultLabelTwoB.isHidden = true
        self.foodResultLabelTwoC.isHidden = true
        self.foodResultLabelTwoD.isHidden = true
        self.foodResultLabelTwoE.isHidden = true
        self.foodResultLabelTwoF.isHidden = true
        self.foodResultLabelTwoG.isHidden = true
        self.foodResultLabelTwoH.isHidden = true
        self.foodResultLabelThree.isHidden = true
        self.foodResultLabelFour.isHidden = true
        self.foodResultLabelFive.isHidden = true
        self.foodResultLabelSix.isHidden = true
        self.saveToDashboardButton.isHidden = true

        self.totalCO2Label.isHidden = true
        self.totalWaterLabel.isHidden = true
        self.totalSO2Label.isHidden = true
        self.totalLandLabel.isHidden = true
        self.pieChartBgndView.isHidden = true
        self.recommendationView.isHidden = true

        // Connect data
        self.foodPickerOne.delegate = self
        self.foodPickerOne.dataSource = self

        self.foodPickerTwo.delegate = self
        self.foodPickerTwo.dataSource = self

        self.co2RecommendLabel.isHidden = true
        self.waterRecommendLabel.isHidden = true
        self.so2RecommendLabel.isHidden = true
        self.landRecommendLabel.isHidden = true

        // Items to be displayed in foodPicker and their portion Labels
        foodPickerOneData = ["Apples", "Bananas", "Berries", "Cabbage", "Carrots", "Oranges", "Leeks", "Onions", "Peas", "Tomatoes"]

        foodPickerTwoData = ["1", "2", "3", "4", "5", "6", "7"]

        portionText = "1 fruit (130g)"
        foodPortionLabelA.text = "1 Portion\nNote: Each Portion = " + String(portionText)

        portionData = ["1 fruit (130g)", "1 fruit (110g)", "1 handful (35g)", "1 cup (90g)", "1 cup (130g)", "1 fruit (70g)", "1 vegetable (90g)", "1 medium (110g)", "80g", "1 fruit (100g)"]

        totalCO2Label.layer.masksToBounds = true
        totalCO2Label.layer.cornerRadius = 10

        totalWaterLabel.layer.masksToBounds = true
        totalWaterLabel.layer.cornerRadius = 10

        totalSO2Label.layer.masksToBounds = true
        totalSO2Label.layer.cornerRadius = 10

        totalLandLabel.layer.masksToBounds = true
        totalLandLabel.layer.cornerRadius = 10

        pieChartBgndView.layer.masksToBounds = true
        pieChartBgndView.layer.cornerRadius = 10
        pieChartBgndView.backgroundColor = UIColor.white
        self.co2CollectionView.isHidden = true

        co2CollectionView.delegate = self
        co2CollectionView.dataSource = self

        self.waterCollectionView.isHidden = true

        waterCollectionView.delegate = self
        waterCollectionView.dataSource = self

        self.so2CollectionView.isHidden = true

        so2CollectionView.delegate = self
        so2CollectionView.dataSource = self

        self.landCollectionView.isHidden = true
        self.overflowView.isHidden = true

        landCollectionView.delegate = self
        landCollectionView.dataSource = self

        recommendationView.layer.masksToBounds = true
        recommendationView.layer.cornerRadius = 10

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

        // non-iOS 13 status bar colour
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor.black
        }

    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent

    }

    // Function hides all GUI elements not being displayed
    func hideAllResults() {
        self.foodResultLabelTwo.isHidden = true
        self.foodResultLabelTwoB.isHidden = true
        self.foodResultLabelThree.isHidden = true

        self.foodResultLabelTwoC.isHidden = true
        self.foodResultLabelTwoD.isHidden = true
        self.foodResultLabelFour.isHidden = true

        self.foodResultLabelTwoE.isHidden = true
        self.foodResultLabelTwoF.isHidden = true
        self.foodResultLabelFive.isHidden = true

        self.foodResultLabelTwoG.isHidden = true
        self.foodResultLabelTwoH.isHidden = true
        self.foodResultLabelSix.isHidden = true

        self.co2RecommendLabel.isHidden = true
        self.waterRecommendLabel.isHidden = true
        self.so2RecommendLabel.isHidden = true
        self.landRecommendLabel.isHidden = true

        self.co2CollectionView.isHidden = true
        self.waterCollectionView.isHidden = true
        self.so2CollectionView.isHidden = true
        self.landCollectionView.isHidden = true
        self.overflowView.isHidden = true

    }

    // Shows & Initiates GUI elements which display CO2 Impact of Food Item
    @IBAction func CO2Screen(_ sender: Any) {

        hideAllResults()
        self.foodResultLabelTwo.isHidden = false
        self.foodResultLabelTwoB.isHidden = false
        self.foodResultLabelThree.isHidden = false
        self.co2RecommendLabel.isHidden = false

        self.co2CollectionView.isHidden = false

        thatEquivalentLabel.backgroundColor = UIColor(red: 84/255, green: 36/255, blue: 0/255, alpha: 1)

        let inputValue = co2Value / 70.0

        if inputValue < 42 {
            numberOfCO2ItemsInCollection = Int((inputValue).rounded(.up))


            let extraItems:Float = Float(inputValue - (inputValue).rounded(.down))

            extraCO2CollectionItem = Float(Int(extraItems * 10))/10

            let layout = UICollectionViewFlowLayout()
            //layout.scrollDirection = .vertical

            let squareRooted = (Double(self.co2CollectionView.bounds.width) * Double(self.co2CollectionView.bounds.height) / Double(numberOfCO2ItemsInCollection)).squareRoot()

            var noOfCellsInRow:Float = Float()

            noOfCellsInRow = (Float(Double(numberOfCO2ItemsInCollection) * squareRooted / Double(self.co2CollectionView.bounds.height))).rounded(.up)

            var numberOfCellsInColumn = 1

            var numberOfCellsLeft:Int = Int(numberOfCO2ItemsInCollection)

            while numberOfCellsLeft > Int(noOfCellsInRow) {
                numberOfCellsLeft = numberOfCellsLeft - Int(noOfCellsInRow)
                numberOfCellsInColumn = numberOfCellsInColumn + 1
            }

            let size = Int(min(Int((self.co2CollectionView.bounds.width * 0.9) / CGFloat(noOfCellsInRow)), Int(self.co2CollectionView.bounds.height * 0.9), Int((self.co2CollectionView.bounds.height * 0.9) / CGFloat(numberOfCellsInColumn))))

            let cellSize = CGSize(width: size, height: size)

            layout.itemSize = cellSize
            layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
            layout.minimumLineSpacing = 1.0
            layout.minimumInteritemSpacing = 1.0

            co2CollectionView.reloadData()
            co2CollectionView.setCollectionViewLayout(layout, animated: true)


        }
        else {
            self.overflowView.isHidden = false
            self.overflowView.image = UIImage(named: "airplaneoverflow")
        }

    }

    // Shows & Initiates GUI elements which display Water Impact of Food Item
    @IBAction func WaterScreen(_ sender: Any) {

        hideAllResults()
        self.foodResultLabelTwoC.isHidden = false
        self.foodResultLabelTwoD.isHidden = false
        self.foodResultLabelFour.isHidden = false
        self.waterRecommendLabel.isHidden = false

        thatEquivalentLabel.backgroundColor = UIColor(red: 4/255, green: 50/255, blue: 255/255, alpha: 1)

        self.waterCollectionView.isHidden = false

        let inputValue = waterValue / 60.0

        if inputValue < 42 {
            numberOfWaterItemsInCollection = Int((inputValue).rounded(.up))


            let extraItems:Float = Float(inputValue - (inputValue).rounded(.down))

            extraWaterCollectionItem = Float(Int(extraItems * 10))/10

            let layout = UICollectionViewFlowLayout()

            let squareRooted = (Double(self.waterCollectionView.bounds.width) * Double(self.waterCollectionView.bounds.height) / Double(numberOfWaterItemsInCollection)).squareRoot()

            var noOfCellsInRow:Float = Float()

            noOfCellsInRow = (Float(Double(numberOfWaterItemsInCollection) * squareRooted / Double(self.waterCollectionView.bounds.height))).rounded(.up)

            var numberOfCellsInColumn = 1

            var numberOfCellsLeft:Int = Int(numberOfWaterItemsInCollection)

            while numberOfCellsLeft > Int(noOfCellsInRow) {
                numberOfCellsLeft = numberOfCellsLeft - Int(noOfCellsInRow)
                numberOfCellsInColumn = numberOfCellsInColumn + 1
            }

            let size = min(Int((self.waterCollectionView.bounds.width * 0.9) / CGFloat(noOfCellsInRow)), Int(self.waterCollectionView.bounds.height * 0.9), Int((self.waterCollectionView.bounds.height * 0.9) / CGFloat(numberOfCellsInColumn)))

            let cellSize = CGSize(width: size, height: size)

            layout.itemSize = cellSize
            layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
            layout.minimumLineSpacing = 1.0
            layout.minimumInteritemSpacing = 1.0

            waterCollectionView.reloadData()
            waterCollectionView.setCollectionViewLayout(layout, animated: true)


        }
        else {
            self.overflowView.isHidden = false
            self.overflowView.image = UIImage(named: "bathoverflow")
        }

    }

    // Shows & Initiates GUI elements which display SO2 Impact of Food Item
    @IBAction func SO2Screen(_ sender: Any) {

        hideAllResults()
        self.foodResultLabelTwoE.isHidden = false
        self.foodResultLabelTwoF.isHidden = false
        self.foodResultLabelFive.isHidden = false
        self.so2RecommendLabel.isHidden = false
        thatEquivalentLabel.backgroundColor = UIColor.black

        self.so2CollectionView.isHidden = false

        let inputValue = so2Value * 5.0 / 7.0

        if inputValue < 42 {
            numberOfSO2ItemsInCollection = Int((inputValue).rounded(.up))

            let extraItems:Float = Float(inputValue - (inputValue).rounded(.down))

            extraSO2CollectionItem = Float(Int(extraItems * 10))/10

            let layout = UICollectionViewFlowLayout()

            let squareRooted = (Double(self.so2CollectionView.bounds.width) * Double(self.so2CollectionView.bounds.height) / Double(numberOfSO2ItemsInCollection)).squareRoot()

            var noOfCellsInRow:Float = Float()

            noOfCellsInRow = (Float(Double(numberOfSO2ItemsInCollection) * squareRooted / Double(self.so2CollectionView.bounds.height))).rounded(.up)

            var numberOfCellsInColumn = 1

            var numberOfCellsLeft:Int = Int(numberOfSO2ItemsInCollection)

            while numberOfCellsLeft > Int(noOfCellsInRow) {
                numberOfCellsLeft = numberOfCellsLeft - Int(noOfCellsInRow)
                numberOfCellsInColumn = numberOfCellsInColumn + 1
            }

            let size = min(Int((self.so2CollectionView.bounds.width * 0.9) / CGFloat(noOfCellsInRow)), Int(self.so2CollectionView.bounds.height * 0.9), Int((self.so2CollectionView.bounds.height * 0.9) / CGFloat(numberOfCellsInColumn)))


            let cellSize = CGSize(width: size, height: size)

            layout.itemSize = cellSize
            layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
            layout.minimumLineSpacing = 1.0
            layout.minimumInteritemSpacing = 1.0

            so2CollectionView.reloadData()
            so2CollectionView.setCollectionViewLayout(layout, animated: true)
        }
        else {
            self.overflowView.isHidden = false
            self.overflowView.image = UIImage(named: "tvoverflow")
        }

    }

    // Shows & Initiates GUI elements which display Land Usage Impact of Food Item
    @IBAction func LandScreen(_ sender: Any) {

        hideAllResults()
        self.foodResultLabelTwoG.isHidden = false
        self.foodResultLabelTwoH.isHidden = false
        self.foodResultLabelSix.isHidden = false
        self.landRecommendLabel.isHidden = false
        thatEquivalentLabel.backgroundColor = UIColor(red: 0/255, green: 223/255, blue: 49/255, alpha: 1)


        let inputValue = landValue / 195.6271

        if inputValue < 42 {

            self.landCollectionView.isHidden = false

            numberOfLandItemsInCollection = Int((inputValue).rounded(.up))

            let extraItems:Float = Float(inputValue - (inputValue).rounded(.down))

            extraLandCollectionItem = Float(Int(extraItems * 10))/10

            let layout = UICollectionViewFlowLayout()

            let squareRooted = (Double(self.landCollectionView.bounds.width) * Double(self.landCollectionView.bounds.height) / Double(numberOfLandItemsInCollection)).squareRoot()

            var noOfCellsInRow:Float = Float()

            noOfCellsInRow = (Float(Double(numberOfLandItemsInCollection) * squareRooted / Double(self.landCollectionView.bounds.height))).rounded(.up)

            var numberOfCellsInColumn = 1

            var numberOfCellsLeft:Int = Int(numberOfLandItemsInCollection)

            while numberOfCellsLeft > Int(noOfCellsInRow) {
                numberOfCellsLeft = numberOfCellsLeft - Int(noOfCellsInRow)
                numberOfCellsInColumn = numberOfCellsInColumn + 1
            }

            let size = min(Int((self.landCollectionView.bounds.width * 0.9) / CGFloat(noOfCellsInRow)), Int(self.landCollectionView.bounds.height * 0.9), Int((self.landCollectionView.bounds.height * 0.9) / CGFloat(numberOfCellsInColumn)))

            let cellSize = CGSize(width: size, height: size)

            layout.itemSize = cellSize
            layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
            layout.minimumLineSpacing = 1.0
            layout.minimumInteritemSpacing = 1.0

            landCollectionView.reloadData()
            landCollectionView.setCollectionViewLayout(layout, animated: true)
        }

        else {
            self.overflowView.isHidden = false
            self.overflowView.image = UIImage(named: "tennisoverflow")
        }
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

    // Defines layout of each picker item
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

    // Defines height of each pickerView item
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

    // Changes portion size text displayed
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

    // Calculate Button -> Calculates & Displays CO2, Water, SO2, Land Impact of Food/Drink item
    @IBAction func foodButton1(_ sender: Any) {

        var foodCarbonValues = [[String]]()

        foodCarbonValues = [
            ["Product", "CO2 Emissions", "Freshwater Withdrawals", "Acidifying Emissions", "Land Use"],     ["Apples", "2.9068", "1217.476", "23.7952", "4.2588"],     ["Bananas", "4.9192", "654.94", "36.322", "11.0396"],     ["Berries", "2.88405", "790.946", "23.16665", "4.54285"],     ["Cabbage", "2.3868", "558.792", "38.4228", "2.574"],     ["Carrots", "2.9068", "191.984", "19.604", "2.2308"],     ["Oranges", "1.4196", "301.028", "14.7056", "3.1304"],     ["Leeks", "2.34", "66.924", "16.9884", "1.8252"],     ["Onions", "2.86", "81.796", "20.7636", "2.2308"],     ["Peas", "4.0768", "1649.856", "35.3184", "31.0336"],     ["Tomatoes", "10.868", "1922.96", "89.492", "4.16"]]

        let blankString = ""

        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)]

        let originalString = NSMutableAttributedString(string:blankString)

        if portionMultiplier == 0.5 {
            originalString.append(NSMutableAttributedString(string:String("Half"), attributes:attrs))
            originalString.append(NSMutableAttributedString(string:String(" a portion of ")))
        }
        if portionMultiplier == 1.0 {
            originalString.append(NSMutableAttributedString(string:String("One"), attributes:attrs))
            originalString.append(NSMutableAttributedString(string:String(" portion of ")))
        }
        if portionMultiplier > 1.5 {
            originalString.append(NSMutableAttributedString(string:String(Int(portionMultiplier)), attributes:attrs))
            originalString.append(NSMutableAttributedString(string:String(" portions of ")))
        }

        let partOne  = "\(foodCarbonValues[foodItemSelected + 1][0])"

        let partTwo = " consumed "
        var partThree:String = ""

        if Int(foodItemSelectedTwo + 1) == 1 {
            partThree = "once"
        } else if Int(foodItemSelectedTwo + 1) == 2 {
            partThree = "twice"
        } else {
            partThree = "\(String(Int(foodItemSelectedTwo + 1))) times"
        }

        let partFour = " per week for 1 year produces"

        let partFour2 = ""

        var extraString = NSMutableAttributedString(string:partOne, attributes: attrs)

        originalString.append(extraString)

        extraString = NSMutableAttributedString(string:partTwo)

        originalString.append(extraString)

        extraString = NSMutableAttributedString(string:partThree, attributes:attrs)
        originalString.append(extraString)

        extraString = NSMutableAttributedString(string:partFour)
        originalString.append(extraString)

        yourImpactOutputFive = originalString.string

        extraString = NSMutableAttributedString(string:partFour2)
        originalString.append(extraString)

        foodResultLabelOne.attributedText = originalString

        let partFive = "\(String(Int(Double(foodCarbonValues[foodItemSelected + 1][1])! * portionMultiplier * Double((foodItemSelectedTwo + 1))))) kg"
        let partSix = "\(String(Int(Double(foodCarbonValues[foodItemSelected + 1][2])! * portionMultiplier * Double((foodItemSelectedTwo + 1))))) litres"
        let partSeven:String = "\(String(Int(Double(foodCarbonValues[foodItemSelected + 1][3])! * portionMultiplier * Double((foodItemSelectedTwo + 1))))) g"
        let partEight:String = "\(String(Int(Double(foodCarbonValues[foodItemSelected + 1][4])! * portionMultiplier * Double((foodItemSelectedTwo + 1))))) m²"

        co2Value = Double(foodCarbonValues[foodItemSelected + 1][1])! * portionMultiplier * Double((foodItemSelectedTwo + 1))
        waterValue = Double(foodCarbonValues[foodItemSelected + 1][2])! * portionMultiplier * Double((foodItemSelectedTwo + 1))
        so2Value = Double(foodCarbonValues[foodItemSelected + 1][3])! * portionMultiplier * Double((foodItemSelectedTwo + 1))
        landValue = Double(foodCarbonValues[foodItemSelected + 1][4])! * portionMultiplier * Double((foodItemSelectedTwo + 1))

        // CO2
        var foodItemRecommendCO2:Int = Int()

        switch foodCarbonValues[foodItemSelected + 1][0] {
        case "Apples": foodItemRecommendCO2 = 6
        case "Bananas": foodItemRecommendCO2 = 1
        case "Berries": foodItemRecommendCO2 = 6
        case "Cabbage": foodItemRecommendCO2 = 7
        case "Carrots": foodItemRecommendCO2 = 7
        case "Oranges": foodItemRecommendCO2 = 6
        case "Leeks": foodItemRecommendCO2 = 7
        case "Onions": foodItemRecommendCO2 = 7
        case "Peas": foodItemRecommendCO2 = 7
        case "Tomatoes": foodItemRecommendCO2 = 5
        default: foodItemRecommendCO2 = foodItemSelected + 1
        }

        co2RecommendValue = Double(foodCarbonValues[foodItemRecommendCO2][1])! * portionMultiplier * Double((foodItemSelectedTwo + 1))

        var divide = co2RecommendValue / co2Value

        let percentageCO2Saving = ((1.0 - (divide)) * 100.0).rounded()

        var foodName = foodCarbonValues[foodItemRecommendCO2][0]

        if co2RecommendValue == co2Value {
            co2RecommendLabel.text = String(foodName) + " is the best choice in this category of Food / Drink"
        } else {
            co2RecommendLabel.text = "Switching to " + String(foodName) + " would reduce your CO₂ emissions by " + String(Int(percentageCO2Saving)) + "%"
        }

        // WATER
        var foodItemRecommendWater:Int = Int()

        switch foodCarbonValues[foodItemSelected + 1][0] {
        case "Apples": foodItemRecommendWater = 2
        case "Bananas": foodItemRecommendWater = 6
        case "Berries": foodItemRecommendWater = 2
        case "Cabbage": foodItemRecommendWater = 5
        case "Carrots": foodItemRecommendWater = 7
        case "Oranges": foodItemRecommendWater = 6
        case "Leeks": foodItemRecommendWater = 7
        case "Onions": foodItemRecommendWater = 7
        case "Peas": foodItemRecommendWater = 4
        case "Tomatoes": foodItemRecommendWater = 5
        default: foodItemRecommendWater = foodItemSelected + 1
        }

        waterRecommendValue = Double(foodCarbonValues[foodItemRecommendWater][2])! * portionMultiplier * Double((foodItemSelectedTwo + 1))


        divide = waterRecommendValue / waterValue

        let percentageWaterSaving = ((1.0 - (divide)) * 100.0).rounded()

        foodName = foodCarbonValues[foodItemRecommendWater][0]

        if waterRecommendValue == waterValue {
            waterRecommendLabel.text = String(foodName) + " is the best choice in this category of Food / Drink"
        } else {
            waterRecommendLabel.text = "Switching to " + String(foodName) + " would reduce your Water usage by " + String(Int(percentageWaterSaving)) + "%"
        }

        // SO2
        var foodItemRecommendSO2:Int = Int()

        switch foodCarbonValues[foodItemSelected + 1][0] {
        case "Apples": foodItemRecommendSO2 = 6
        case "Bananas": foodItemRecommendSO2 = 1
        case "Berries": foodItemRecommendSO2 = 6
        case "Cabbage": foodItemRecommendSO2 = 9
        case "Carrots": foodItemRecommendSO2 = 7
        case "Oranges": foodItemRecommendSO2 = 6
        case "Leeks": foodItemRecommendSO2 = 7
        case "Onions": foodItemRecommendSO2 = 7
        case "Peas": foodItemRecommendSO2 = 7
        case "Tomatoes": foodItemRecommendSO2 = 5
        default: foodItemRecommendSO2 = foodItemSelected + 1
        }

        so2RecommendValue = Double(foodCarbonValues[foodItemRecommendSO2][3])! * portionMultiplier * Double((foodItemSelectedTwo + 1))

        divide = so2RecommendValue / so2Value

        let percentageSO2Saving = ((1.0 - (divide)) * 100.0).rounded()

        foodName = foodCarbonValues[foodItemRecommendSO2][0]

        if so2RecommendValue == so2Value {
            so2RecommendLabel.text = String(foodName) + " is the best choice in this category of Food / Drink"
        } else {
            so2RecommendLabel.text = "Switching to " + String(foodName) + " would reduce your SO₂ emissions by " + String(Int(percentageSO2Saving)) + "%"
        }

        // Land
        var foodItemRecommendLand:Int = Int()

        switch foodCarbonValues[foodItemSelected + 1][0] {
        case "Apples": foodItemRecommendLand = 6
        case "Bananas": foodItemRecommendLand = 1
        case "Berries": foodItemRecommendLand = 6
        case "Cabbage": foodItemRecommendLand = 7
        case "Carrots": foodItemRecommendLand = 8
        case "Oranges": foodItemRecommendLand = 6
        case "Leeks": foodItemRecommendLand = 7
        case "Onions": foodItemRecommendLand = 7
        case "Peas": foodItemRecommendLand = 4
        case "Tomatoes": foodItemRecommendLand = 5
        default: foodItemRecommendLand = foodItemSelected + 1
        }

        landRecommendValue = Double(foodCarbonValues[foodItemRecommendLand][4])! * portionMultiplier * Double((foodItemSelectedTwo + 1))

        divide = landRecommendValue / landValue

        let percentageLandSaving = ((1.0 - (divide)) * 100.0).rounded()

        foodName = foodCarbonValues[foodItemRecommendLand][0]

        if landRecommendValue == landValue {
            landRecommendLabel.text = String(foodName) + " is the best choice in this category of Food / Drink"
        } else {
            landRecommendLabel.text = "Switching to " + String(foodName) + " would reduce your Land usage by " + String(Int(percentageLandSaving)) + "%"
        }

        foodResultLabelTwo.text = "CO₂ Emissions of"
        foodResultLabelTwoB.text = partFive
        foodResultLabelTwoC.text = "Fresh Water of"
        foodResultLabelTwoD.text = partSix
        foodResultLabelTwoE.text = "SO₂ Emissions of"
        foodResultLabelTwoF.text = partSeven
        foodResultLabelTwoG.text = "Land Usage of"
        foodResultLabelTwoH.text = partEight


        // CO2
        let attrsThree = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 28)]

        let originalStringThree = NSMutableAttributedString(string:"")

        if ((Double(foodCarbonValues[foodItemSelected + 1][1])! * portionMultiplier * Double((foodItemSelectedTwo + 1)))/70) < 0.1 {
            originalStringThree.append(NSMutableAttributedString(string:"< 0.1", attributes:attrsThree))
        } else {
            originalStringThree.append(NSMutableAttributedString(string:"\(String(((Double(foodCarbonValues[foodItemSelected + 1][1])! * portionMultiplier * Double((foodItemSelectedTwo + 1)))/70).rounded(toPlaces: 1)))", attributes:attrsThree))
        }


        // SOURCE: https://www.clevel.co.uk/flight-carbon-calculator/

        originalStringThree.append(NSMutableAttributedString(string:"\nFlights from London to Dublin"))

        foodResultLabelThree.attributedText = originalStringThree


        // Water
        let originalStringFour = NSMutableAttributedString(string:"")

        if (Double(foodCarbonValues[foodItemSelected + 1][2])! * portionMultiplier * Double((foodItemSelectedTwo + 1))/60) < 0.1 {
            originalStringFour.append(NSMutableAttributedString(string:"< 0.1", attributes:attrsThree))
        }
        else {
            originalStringFour.append(NSMutableAttributedString(string:"\(String((Double(foodCarbonValues[foodItemSelected + 1][2])! * portionMultiplier * Double((foodItemSelectedTwo + 1))/60).rounded(toPlaces: 1)))", attributes:attrsThree))
        }


        // SOURCE: https://www.home-water-works.org/indoor-use/showers

        originalStringFour.append(NSMutableAttributedString(string:"\nFive-minute Showers"))

        foodResultLabelFour.attributedText = originalStringFour

        // SO2
        let originalStringFive = NSMutableAttributedString(string:"")


        if (Double(foodCarbonValues[foodItemSelected + 1][3])! * portionMultiplier * Double((foodItemSelectedTwo + 1)) * 5/7) < 0.1 {
            originalStringFive.append(NSMutableAttributedString(string:"< 0.1", attributes:attrsThree))
        }

        else {
            originalStringFive.append(NSMutableAttributedString(string:"\(String((Double(foodCarbonValues[foodItemSelected + 1][3])! * portionMultiplier * Double((foodItemSelectedTwo + 1)) * 5/7).rounded(toPlaces: 1)))", attributes:attrsThree))
        }


        originalStringFive.append(NSMutableAttributedString(string:" hours of TV\npowered by Coal electricity"))

        foodResultLabelFive.attributedText = originalStringFive

        // divided by [7g of SO2 produced per kWh of Electricity generated from coal] - https://www3.epa.gov/ttnchie1/conference/ei20/session5/mmittal.pdf

        // TV estimated to run at 200W - https://michaelbluejay.com/electricity/tv.html -> so times the above value by 5.0 i.e. there are 5 x 200W in 1kWh.

        // Land
        let originalStringSix = NSMutableAttributedString(string:"")

        if (Double(foodCarbonValues[foodItemSelected + 1][4])! * portionMultiplier * Double((foodItemSelectedTwo + 1))/195.6271) < 0.1 {
            originalStringSix.append(NSMutableAttributedString(string:"< 0.1", attributes:attrsThree))
        }
        else {
            originalStringSix.append(NSMutableAttributedString(string:"\(String((Double(foodCarbonValues[foodItemSelected + 1][4])! * portionMultiplier * Double((foodItemSelectedTwo + 1))/195.6271).rounded(toPlaces: 1)))", attributes:attrsThree))
        }

        // divide by 195.6271 m^2 (area of tennis court)
        originalStringSix.append(NSMutableAttributedString(string:"\nTennis courts"))

        foodResultLabelSix.attributedText = originalStringSix


        yourImpactOutputOne = "\(foodCarbonValues[foodItemSelected + 1][0])"

        yourImpactOutputTwo = "\(String(Int(Double(foodCarbonValues[foodItemSelected + 1][1])! * portionMultiplier * Double((foodItemSelectedTwo + 1)))))"

        yourImpactOutputThree = "\(String(Int(Double(foodCarbonValues[foodItemSelected + 1][2])! * portionMultiplier * Double((foodItemSelectedTwo + 1)))))"

        yourImpactOutputSix = "\(String(Int(Double(foodCarbonValues[foodItemSelected + 1][3])! * portionMultiplier * Double((foodItemSelectedTwo + 1)))))"

        yourImpactOutputSeven = "\(String(Int(Double(foodCarbonValues[foodItemSelected + 1][4])! * portionMultiplier * Double((foodItemSelectedTwo + 1)))))"

        yourImpactOutputFour = "food"

        self.foodPickerOne.isHidden = true
        self.foodPickerTwo.isHidden = true
        self.foodPickerTwo.isHidden = true
        self.foodPickerLabelOne.isHidden = true
        self.foodPickerLabelTwo.isHidden = true
        self.foodResultLabelOne.isHidden = false
        self.saveToDashboardButton.isHidden = false
        self.foodPickerLabelPortion.isHidden = true
        self.portionSlider.isHidden = true
        self.calculateButton.isHidden = true
        self.foodPortionLabelA.isHidden = true

        self.totalCO2Label.isHidden = false
        self.totalWaterLabel.isHidden = false
        self.totalSO2Label.isHidden = false
        self.totalLandLabel.isHidden = false
        self.pieChartBgndView.isHidden = false
        self.recommendationView.isHidden = false

        hideAllResults()
        CO2Screen((Any).self)
        self.co2CollectionView.isHidden = false

        self.title = ""
    }

    // Saves Food Item to Core Data storage, and Displays YourImpact tab
    @IBAction func saveToDashboardButton(_ sender: Any) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "YourImpactStorage", in: managedContext)!
        let yourImpactItem = NSManagedObject(entity: entity, insertInto: managedContext)
        yourImpactItem.setValue(yourImpactOutputOne, forKeyPath: "name")
        yourImpactItem.setValue(yourImpactOutputTwo, forKeyPath: "co2")
        yourImpactItem.setValue(yourImpactOutputThree, forKeyPath: "water")
        yourImpactItem.setValue(yourImpactOutputFour, forKeyPath: "type")
        yourImpactItem.setValue(yourImpactOutputFive, forKeyPath: "detail")
        yourImpactItem.setValue(yourImpactOutputSix, forKeyPath: "so2")
        yourImpactItem.setValue(yourImpactOutputSeven, forKeyPath: "land")

        print("YOURIMPACT STORAGE SAVED")
        do {
            try managedContext.save()
            yourImpactItemArray.append(yourImpactItem)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

        self.tabBarController!.selectedIndex = 2

    }

}
