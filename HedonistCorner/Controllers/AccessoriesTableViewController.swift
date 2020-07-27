//
//  AccessoriesTableViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 7/10/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import Firebase

class AccessoriesTableViewController: UITableViewController {

    //MARK: Properties
    
    private var accessoriesForCigars = [AccessoriesData]()
    private var ref: DatabaseReference?
    
    //MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        readingDataFromFirebase()
        title = K.Names.accessories
        tableView.backgroundColor = UIColor.orange
    }
    
    //MARK: Methods
    
    private func readingDataFromFirebase() {
        
        ref?.child(K.FirebaseCollectionNames.accessoriesData).observe(.value, with: {[weak self] (snapshot) in
            guard let self = self else {return}
            for accessories in snapshot.children {
                guard let snap = accessories as? DataSnapshot else {return}
                guard let accessoriesData = snap.value as? [String: Any] else {return}
                let accessoriesName = accessoriesData[K.FirebaseCollectionNames.brend] as? String ?? ""
                let accessoriesText = accessoriesData[K.FirebaseCollectionNames.text] as? String ?? ""
                guard let accessories = accessoriesData[K.FirebaseCollectionNames.accessories] as? [String: [String: Any]] else {return}
                let sortedAccessories = accessories.sorted {$0.key < $1.key}

                var accessoriesNames = [String]()
                var accessoriesPictures = [String]()
                
                for i in sortedAccessories {
                    let name = i.value[K.FirebaseCollectionNames.brend] as? String ?? ""
                    accessoriesNames.append(name)
                    let pictureOfAccessories = i.value[K.PictureNames.image] as? String ?? ""
                    accessoriesPictures.append(pictureOfAccessories)
                }
                self.accessoriesForCigars.append(AccessoriesData(accessoriesName: accessoriesName, accessoriesText: accessoriesText, accessoriesNames: accessoriesNames, accessoriesPictures: accessoriesPictures))
            }
            self.tableView.reloadData()
        })
    }
    
    //MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accessoriesForCigars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.accessoriesCell, for: indexPath)
        cell.textLabel?.text = accessoriesForCigars[indexPath.row].accessoriesName
        cell.textLabel?.font = UIFont(name: K.Names.fontName, size: 25)
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.orange
        cell.tintColor = UIColor.black
        
        return cell
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == K.Seque.detailAccessoryVC {
            if let detailAccessoriesVC = segue.destination as? DetailAccessoriesTableViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let accessoriesData: AccessoriesData
                    accessoriesData = accessoriesForCigars[indexPath.row]
                    detailAccessoriesVC.detailOfAccessories = accessoriesData
                }
            }
            
        } else if segue.identifier == K.Seque.infoAccessoryVC {
            if let infoAccessoriesVC = segue.destination as? InfoAccessoriesViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let accessoriesData: AccessoriesData
                    accessoriesData = accessoriesForCigars[indexPath.row]
                    infoAccessoriesVC.infoAboutAccessories = accessoriesData
                }
            }
        }
    }
}
