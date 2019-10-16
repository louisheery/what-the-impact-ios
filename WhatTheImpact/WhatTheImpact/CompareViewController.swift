//
//  CompareViewController.swift
//  WhatTheImpact
//
//  Created by Louis on 22/07/2019.
//  Copyright © 2019 twoprime. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Charts

class CompareViewController: UIViewController, IValueFormatter {

    // Defines format of numbers displayed in the Chart
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {

        if value >= 0.1 {
            if compareView == "co2" {

                if value > 1.0 {
                    return String(Int(value)) + " kg"
                }

                else {
                    return String(value.rounded(toPlaces: 1)) + " kg"
                }
            }

            if compareView == "water" {
                if value > 1.0 {
                    return String(Int(value)) + " l"
                }

                else {
                    return String(value.rounded(toPlaces: 1)) + " l"
                }
            }

            if compareView == "so2" {
                if value > 1.0 {
                    return String(Int(value)) + " g"
                }

                else {
                    return String(value.rounded(toPlaces: 1)) + " g"
                }
            }

            else {

                if value > 1.0 {
                    return String(Int(value)) + " m²"
                }

                else {
                    return String(value.rounded(toPlaces: 1)) + " m²"
                }

            }
        } else {
            return ""
        }

    }



    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var barChartView: BarChartView!
    var barChartDataPoints: [String]!

    @IBOutlet weak var barChartBgndView: UIView!

    @IBOutlet weak var totalCO2Label: UIButton!
    @IBOutlet weak var totalWaterLabel: UIButton!
    @IBOutlet weak var totalSO2Label: UIButton!
    @IBOutlet weak var totalLandLabel: UIButton!

    var compareItemArray: [NSManagedObject] = []

    var compareView: String = String()

    var count: Int = Int()

    var compareItemArrayOverlay:[[String]] =
        [
            ["Add","Add","Add"],
            ["add","add","add"]
    ]

    let exploreImages: [UIImage] = [UIImage(named: "blank")!, UIImage(named: "add")!, UIImage(named: "food")!]

    struct GlobalVariable{
        static var compareItemEdited:Int = Int()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        addWTILogo2()

        // Defines style of ViewController & Buttons
        self.view.backgroundColor = UIColor(red: 0/255, green: 153/255, blue: 222/255, alpha: 1)

        totalCO2Label.layer.masksToBounds = true
        totalCO2Label.layer.cornerRadius = 10

        totalWaterLabel.layer.masksToBounds = true
        totalWaterLabel.layer.cornerRadius = 10

        totalSO2Label.layer.masksToBounds = true
        totalSO2Label.layer.cornerRadius = 10

        totalLandLabel.layer.masksToBounds = true
        totalLandLabel.layer.cornerRadius = 10

        barChartBgndView.layer.masksToBounds = true
        barChartBgndView.layer.cornerRadius = 10
        barChartBgndView.backgroundColor = UIColor(red: 84/255, green: 36/255, blue: 0/255, alpha: 1)

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        self.collectionView.reloadData()

        // Bar Chart
        barChartView.noDataText = "Graph will be displayed once items have been added."

        barChartView.delegate = self as? ChartViewDelegate

        barChartView.isUserInteractionEnabled = false


        barChartDataPoints = ["", "", ""]
        let unitsSold = [0.0, 0.0, 0.0]

        setChart(dataPoints: barChartDataPoints, values: unitsSold)

        compareView = "co2"


        let layout = UICollectionViewFlowLayout()

        let screenSize = UIScreen.main.bounds
        let size = (screenSize.width - 26 - 26) * 0.3
        let sizeHeight = (screenSize.height) * 0.15

        let cellSize = CGSize(width: size, height: sizeHeight)

        layout.itemSize = cellSize

        layout.minimumInteritemSpacing = (screenSize.width - 26 - 26) * 0.04
        collectionView.setCollectionViewLayout(layout, animated: false)

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchData()

        self.collectionView.reloadData()

    }

    // Fetches data from Core Data storage to display in the Bar Chart
    func fetchData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer2.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CompareStorage")

