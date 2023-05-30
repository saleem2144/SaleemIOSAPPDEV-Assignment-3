//
//  PaymentVC.swift
//  BookingSystem
//
//  Created by MacBook Pro  on 20/05/2023.
//

import UIKit

class PaymentVC: UIViewController {
    
    var selectedSeat = 0
    var selectedTrain: Train!

    @IBOutlet weak var sourceLBL: UILabel!
    @IBOutlet weak var destinationLBL: UILabel!
    @IBOutlet weak var dateLBL: UILabel!
    @IBOutlet weak var timeLBL: UILabel!
    @IBOutlet weak var trainNameLBL: UILabel!
    @IBOutlet weak var seatNoLBL: UILabel!
    
    @IBOutlet weak var amountLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceLBL.text = selectedTrain.source
        destinationLBL.text = selectedTrain.destination
        dateLBL.text = selectedTrain.date
        timeLBL.text = selectedTrain.time
        trainNameLBL.text = selectedTrain.name
        seatNoLBL.text = "Seat# \(selectedSeat)"
        amountLBL.text = "Amount: \(selectedTrain.ticketFee)$"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = "Payment"
    }
    
    @IBAction func confirmBtnPressed(_ sender: UIButton) {
        selectedTrain.reservedSeats.append(selectedSeat)
        if legacyTrains.filter({$0.name == selectedTrain.name}).isEmpty { // Check if train is not already saved
            legacyTrains.append(selectedTrain)
        }
        
        history.append(History(seatNo: selectedSeat, train: selectedTrain))
        
        showSimpleAlert(title: "Success!", Body: "You have successfully booked seat# \(selectedSeat) of \(selectedTrain.name)") { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
