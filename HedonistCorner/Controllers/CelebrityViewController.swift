//
//  ViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 6/26/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CelebrityViewController: UIViewController {
    
    //MARK: Properties
    
    var ref: DatabaseReference?
    var menuOpen = false
    @IBOutlet weak var sideMenuConstraints: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMenu: UIView! {
        
        didSet {
            viewMenu.backgroundColor = UIColor(patternImage: UIImage(named: "cigarLeaves")!)
        }
    }
    
    //MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        ref = Database.database().reference()
        navigationItem.title = "Celebrities and their Favorite Cigars"
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSideMenu)))
        tableView.allowsSelection = false
        readingDataFromFirebase()
    }
    
    //MARK: Methods
    
    @IBAction func menuButton(_ sender: UIBarButtonItem) {
        
        if menuOpen {
            tableView.alpha = 1.0
            sideMenuConstraints.constant = -150
            menuOpen = false
        } else {
            tableView.alpha = 0.5
            sideMenuConstraints.constant = 0
            menuOpen = true
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc private func handleSideMenu() {
        
        if menuOpen {
            tableView.alpha = 1.0
            sideMenuConstraints.constant = -150
            menuOpen = false
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func readingDataFromFirebase() {
        
        ref?.child("celebritiesAndTheirFavoriteCigars")
            .observe(.value, with: { (snapshot) in
                
            guard let snap = snapshot.value as? [String: [String:Any]] else {return}
            
            for celebrity in snap.values {
                
                let textAboutCelebrity = celebrity["text"] as? String ?? ""
                let pictureAboutCelebrity = celebrity["picture"] as? String ?? ""
                celebritiesAndTheirFavoriteCigars.append(CelebritiesAndTheirFavoriteCigars(textAboutCelebrity: textAboutCelebrity, pictureAboutCelebrity: pictureAboutCelebrity))
            }
            self.tableView.reloadData()
        })
    }
}

extension CelebrityViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return celebritiesAndTheirFavoriteCigars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CelebrityCell", for: indexPath) as! CelebrityTableViewCell
        cell.celebrityText?.text = celebritiesAndTheirFavoriteCigars[indexPath.row].textAboutCelebrity
        cell.celebrityImage?.sd_setImage(with: URL(string: celebritiesAndTheirFavoriteCigars[indexPath.row].pictureAboutCelebrity))
        
        UIView.animate(withDuration: 0.5) {
            cell.contentView.layoutIfNeeded()
        }
        return cell
    }
}

