//
//  CigarAndSpiritTableViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 7/14/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import Firebase

class CigarAndSpiritTableViewController: UITableViewController {

    //MARK: Properties
    
    private var cigarAndSpirits = [CigarAndSpirit]()
    private var ref: DatabaseReference?
    private var lastCell = CigarAndSpiritCell()
    private var buttonTag = -1
    
    //MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = K.Names.cigarAndSpirit
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: K.PictureNames.backgroundImage)!)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        ref = Database.database().reference()
        readingDataFromFirebase()
        tableView.register(UINib(nibName: K.TableViewCellNibName.cigarAndSpirit, bundle: nil), forCellReuseIdentifier: K.CellIdentifier.cigarAndSpiritCell)
    }
    
    //MARK: Methods
    
    private func readingDataFromFirebase() {
                
        ref?.child(K.FirebaseCollectionNames.cigarAndSpiritData).observe(.value, with: {[weak self] (snapshot) in
            guard let self = self else {return}
            for child in snapshot.children {
                guard let snap = child as? DataSnapshot else {return}
                guard let childData = snap.value as? [String: Any] else {return}
                let cigarAndSpiritName = childData[K.FirebaseCollectionNames.brend] as? String ?? ""
                let cigarAndSpiritTetx = childData[K.FirebaseCollectionNames.text] as? String ?? ""
                self.cigarAndSpirits.append(CigarAndSpirit(cigarAndSpiritName: cigarAndSpiritName, cigarAndSpiritText: cigarAndSpiritTetx))
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
        if sender.tag == previousTag {
            lastCell = CigarAndSpiritCell()
            buttonTag = -1
        }
        if sender.tag != previousTag {
            buttonTag = sender.tag
            lastCell = tableView.cellForRow(at: IndexPath(row: buttonTag, section: 0)) as! CigarAndSpiritCell
            lastCell.animation(duration: 0.5, c: {
                self.view.layoutIfNeeded()
            })
        }
        tableView.endUpdates()
    }

    //MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cigarAndSpirits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.cigarAndSpiritCell, for: indexPath) as! CigarAndSpiritCell
        
        cell.openView.backgroundColor = UIColor.orange
        cell.detailView.backgroundColor = UIColor(patternImage: UIImage(named: K.PictureNames.backgroundImage) ?? UIImage() ).withAlphaComponent(0.5)
        cell.buttonName.setTitle(cigarAndSpirits[indexPath.row].cigarAndSpiritName, for: .normal)
        cell.buttonName.titleLabel?.adjustsFontSizeToFitWidth = true
        cell.buttonName.addTarget(self, action: #selector(handleOpenedCell), for: .touchUpInside)
        cell.buttonName.tag = indexPath.row
        cell.cigarAndSpiritLabel?.text = cigarAndSpirits[indexPath.row].cigarAndSpiritText
        cell.cellExist = true
        
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
}
