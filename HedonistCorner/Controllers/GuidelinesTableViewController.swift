//
//  GuidelinesTableViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 6/28/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import FirebaseDatabase

class GuidelinesTableViewController: UITableViewController {

    //MARK: Properties
    
    var ref: DatabaseReference?
    
    //MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        navigationItem.title = "Guideliness"
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "cigarLeaves")!)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        readingDataFromFirebase()
    }
    
    private func readingDataFromFirebase() {
        
        guideliness = [Guideliness]()
        ref?.child("guideliness").observe(.value, with: { (snapshot) in
            for guide in snapshot.children {
                guard let guideData = guide as? DataSnapshot else {return}
                let guideText = guideData.value as? String ?? ""
                guideliness.append(Guideliness(guide: guideText))
            }
           self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return guideliness.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuideCell", for: indexPath) as! GuidelinesTableViewCell
        cell.guideLabel?.text = guideliness[indexPath.row].guide
        cell.selectionStyle = .none
        cell.backgroundColor = Constants.background_color.withAlphaComponent(0.2)
        return cell
    }
}
