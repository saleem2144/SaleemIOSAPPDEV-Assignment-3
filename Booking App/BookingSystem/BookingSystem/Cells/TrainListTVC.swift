//
//  SeatMapVC.swift
//  BookingSystem
//
//  Created by Macbook on 19/05/2023.
//

import UIKit

class TrainListTVC: UITableViewCell {
    
    @IBOutlet weak var trainNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var trainImageView: UIImageView!
    @IBOutlet weak var amountLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setContent(item: Train) {
        trainNameLabel.text = item.name
        timeLabel.text = item.time
        dateLabel.text = item.date
        amountLBL.text = "\(item.ticketFee)$"
    }
}
