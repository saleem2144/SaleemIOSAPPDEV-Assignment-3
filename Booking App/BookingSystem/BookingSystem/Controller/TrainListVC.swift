//
//  SeatMapVC.swift
//  BookingSystem
//
//  Created by Macbook on 19/05/2023.
//

import UIKit

class TrainListVC: UIViewController {
    
    var source = ""
    var destination = ""

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var sourceLBL: UILabel!
    @IBOutlet weak var destinationLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.tableFooterView = UIView()
        myTableView.register(UINib(nibName: "TrainListTVC", bundle: nil), forCellReuseIdentifier: "TrainListTVC")
        
        sourceLBL.text = source
        destinationLBL.text = destination
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = "Available Trains"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
}

extension TrainListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trains.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "TrainListTVC", for: indexPath) as! TrainListTVC
        cell.setContent(item: trains[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyBoard.instantiateViewController(withIdentifier: "SeatMapVC") as! SeatMapVC
        vc.selectedTrain = trains[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}
