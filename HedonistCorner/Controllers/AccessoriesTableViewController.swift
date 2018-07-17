//
//  AccessoriesTableViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 7/10/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AccessoriesTableViewController: UITableViewController {

    //MARK: Properties
    
    var  ref: DatabaseReference?
    
    //MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        readingDataFromFirebase()
        navigationItem.title = "Accessories"
        tableView.backgroundColor = UIColor.orange
    }
    
    //MARK: Methods
    
    private func readingDataFromFirebase() {
        
        ref?.child("accessoriesData").observe(.value, with: { (snapshot) in
            for accessories in snapshot.children {
                guard let snap = accessories as? DataSnapshot else {return}
                guard let accessoriesData = snap.value as? [String: Any] else {return}
                let accessoriesName = accessoriesData["name"] as? String ?? ""
                let accessoriesText = accessoriesData["text"] as? String ?? ""
                guard let accessories = accessoriesData["accessories"] as? [String: [String: Any]] else {return}
                let sortedAccessories = accessories.sorted {$0.key < $1.key}

                var accessoriesNames = [String]()
                var accessoriesPictures = [String]()
                
                for i in sortedAccessories {
                    let name = i.value["name"] as? String ?? ""
                    accessoriesNames.append(name)
                    let pictureOfAccessories = i.value["picture"] as? String ?? ""
                    accessoriesPictures.append(pictureOfAccessories)
                }
                accessoriesForCigars.append(AccessoriesData(accessoriesName: accessoriesName, accessoriesText: accessoriesText, accessoriesNames: accessoriesNames, accessoriesPictures: accessoriesPictures))
            }
            self.tableView.reloadData()
        })
    }
    
    //MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return accessoriesForCigars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccessoriesCell", for: indexPath)
        cell.textLabel?.text = accessoriesForCigars[indexPath.row].accessoriesName
        cell.textLabel?.font = UIFont(name: "Marker Felt", size: 25)
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.orange
        cell.tintColor = UIColor.black
        
        return cell
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailVC" {
            if let detailAccessoriesVC = segue.destination as? DetailAccessoriesTableViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let accessoriesData: AccessoriesData
                    accessoriesData = accessoriesForCigars[indexPath.row]
                    detailAccessoriesVC.detailOfAccessories = accessoriesData
                }
            }
            
        } else if segue.identifier == "infoVC" {
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