        do {
            compareItemArray = try managedContext.fetch(fetchRequest)

            count = 0
            count = try managedContext.count(for: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        barChartDataPoints = ["", "", ""]

        var unitsSold = [0.0, 0.0, 0.0]

        if compareItemArray.count < 1 {
            barChartView.isHidden = true
        }

        if compareItemArray.count == 1 {
            barChartView.isHidden = false
            barChartDataPoints = [(compareItemArray[0].value(forKeyPath: "name") as? String)!.replacingOccurrences(of: " ", with: "\n"), "", ""]
            unitsSold = [Double((compareItemArray[0].value(forKeyPath: compareView) as? String)!), 0.0, 0.0] as! [Double]
        }

        if compareItemArray.count == 2 {
            barChartView.isHidden = false
            barChartDataPoints = [(compareItemArray[0].value(forKeyPath: "name") as? String)!.replacingOccurrences(of: " ", with: "\n"), (compareItemArray[1].value(forKeyPath: "name") as? String)!.replacingOccurrences(of: " ", with: "\n"), ""]
            unitsSold = [Double((compareItemArray[0].value(forKeyPath: compareView) as? String)!), Double((compareItemArray[1].value(forKeyPath: compareView) as? String)!), 0.0] as! [Double]
        }

        if compareItemArray.count >= 3 {
            barChartView.isHidden = false
            barChartDataPoints = [(compareItemArray[0].value(forKeyPath: "name") as? String)!.replacingOccurrences(of: " ", with: "\n"), (compareItemArray[1].value(forKeyPath: "name") as? String)!.replacingOccurrences(of: " ", with: "\n"), (compareItemArray[2].value(forKeyPath: "name") as? String)!.replacingOccurrences(of: " ", with: "\n")]

            unitsSold = [Double((compareItemArray[0].value(forKeyPath: compareView) as? String)!), Double((compareItemArray[1].value(forKeyPath: compareView) as? String)!), Double((compareItemArray[2].value(forKeyPath: compareView) as? String)!)] as! [Double]
        }

        setChart(dataPoints: barChartDataPoints, values: unitsSold)



    }

    // Displays CO2 Bar Chart when CO2 Button is clicked
    @IBAction func CO2Screen(_ sender: Any) {
        compareView = "co2"
        fetchData()
    }

    // Displays Water Bar Chart when Water Button is clicked
    @IBAction func waterScreen(_ sender: Any) {
        compareView = "water"
        fetchData()
    }

    // Displays SO2 Bar Chart when SO2 Button is clicked
    @IBAction func so2Screen(_ sender: Any) {
        compareView = "so2"
        fetchData()
    }

    // Displays Land Bar Chart when Land Button is clicked
    @IBAction func landScreen(_ sender: Any) {
        compareView = "land"
        fetchData()
    }

    // Deletes all Data from Core Data storage of the Compared items & Refreshed Bar Graph
    @IBAction func clearAllDataButton(_ sender: Any) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer2.viewContext

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CompareStorage")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try context.execute(deleteRequest)
            try context.save()
            self.compareItemArray.removeAll()
            self.fetchData()
            self.collectionView.reloadData()
        } catch {
            print ("There was an error")
        }
        self.collectionView.reloadData()

        compareItemArrayOverlay = [["Add","Add","Add"],["add","add","add"]]

    }

    // Defines style of Bar Chart
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."

        var dataEntries: [BarChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry =
                BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "CO2")

        chartDataSet.valueFont = UIFont.systemFont(ofSize: 12)
        chartDataSet.valueTextColor = UIColor.white

        let chartData = BarChartData(dataSet: chartDataSet)

        chartData.dataSets[0].valueFormatter = self


        if compareView == "co2" {
            barChartView.leftAxis.valueFormatter = CO2AxisValueFormatter()
        }
        if compareView == "water" {
            barChartView.leftAxis.valueFormatter = WaterAxisValueFormatter()
        }
        if compareView == "so2" {
            barChartView.leftAxis.valueFormatter = SO2AxisValueFormatter()
        }
        if compareView == "land" {
            barChartView.leftAxis.valueFormatter = LandAxisValueFormatter()
        }

        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:barChartDataPoints)

        barChartView.data = chartData

        chartDataSet.colors = [UIColor.white]

        barChartView.extraRightOffset = 4
        barChartView.extraLeftOffset = 4
        barChartView.extraTopOffset = 4
        barChartView.extraBottomOffset = 4

        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.gridColor = UIColor.white
        barChartView.leftAxis.gridColor = UIColor.white
        barChartView.rightAxis.gridColor = UIColor.white

        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.drawLabelsEnabled = false

        barChartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 12)
        barChartView.leftAxis.labelTextColor = UIColor.white
        barChartView.xAxis.labelTextColor = UIColor.white
        barChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 10)

        barChartView.legend.enabled = false

        // Defines different background of bar chart for different item being displayed
        if compareView == "co2" {
            barChartView.backgroundColor = UIColor(red: 84/255, green: 36/255, blue: 0/255, alpha: 1)
            barChartBgndView.backgroundColor = UIColor(red: 84/255, green: 36/255, blue: 0/255, alpha: 1)
        }
        if compareView == "water" {
            barChartView.backgroundColor = UIColor(red: 4/255, green: 50/255, blue: 255/255, alpha: 1)
            barChartBgndView.backgroundColor = UIColor(red: 4/255, green: 50/255, blue: 255/255, alpha: 1)
        }
        if compareView == "so2" {
            barChartView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
            barChartBgndView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        }
        if compareView == "land" {
            barChartView.backgroundColor = UIColor(red: 0/255, green: 223/255, blue: 49/255, alpha: 1)
            barChartBgndView.backgroundColor = UIColor(red: 0/255, green: 223/255, blue: 49/255, alpha: 1)
        }

        barChartView.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)

    }


}



