//
//  SeatMapVC.swift
//  BookingSystem
//
//  Created by Macbook on 19/05/2023.
//

import UIKit

extension UIViewController{
    public func showSimpleAlert(title: String, Body: String, action: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "\(title)", message: "\(Body)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertAction.Style.default,
                                      handler: action))
        self.present(alert, animated: true, completion: nil)
    }
}
