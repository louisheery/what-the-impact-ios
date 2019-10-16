//
//  YourImpactViewController.swift
//  WhatTheImpact
//
//  Created by Louis on 25/07/2019.
//  Copyright © 2019 twoprime. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Charts

class YourImpactViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    // Defines number format labels of Pie Chart
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?, dataPoints: String) -> String {

        if yourImpactGraphView == "co2" {
            return String(dataPoints) + "\n" + String(value) + " kg"
        }

        if yourImpactGraphView == "water" {
            return String(value) + " l"
        }

        if yourImpactGraphView == "so2" {
            return String(value) + " g"
        }

        else {
            return String(value) + " m²"
        }

    }


    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var pieChartBgndView: UIView!

    var pieChartDataPoints: [String]!

    var yourImpactGraphView: String = String()

    var yourImpactItemArray: [NSManagedObject] = []

    @IBOutlet weak var totalCO2Label: UIButton!
    @IBOutlet weak var totalWaterLabel: UIButton!
    @IBOutlet weak var totalSO2Label: UIButton!
    @IBOutlet weak var totalLandLabel: UIButton!

    @IBOutlet weak var foodResultLabelTwo: UILabel!
    @IBOutlet weak var foodResultLabelTwoB: UILabel!
    @IBOutlet weak var foodResultLabelTwoC: UILabel!
    @IBOutlet weak var foodResultLabelTwoD: UILabel!
    @IBOutlet weak var foodResultLabelTwoE: UILabel!
    @IBOutlet weak var foodResultLabelTwoF: UILabel!
    @IBOutlet weak var foodResultLabelTwoG: UILabel!
    @IBOutlet weak var foodResultLabelTwoH: UILabel!

    @IBOutlet weak var foodResultLabelThree: UILabel!
    @IBOutlet weak var foodResultLabelFour: UILabel!
    @IBOutlet weak var foodResultLabelFive: UILabel!
    @IBOutlet weak var foodResultLabelSix: UILabel!

    @IBOutlet weak var thatEquivalentLabel: UILabel!

    @IBOutlet weak var graphtablePicker: UISegmentedControl!

    @IBOutlet weak var tableView: UITableView!


    var count: Int = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        addWTILogo2()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 0/255, green: 153/255, blue: 222/255, alpha: 1)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.reloadData()
        self.tableView.isHidden = true

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
        pieChartView.backgroundColor = UIColor.white

        pieChartView.noDataText = "Graph will be displayed once items have been added."

        pieChartView.delegate = self as? ChartViewDelegate

        let months = [""]
        let unitsSold = [0.0]

        setChart(dataPoints: months, values: unitsSold)

        yourImpactGraphView = "co2"

        fetchData()

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

        // non-iOS13 status bar colour
            } else {
        _ = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView

            }

        }

        override var preferredStatusBarStyle : UIStatusBarStyle {
            return UIStatusBarStyle.lightContent

        }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchData()
        self.tableView.reloadData()

    }

    // Fetches data from Core Data storage to be displayed in Pie Chart
    func fetchData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "YourImpactStorage")

        do {
            yourImpactItemArray = try managedContext.fetch(fetchRequest)

            count = 0
            count = try managedContext.count(for: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        calculateCO2ValueDisplay()


        var months:[String] = [String]()
        var unitsSold:[Double] = [Double]()

        if yourImpactItemArray.count >= 1 {

            for i in 0..<yourImpactItemArray.count {
                let dataPointAdd = (yourImpactItemArray[i].value(forKeyPath: "name") as? String)!
                months.append(dataPointAdd)
            }

            for i in 0..<yourImpactItemArray.count {
                let dataPointAdd = Double((yourImpactItemArray[i].value(forKeyPath: yourImpactGraphView) as? String)!)
                unitsSold.append(dataPointAdd!)
            }
        }

        setChart(dataPoints: months, values: unitsSold)

        hideAllInfo()
        foodResultLabelTwo.isHidden = false
        foodResultLabelTwoB.isHidden = false
        foodResultLabelThree.isHidden = false
        thatEquivalentLabel.backgroundColor = UIColor(red: 84/255, green: 36/255, blue: 0/255, alpha: 1)

        self.tableView.reloadData()

    }

    func hideAllInfo() {
        foodResultLabelTwo.isHidden = true
        foodResultLabelTwoB.isHidden = true
        foodResultLabelTwoC.isHidden = true
        foodResultLabelTwoD.isHidden = true
        foodResultLabelTwoE.isHidden = true
        foodResultLabelTwoF.isHidden = true
        foodResultLabelTwoG.isHidden = true
        foodResultLabelTwoH.isHidden = true

        foodResultLabelThree.isHidden = true
        foodResultLabelFour.isHidden = true
        foodResultLabelFive.isHidden = true
        foodResultLabelSix.isHidden = true

    }

    // Displays CO2 Screen on Clicked
    @IBAction func CO2Screen(_ sender: Any) {
        yourImpactGraphView = "co2"
        fetchData()
        hideAllInfo()

        foodResultLabelTwo.isHidden = false
        foodResultLabelTwoB.isHidden = false
        foodResultLabelThree.isHidden = false
        thatEquivalentLabel.backgroundColor = UIColor(red: 84/255, green: 36/255, blue: 0/255, alpha: 1)
    }

    // Displays Water Screen on Clicked
    @IBAction func waterScreen(_ sender: Any) {
        yourImpactGraphView = "water"
        fetchData()
        hideAllInfo()
        self.foodResultLabelTwoC.isHidden = false
        self.foodResultLabelTwoD.isHidden = false
        self.foodResultLabelFour.isHidden = false
        thatEquivalentLabel.backgroundColor = UIColor(red: 4/255, green: 50/255, blue: 255/255, alpha: 1)

    }

    // Displays SO2 Screen on Clicked
    @IBAction func so2Screen(_ sender: Any) {
        yourImpactGraphView = "so2"
        fetchData()
        hideAllInfo()
        self.foodResultLabelTwoE.isHidden = false
        self.foodResultLabelTwoF.isHidden = false
        self.foodResultLabelFive.isHidden = false
        thatEquivalentLabel.backgroundColor = UIColor.black
    }

    // Displays Land Screen on Clicked
    @IBAction func landScreen(_ sender: Any) {
        yourImpactGraphView = "land"
        fetchData()
        hideAllInfo()
        self.foodResultLabelTwoG.isHidden = false
        self.foodResultLabelTwoH.isHidden = false
        self.foodResultLabelSix.isHidden = false
        thatEquivalentLabel.backgroundColor = UIColor(red: 0/255, green: 223/255, blue: 49/255, alpha: 1)
    }


    // Clears all data from Core Data storage and refreshes YourImpact View
    @IBAction func clearAllDataButton(_ sender: Any) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "YourImpactStorage")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try context.execute(deleteRequest)
            try context.save()
            self.yourImpactItemArray.removeAll()
            self.fetchData()
        } catch {
            print ("There was an error")
        }
    }

    // Calculates Total CO2/Water/SO2/Land values
    func calculateCO2ValueDisplay() {

        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "YourImpactStorage")

        do {
            yourImpactItemArray = try managedContext.fetch(fetchRequest)

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        // Calculate the grand total of each item
        var grandTotalCarbon:Int = 0
        var grandTotalWater:Int = 0
        var grandTotalSulphur:Int = 0
        var grandTotalLand:Int = 0

        var valueTempCarbon:Int = Int()
        var valueTempWater:Int = Int()
        var valueTempSulphur:Int = Int()
        var valueTempLand:Int = Int()

        for carbon in yourImpactItemArray {
            valueTempCarbon = Int(Float(carbon.value(forKey: "co2") as! String)!)

            grandTotalCarbon += valueTempCarbon
        }

        for water in yourImpactItemArray {
            valueTempWater = Int(Float(water.value(forKey: "water") as! String)!)
            grandTotalWater += valueTempWater
        }

        for sulphur in yourImpactItemArray {
            valueTempSulphur = Int(Float(sulphur.value(forKey: "so2") as! String)!)
            grandTotalSulphur += valueTempSulphur
        }


        for land in yourImpactItemArray {
            valueTempLand = Int(Float(land.value(forKey: "land") as! String)!)
            grandTotalLand += valueTempLand
        }

        totalCO2Label.setTitle("Total CO₂\n" + String(grandTotalCarbon) + " kg", for: .normal)
        totalCO2Label.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        totalCO2Label.titleLabel?.textAlignment = .center


        totalWaterLabel.setTitle("Total Water\n" + String(grandTotalWater) + " L", for: .normal)
        totalWaterLabel.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        totalWaterLabel.titleLabel?.textAlignment = .center

        totalSO2Label.setTitle("Total SO₂\n" + String(grandTotalSulphur) + " g", for: .normal)
        totalSO2Label.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        totalSO2Label.titleLabel?.textAlignment = .center

        totalLandLabel.setTitle("Total Land\n" + String(grandTotalLand) + " m²", for: .normal)
        totalLandLabel.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        totalLandLabel.titleLabel?.textAlignment = .center

        foodResultLabelTwoB.text = String(grandTotalCarbon) + " kg"
        foodResultLabelTwoD.text = String(grandTotalWater) + " litres"
        foodResultLabelTwoF.text = String(grandTotalSulphur) + " g"
        foodResultLabelTwoH.text = String(grandTotalLand) + " m²"


        let attrsThree = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 28)]
        let attrsThreeb = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 28)]

        // CO2

        let originalStringThree = NSMutableAttributedString(string:"")

        if Float(grandTotalCarbon)/70.0 < 0.1 {
            originalStringThree.append(NSMutableAttributedString(string:"< 0.1", attributes:attrsThree))
        } else {
            originalStringThree.append(NSMutableAttributedString(string:"\(String(Int((Double(grandTotalCarbon)/70.0))))", attributes:attrsThree))
        }


        // SOURCE: https://www.clevel.co.uk/flight-carbon-calculator/

        originalStringThree.append(NSMutableAttributedString(string:"\nLondon to Dublin Flights", attributes:attrsThreeb))

        foodResultLabelThree.attributedText = originalStringThree


        // Water
        let originalStringFour = NSMutableAttributedString(string:"")

        if Float(grandTotalWater)/60.0 < 0.1 {
            originalStringFour.append(NSMutableAttributedString(string:"< 0.1", attributes:attrsThree))
        }
        else {
            originalStringFour.append(NSMutableAttributedString(string:"\(String(Int((Double(grandTotalWater)/60.0))))", attributes:attrsThree))
        }


        // SOURCE: https://www.home-water-works.org/indoor-use/showers

        originalStringFour.append(NSMutableAttributedString(string:"\nFive-minute Showers", attributes:attrsThreeb))

        foodResultLabelFour.attributedText = originalStringFour


        // Land
        let originalStringFive = NSMutableAttributedString(string:"")


        if Float(grandTotalSulphur) * 5.0/7.0 < 0.1 {
            originalStringFive.append(NSMutableAttributedString(string:"< 0.1", attributes:attrsThree))
        }

        else {
            originalStringFive.append(NSMutableAttributedString(string:"\(String(Int((Double(grandTotalSulphur) * 5.0/7.0))))", attributes:attrsThree))
        }

        originalStringFive.append(NSMutableAttributedString(string:" hours of TV\npowered by Coal electricity", attributes:attrsThreeb))

        foodResultLabelFive.attributedText = originalStringFive



        // divided by [7g of SO2 produced per kWh of Electricity generated from coal] - https://www3.epa.gov/ttnchie1/conference/ei20/session5/mmittal.pdf
        // TV estimated to run at 200W - https://michaelbluejay.com/electricity/tv.html -> so times the above value by 5.0 i.e. there are 5 x 200W in 1kWh.


        // Water
        let originalStringSix = NSMutableAttributedString(string:"")

        if Float(grandTotalLand)/195.6271 < 0.1 {
            originalStringSix.append(NSMutableAttributedString(string:"< 0.1", attributes:attrsThree))
        }
        else {
            originalStringSix.append(NSMutableAttributedString(string:"\(String(Int((Double(grandTotalLand)/195.6271))))", attributes:attrsThree))
        }


        // divide by 195.6271 m^2 (area of tennis court)
        originalStringSix.append(NSMutableAttributedString(string:"\nTennis courts", attributes:attrsThreeb))

        foodResultLabelSix.attributedText = originalStringSix



    }


    // Defines data to be displayed in PieChart & its Colour Scheme
    func setChart(dataPoints: [String], values: [Double]) {
        pieChartView.noDataText = "You need to provide data for the chart."

        var dataEntries: [ChartDataEntry] = []


        dataEntries = (0..<dataPoints.count).map { (i) -> PieChartDataEntry in

            var dataP:String = String()

            dataP = String(dataPoints[i])


            return PieChartDataEntry(value: values[i], label: dataP)
        }


        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)

        pieChartView.data = pieChartData


        pieChartView.legend.enabled = false
        pieChartData.setDrawValues(false)

        pieChartData.setValueTextColor(.black)


        var colors: [UIColor] = []

        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(170) + 85)
            let green = Double(arc4random_uniform(170) + 85)
            let blue = Double(arc4random_uniform(170) + 85)

            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }

        pieChartDataSet.colors = colors

        pieChartView.extraRightOffset = 4
        pieChartView.extraLeftOffset = 4
        pieChartView.extraTopOffset = 4
        pieChartView.extraBottomOffset = 4


    }


    // Switches between Pie Chart and tableView of data when SegmentedControl state is changed by user
    @IBAction func graphtablePickerChanged(_ sender: UISegmentedControl) {


        if graphtablePicker.selectedSegmentIndex == 0 {
            if yourImpactItemArray.count < 1 {
                pieChartView.isHidden = true
                tableView.isHidden = true
            }
            else {
                pieChartView.isHidden = false
                tableView.isHidden = true
            }
        }

        if graphtablePicker.selectedSegmentIndex == 1 {

            if yourImpactItemArray.count < 1 {
                pieChartView.isHidden = true
                tableView.isHidden = true
            }
            else {
                pieChartView.isHidden = true
                tableView.isHidden = false
            }
        }


    }


    // YOUR IMPACT TABLE VIEW
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext

            managedContext.delete(self.yourImpactItemArray[indexPath.row])

            do {
                try managedContext.save()
                self.yourImpactItemArray.removeAll()
                self.fetchData()
            } catch {

            }

        }

    }

    func numberOfItemsWithType(typeName: String) -> Int {
        var valueHere: Int = Int()

        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate!.persistentContainer.viewContext
        let request: NSFetchRequest<YourImpactStorage> = YourImpactStorage.fetchRequest()
        request.relationshipKeyPathsForPrefetching = ["type"]

        request.predicate = NSPredicate(format: "ANY type ==[c] %@",
                                        argumentArray: [typeName])


        do {
            valueHere = try context.fetch(request).count
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return valueHere
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return numberOfItemsWithType(typeName: "Food")

    }


    // Defines data text to be displayed in TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let yourImpactItem = yourImpactItemArray[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! HeadlineTableViewCell

        cell.column1?.text = yourImpactItem.value(forKeyPath: "name") as? String

        var co2Val:String = String()
        var waterVal:String = String()
        var so2Val:String = String()
        var landVal:String = String()

        if Float((yourImpactItem.value(forKeyPath: "co2") as? String)!) != nil {
            co2Val = String(Int(Float((yourImpactItem.value(forKeyPath: "co2") as? String)!)!))
        } else {
            co2Val = ""
        }

        if Float((yourImpactItem.value(forKeyPath: "water") as? String)!) != nil {
            waterVal = String(Int(Float((yourImpactItem.value(forKeyPath: "water") as? String)!)!))
        } else {
            waterVal = ""
        }

        if Float((yourImpactItem.value(forKeyPath: "so2") as? String)!) != nil {
            so2Val = String(Int(Float((yourImpactItem.value(forKeyPath: "so2") as? String)!)!))
        } else {
            so2Val = ""
        }

        if Float((yourImpactItem.value(forKeyPath: "land") as? String)!) != nil {
            landVal = String(Int(Float((yourImpactItem.value(forKeyPath: "land") as? String)!)!))
        } else {
            landVal = ""
        }

        switch yourImpactGraphView {
        case "co2":
            cell.column2?.text = String(String(co2Val) + " kg")

        case "water" :
            cell.column2?.text = String(String(waterVal) + " litres")

        case "so2" :
            cell.column2?.text = String(String(so2Val) + " g")

        case "land" :
            cell.column2?.text = String(String(landVal) + " m²")

        default:
            cell.column2?.text = ""
        }

        return cell

    }

}

// Custom TableView Class
class HeadlineTableViewCell: UITableViewCell {
    @IBOutlet weak var column1: UILabel!
    @IBOutlet weak var column2: UILabel!

}

// Custom TabBar Controller animation when switching between viewControllers
extension YourImpactViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MyTransition(viewControllers: tabBarController.viewControllers)
    }
}
