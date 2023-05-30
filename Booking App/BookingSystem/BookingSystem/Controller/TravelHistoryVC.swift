//
//  SeatMapVC.swift
//  BookingSystem
//
//  Created by Macbook on 19/05/2023.
//

import UIKit

class TravelHistoryVC: UIViewController {

    @IBOutlet weak var countLBL: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.tableFooterView = UIView()
        myTableView.register(UINib(nibName: "TravelHistoryTVC", bundle: nil), forCellReuseIdentifier: "TravelHistoryTVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = "Travel History"
        countLBL.text = "\(history.count)"
    }
}

extension TravelHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "TravelHistoryTVC", for: indexPath) as! TravelHistoryTVC
        cell.delegate = self
        cell.setContent(item: history[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension TravelHistoryVC: TravelHistory {
    func deletePressed(cell: TravelHistoryTVC) {
        guard let index = myTableView.indexPath(for: cell)?.row else { return }
        let currentHistory = history[index]
        
        history.remove(at: index)
        for i in 0..<legacyTrains.count where legacyTrains[i].name == currentHistory.train.name {
            for j in 0..<legacyTrains[i].reservedSeats.count {
                if legacyTrains[i].reservedSeats[j] == currentHistory.seatNo {
                    legacyTrains[i].reservedSeats.remove(at: j)
                    break
                }
            }
        }
        myTableView.reloadData()
    }
}