// Definition of custom CollectionView
extension CompareViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        if indexPath[1] >= compareItemArray.count {
            CompareViewController.GlobalVariable.compareItemEdited = -1
            let viewController = storyboard?.instantiateViewController(withIdentifier: "CompareA")
            self.navigationController?.pushViewController(viewController!, animated: true)
        }

    }

    // Defines Data to be displayed in CollectionView (shows user the Food items being compared)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        cell.layer.cornerRadius = 10

        cell.backgroundColor = UIColor(red: 0/255, green: 91/255, blue: 189/255, alpha: 1)


        if compareItemArray.count >= 1 {
            compareItemArrayOverlay[0][0] = (compareItemArray[0].value(forKeyPath: "name") as? String)!
            compareItemArrayOverlay[1][0] = (compareItemArray[0].value(forKeyPath: "name") as? String)!
        }

        if compareItemArray.count >= 2 {
            compareItemArrayOverlay[0][1] = (compareItemArray[1].value(forKeyPath: "name") as? String)!
            compareItemArrayOverlay[1][1] = (compareItemArray[1].value(forKeyPath: "name") as? String)!
        }


        if compareItemArray.count >= 3 {
            compareItemArrayOverlay[0][2] = (compareItemArray[2].value(forKeyPath: "name") as? String)!
            compareItemArrayOverlay[1][2] = (compareItemArray[2].value(forKeyPath: "name") as? String)!
        }



        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = compareItemArrayOverlay[0][indexPath.row]
        }

        if let photo = cell.viewWithTag(105) as? UIImageView {
            photo.image = UIImage(named: compareItemArrayOverlay[1][indexPath.row])!
        }

        return cell
    }



}

// Defines CO2 Bar Chart Axis number format & units
final class CO2AxisValueFormatter: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {

        if (value < 5) && (value != 0) {
            let intVal = value.rounded(toPlaces: 1)
            return "\(intVal) kg"
        }
        else {
            let intVal = Int(value)
            return "\(intVal) kg"
        }




    }
}

// Defines Water Bar Chart Axis number format & units
final class WaterAxisValueFormatter: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {

        if (value < 5) && (value != 0) {
            let intVal = value.rounded(toPlaces: 1)
            return "\(intVal) l"
        }
        else {
            let intVal = Int(value)
            return "\(intVal) l"
        }


    }
}

// Defines SO2 Bar Chart Axis number format & units
final class SO2AxisValueFormatter: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if (value < 5) && (value != 0) {
            let intVal = value.rounded(toPlaces: 1)
            return "\(intVal) g"
        }
        else {
            let intVal = Int(value)
            return "\(intVal) g"
        }


    }
}

// Defines Land Bar Chart Axis number format & units
final class LandAxisValueFormatter: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {

        if (value < 5) && (value != 0) {
            let intVal = value.rounded(toPlaces: 1)
            return "\(intVal) m²"
        }
        else {
            let intVal = Int(value)
            return "\(intVal) m²"
        }

    }
}
