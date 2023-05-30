//
//  SeatMapVC.swift
//  BookingSystem
//
//  Created by Macbook on 19/05/2023.
//

import UIKit

class SeatMapVC: UIViewController {

    var selectedSeat = 0
    var selectedTrain: Train!
    
    @IBOutlet weak var dateLBL: UILabel!
    @IBOutlet weak var timeLBL: UILabel!
    @IBOutlet var seatBTN: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func bookBtnPressed(_ sender: UIButton) {
        if selectedSeat == 0 {
            showSimpleAlert(title: "Oops!", Body: "Please select seat to continue") { _ in }
            return
        }
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
        vc.selectedTrain = selectedTrain
        vc.selectedSeat = selectedSeat
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func seatBtnPressed(_ sender: UIButton) {
        // Check if user has clicked on already reserved seat
        for i in selectedTrain.reservedSeats {
            if i == sender.tag { return }
        }
        
        // Check if user has already selected some seat so unselect it
        if selectedSeat != 0, selectedSeat != sender.tag {
            setSeatsUI()
        }
        
        sender.backgroundColor = .green
        selectedSeat = sender.tag
    }
}

extension SeatMapVC {
    func setupUI() {
        dateLBL.text = selectedTrain.date
        timeLBL.text = selectedTrain.time
        self.navigationItem.title = selectedTrain.name
        setSeatsUI()
    }
    
    func setSeatsUI() {
        seatBTN.forEach { btn in
            btn.backgroundColor = .systemGray5
        }
        
        for seat in seatBTN {
            for i in selectedTrain.reservedSeats {
                if seat.tag == i {
                    seat.backgroundColor = .red
                }
            }
        }
    }
}
