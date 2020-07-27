//
//  CigarArtTableViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 7/13/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import Firebase

class CigarArtTableViewController: UITableViewController {

    //MARK: Properties
    
    var cigarArts = [CigarArt]()
    var ref: DatabaseReference?
    var lastCell = CigarArtTableViewCell()
    var buttonTag = -1
    
    //MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        title = K.Names.cigarArt
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: K.PictureNames.backgroundImage)!)
        readingDataFromFirebase()
    }

    private func readingDataFromFirebase() {
                
        ref?.child(K.FirebaseCollectionNames.cigarArtData).observe(.value, with: {[weak self] (snapshot) in
            guard let self = self else {return}
            for i in snapshot.children {
                guard let snap = i as? DataSnapshot else {return}
                guard let cigarsData = snap.value as? [String: Any] else {return}
                let cigarArtName = cigarsData[K.FirebaseCollectionNames.brend] as? String ?? ""
                let cigarArtText = cigarsData[K.FirebaseCollectionNames.text] as? String ?? ""
                self.cigarArts.append(CigarArt(cigarArtName: cigarArtName, cigarArtText: cigarArtText))
            }
            self.tableView.reloadData()
        })
    }
    
    //MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cigarArts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed(K.CellIdentifier.cigarArtCell, owner: self, options: nil)?.first as! CigarArtTableViewCell
        
        if !cell.cellExist {
            cell.openView.backgroundColor = UIColor.orange
            cell.buttonName.setTitle(cigarArts[indexPath.row].cigarArtName, for: .normal)
            cell.buttonName.titleLabel?.adjustsFontSizeToFitWidth = true
            cell.detailView.backgroundColor = UIColor(patternImage: UIImage(named: K.PictureNames.backgroundImage)!).withAlphaComponent(0.5)
            cell.buttonName.addTarget(self, action: #selector(handleOpenedCell), for: .touchUpInside)
            cell.cigarArtLabel?.text = cigarArts[indexPath.row].cigarArtText
            cell.buttonName.tag = indexPath.row
            cell.cellExist = true
        } else {
            cell.buttonName.tag = indexPath.row
        }
        
        UIView.animate(withDuration: 0.5) {
            cell.contentView.layoutIfNeeded()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == buttonTag {
            return 400
        } else {
            return 80
        }
    }
    
    //MARK: Methods
    
    @objc private func handleOpenedCell(sender: UIButton) {
        
        tableView.beginUpdates()
        let previousTag = buttonTag
        
        if lastCell.cellExist {
            lastCell.animation(duration: 0.5, c: {
                self.view.layoutIfNeeded()
            })
        }
        if sender.tag == buttonTag {
            buttonTag = -1
            lastCell = CigarArtTableViewCell()
        }
        if sender.tag != previousTag {
            buttonTag = sender.tag
            lastCell = tableView.cellForRow(at: IndexPath(row: buttonTag, section: 0)) as! CigarArtTableViewCell
            lastCell.animation(duration: 0.5, c: {
                self.view.layoutIfNeeded()
            })
        }
        tableView.endUpdates()
    }
}
