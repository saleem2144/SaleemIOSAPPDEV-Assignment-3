//
//  SeatMapVC.swift
//  BookingSystem
//
//  Created by Macbook on 19/05/2023.
//


var history: [History] = []
var trains: [Train] = []
var legacyTrains: [Train] = []

import UIKit

class LandingHomeScreen: UIViewController {
    
    var sourceCities: [String] = ["Sydney", "Melbourne", "Perth", "Canberra"]
    var destinationCities: [String] = ["Gold Coast", "Hobart", "Adelaide"]
    
    var myDatePicker = UIDatePicker()
    let sourcePicker = UIPickerView()
    let destinationPicker = UIPickerView()
    
    @IBOutlet weak var sourceTF: UITextField!
    @IBOutlet weak var destinationTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Home"
    }
    
    @IBAction func bookNowBtnPressed(_ sender: UIButton) {
        if sourceTF.text! == "" || destinationTF.text! == "" || dateTF.text == "" || timeTF.text == "" {
            showSimpleAlert(title: "Error", Body: "Please provide complete details to start booking") { _ in }
            return
        }
        searchTrains()
    }
    
    @IBAction func historyBtnPressed(_ sender: UIButton) {
        let vc = storyBoard.instantiateViewController(withIdentifier: "TravelHistoryVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupUI() {
        if #available(iOS 13.4, *) {
            myDatePicker.preferredDatePickerStyle = .wheels
        }
           
        myDatePicker.datePickerMode = .dateAndTime
        myDatePicker.minimumDate = Date()
        myDatePicker.minuteInterval = 15
        
        sourcePicker.delegate = self
        destinationPicker.delegate = self
        
        dateTF.addTarget(self, action: #selector(dateTextFieldDidChange), for: .editingDidBegin)
        timeTF.addTarget(self, action: #selector(dateTextFieldDidChange), for: .editingDidBegin)
        sourceTF.addTarget(self, action: #selector(pickerSourceDidChange), for: .editingDidBegin)
        destinationTF.addTarget(self, action: #selector(pickerDestinationDidChange), for: .editingDidBegin)
    }
}

extension LandingHomeScreen {
    
    @objc func dateTextFieldDidChange(textfield: UITextField) {
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneDatePicker))
        textfield.inputView = myDatePicker
        setupToolBar(textField: textfield, doneButton: doneButton)
    }
    
    func setupToolBar(textField: UITextField, doneButton: UIBarButtonItem){
        let toolBar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        toolBar.tintColor = .black
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        toolBar.setItems([doneButton], animated: false)
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneDatePicker(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        dateTF.text = dateFormatter.string(from: myDatePicker.date)
        
        dateFormatter.dateFormat = "h:mm a"
        timeTF.text = dateFormatter.string(from: myDatePicker.date)
        
        self.view.endEditing(true)
    }
}

extension LandingHomeScreen: UIPickerViewDelegate, UIPickerViewDataSource {
    
    @objc func pickerSourceDidChange(textfield: UITextField) {
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneSourceCityPicker))
        textfield.inputView = sourcePicker
        setupToolBar(textField: textfield, doneButton: doneButton)
    }
    
    @objc func pickerDestinationDidChange(textfield: UITextField) {
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneDestinationCityPicker))
        textfield.inputView = destinationPicker
        setupToolBar(textField: textfield, doneButton: doneButton)
    }
    
    @objc func doneSourceCityPicker(){
        let row = self.sourcePicker.selectedRow(inComponent: 0)
        self.sourcePicker.selectRow(0, inComponent: 0, animated: false)
        sourceTF.text = sourceCities[row]
        self.view.endEditing(true)
    }
                                         
     @objc func doneDestinationCityPicker(){
         let row = self.destinationPicker.selectedRow(inComponent: 0)
         self.destinationPicker.selectRow(0, inComponent: 0, animated: false)
         destinationTF.text = destinationCities[row]
         self.view.endEditing(true)
     }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sourcePicker {
            return sourceCities.count
        }
        return destinationCities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sourcePicker {
            return sourceCities[row]
        }
        return destinationCities[row]
    }
}

extension LandingHomeScreen {
    func searchTrains() {
        createTrainData()
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "TrainListVC") as! TrainListVC
        vc.source = sourceTF.text!
        vc.destination = destinationTF.text!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func createTrainData() {
        trains.removeAll()
        let trainsToShow = Int.random(in: 1...5)
        for i in legacyTrains {
            if sourceTF.text! == i.source, destinationTF.text! == i.destination, dateTF.text! == i.date, timeTF.text! == i.time {
                trains.append(i)
            }
        }
        
        while trains.count < trainsToShow {
            trains.append(Train(name: "Train \(randomString(length: 5))",
                                source: sourceTF.text!,
                                destination: destinationTF.text!,
                                time: timeTF.text!,
                                date: dateTF.text!,
                                reservedSeats: [],
                                ticketFee: Int.random(in: 5...10)))
        }
    }
    
    func randomString(length: Int) -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
