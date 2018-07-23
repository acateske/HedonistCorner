//
//  PointOfSaleTableViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 7/15/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PointOfSaleTableViewController: UITableViewController {

    //MARK: Properties
    
    var ref: DatabaseReference?
    var lastCell = PointOfSaleTableViewCell()
    var buttonTag = -1
    
    //MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Point of Sale"
        tableView.allowsSelection = false
        ref = Database.database().reference()
        readingDataFromFirebase()
    }
    
    //MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pointOfSale.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("PointOfSaleTableViewCell", owner: self, options: nil)?.first as! PointOfSaleTableViewCell
        
        cell.storeNameLabel?.text = pointOfSale[indexPath.row].storeName
        cell.storeImage?.sd_setImage(with: URL(string: pointOfSale[indexPath.row].storeImage))
        cell.storeAddressLabel?.text = pointOfSale[indexPath.row].storeAddress
        cell.storePhoneLabel?.text = pointOfSale[indexPath.row].storePhone
        cell.mondayWorkingTime?.text = pointOfSale[indexPath.row].mondayWorkTime
        cell.tuesdayWorkingTime?.text = pointOfSale[indexPath.row].tuesdayWorkTime
        cell.wednesdayWorkingTime?.text = pointOfSale[indexPath.row].wednesdayWorkTime
        cell.thursdayWorkingTime?.text = pointOfSale[indexPath.row].thursdayWorkTime
        cell.fridayWorkingTime?.text = pointOfSale[indexPath.row].fridayWorkTime
        cell.saturdayWorkingTime?.text = pointOfSale[indexPath.row].saturdayWorkTime
        cell.sundayWorkingTime?.text = pointOfSale[indexPath.row].sundayWorkTime
        cell.workingTimeButton.tag = indexPath.row
        cell.workingTimeButton.addTarget(self, action: #selector(handleOpenedCell), for: .touchUpInside)
        cell.workingTimeButton.setTitle("More", for: .normal)
        cell.cellExist = true
        
        UIView.animate(withDuration: 0.5) {
            cell.contentView.layoutIfNeeded()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == buttonTag {
            return 680
        } else {
            return 390
        }
    }
    
    //MARK: Methods
    
    private func readingDataFromFirebase() {
        
        pointOfSale = [PointOfSale]()
        ref?.child("pointOfSaleData").observe(.value, with: { (snapshot) in
            
            for child in snapshot.children {
                guard let snap = child as? DataSnapshot else {return}
                guard let childData = snap.value as? [String: Any] else {return}
                let storeName = childData["name"] as? String ?? ""
                let storeImage = childData["picture"] as? String ?? ""
                let storeAddress = childData["address"] as? String ?? ""
                let phone = childData["phone"] as? String ?? ""
                let mondayWorkTime = childData["mondayWorkTime"] as? String ?? ""
                let tuesdayWorkTime = childData["tuesdayWorkTime"] as? String ?? ""
                let wednesdayWorkTime = childData["wednesdayWorkTime"] as? String ?? ""
                let thursdayWorkTime = childData["thursdayWorkTime"] as? String ?? ""
                let fridayWorkTime = childData["fridayWorkTime"] as? String ?? ""
                let saturdayWorkTime = childData["saturdayWorkTime"] as? String ?? ""
                let sundayWorkTime = childData["sundayWorkTime"] as? String ?? ""
                
                pointOfSale.append(PointOfSale(storeName: storeName, storeImage: storeImage, storeAddress: storeAddress, storePhone: phone, mondayWorkTime: mondayWorkTime, tuesdayWorkTime: tuesdayWorkTime, wednesdayWorkTime: wednesdayWorkTime, thursdayWorkTime: thursdayWorkTime, fridayWorkTime: fridayWorkTime, saturdayWorkTime: saturdayWorkTime, sundayWorkTime: sundayWorkTime))
            }
            self.tableView.reloadData()
        })
    }
    
    @objc private func handleOpenedCell(sender: UIButton) {
        
        tableView.beginUpdates()
        let previousTag = buttonTag
        
        if lastCell.cellExist {
            lastCell.animation(duration: 0.5, c: {
                self.view.layoutIfNeeded()
            })
        }
        if sender.tag != previousTag {
            buttonTag = sender.tag
            lastCell = tableView.cellForRow(at: IndexPath(row: buttonTag, section: 0)) as! PointOfSaleTableViewCell
            lastCell.animation(duration: 0.5, c: {
                self.view.layoutIfNeeded()
            })
        }
        if sender.tag == previousTag {
            lastCell = PointOfSaleTableViewCell()
            buttonTag = -1
        }
        tableView.endUpdates()
    }
}
