//
//  PointOfSaleTableViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 7/15/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import Firebase

class PointOfSaleTableViewController: UITableViewController {

    //MARK: Properties
    
    private var pointOfSale = [PointOfSale]()
    private var ref: DatabaseReference?
    private var lastCell = PointOfSaleCell()
    private var buttonTag = -1
    
    //MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = K.Names.salePoint
        tableView.allowsSelection = false
        ref = Database.database().reference()
        readingDataFromFirebase()
        tableView.register(UINib(nibName: K.TableViewCellNibName.salePoint, bundle: nil), forCellReuseIdentifier: K.CellIdentifier.pointOfSaleCell)
    }
    
    //MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pointOfSale.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.pointOfSaleCell, for: indexPath) as! PointOfSaleCell
        
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
        cell.workingTimeButton.setTitle(K.Names.buttonTittle, for: .normal)
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
    
    //MARK: ReadingData Methods
    
    private func readingDataFromFirebase() {
        
        ref?.child(K.FirebaseCollectionNames.salePointData).observe(.value, with: {[weak self] (snapshot) in
            guard let self = self else {return}
            for child in snapshot.children {
                guard let snap = child as? DataSnapshot else {return}
                guard let childData = snap.value as? [String: Any] else {return}
                let storeName = childData[K.FirebaseCollectionNames.brend] as? String ?? ""
                let storeImage = childData[K.PictureNames.image] as? String ?? ""
                let storeAddress = childData[K.FirebaseCollectionNames.address] as? String ?? ""
                let phone = childData[K.FirebaseCollectionNames.phone] as? String ?? ""
                let mondayWorkTime = childData[K.FirebaseCollectionNames.mondayWorkTime] as? String ?? ""
                let tuesdayWorkTime = childData[K.FirebaseCollectionNames.tuesdayWorkTime] as? String ?? ""
                let wednesdayWorkTime = childData[K.FirebaseCollectionNames.wednesdayWorkTime] as? String ?? ""
                let thursdayWorkTime = childData[K.FirebaseCollectionNames.thursdayWorkTime] as? String ?? ""
                let fridayWorkTime = childData[K.FirebaseCollectionNames.fridayWorkTime] as? String ?? ""
                let saturdayWorkTime = childData[K.FirebaseCollectionNames.saturdayWorkTime] as? String ?? ""
                let sundayWorkTime = childData[K.FirebaseCollectionNames.sundayWorkTime] as? String ?? ""
                self.pointOfSale.append(PointOfSale(storeName: storeName, storeImage: storeImage, storeAddress: storeAddress, storePhone: phone, mondayWorkTime: mondayWorkTime, tuesdayWorkTime: tuesdayWorkTime, wednesdayWorkTime: wednesdayWorkTime, thursdayWorkTime: thursdayWorkTime, fridayWorkTime: fridayWorkTime, saturdayWorkTime: saturdayWorkTime, sundayWorkTime: sundayWorkTime))
            }
            self.tableView.reloadData()
        })
    }
    //MARK: - OpenCloseCell Methods
    
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
            lastCell = tableView.cellForRow(at: IndexPath(row: buttonTag, section: 0)) as! PointOfSaleCell
            lastCell.animation(duration: 0.5, c: {
                self.view.layoutIfNeeded()
            })
        }
        if sender.tag == previousTag {
            lastCell = PointOfSaleCell()
            buttonTag = -1
        }
        tableView.endUpdates()
    }
}
