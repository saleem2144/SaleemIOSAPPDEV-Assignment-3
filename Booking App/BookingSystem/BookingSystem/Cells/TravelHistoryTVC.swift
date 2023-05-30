//
//  SeatMapVC.swift
//  BookingSystem
//
//  Created by Macbook on 19/05/2023.
//

import UIKit

protocol TravelHistory: AnyObject {
    func deletePressed(cell: TravelHistoryTVC)
}

class TravelHistoryTVC: UITableViewCell {
    weak var delegate: TravelHistory?

    @IBOutlet weak var deleteBTN: UIButton!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var seatNoLBL: UILabel!
    @IBOutlet weak var pathLBL: UILabel!
    @IBOutlet weak var amountLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setContent(item: History) {
        nameLBL.text = item.train.name
        seatNoLBL.text = "Seat# \(item.seatNo)"
        pathLBL.text = "\(item.train.source) to \(item.train.destination)"
        amountLBL.text = "\(item.train.ticketFee)$"
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        delegate?.deletePressed(cell: self)
    }
    
}
