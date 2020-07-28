//
//  GuidelinesTableViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 6/28/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import Firebase

class GuidelinesTableViewController: UITableViewController {

    //MARK: Properties
    
    private var guideliness = [Guideliness]()
    private var ref: DatabaseReference?
    
    //MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        title = K.Names.guide
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: K.PictureNames.backgroundImage) ?? UIImage())
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        readingDataFromFirebase()
    }
    //MARK: - ReadingData Methods
    
    private func readingDataFromFirebase() {
        
        ref?.child(K.FirebaseCollectionNames.quide).observe(.value, with: {[weak self] (snapshot) in
            guard let self = self else {return}
            for guide in snapshot.children {
                guard let guideData = guide as? DataSnapshot else {return}
                let guideText = guideData.value as? String ?? ""
                self.guideliness.append(Guideliness(guide: guideText))
            }
           self.tableView.reloadData()
        })
    }
    
    //MARK: - UITableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guideliness.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.guideCell, for: indexPath) as! GuidelinesCell
        cell.guideLabel?.text = guideliness[indexPath.row].guide
        cell.selectionStyle = .none
        cell.backgroundColor = K.background_color.withAlphaComponent(0.2)
        return cell
    }
}
