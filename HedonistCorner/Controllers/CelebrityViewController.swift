//
//  ViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 6/26/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import Firebase

class CelebrityViewController: UIViewController {
    
//MARK: Properties
    
    private var celebritiesAndTheirFavoriteCigars = [CelebritiesAndTheirFavoriteCigars]()
    private var ref: DatabaseReference?
    private var menuOpen = false
    @IBOutlet weak var sideMenuConstraints: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMenu: UIView! {
        didSet {
            viewMenu.backgroundColor = UIColor(patternImage: UIImage(named: K.PictureNames.backgroundImage) ?? UIImage())
        }
    }
    
//MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        ref = Database.database().reference()
        title = K.Names.celebritiesCigars
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSideMenu)))
        tableView.allowsSelection = false
        readingDataFromFirebase()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
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
    
        ref?.child(K.FirebaseCollectionNames.celebritiesCigars)
            .observe(.value, with: {[weak self] (snapshot) in
                guard let self = self else {return}
                guard let snap = snapshot.value as? [String: [String:Any]] else {return}
                for celebrity in snap.values {
                    let textAboutCelebrity = celebrity[K.FirebaseCollectionNames.text] as? String ?? ""
                    let pictureAboutCelebrity = celebrity[K.PictureNames.image] as? String ?? ""
                    self.celebritiesAndTheirFavoriteCigars.append(CelebritiesAndTheirFavoriteCigars(textAboutCelebrity: textAboutCelebrity, pictureAboutCelebrity: pictureAboutCelebrity))
                }
                self.tableView.reloadData()
            })
    }
}

//MARK: - UITableViewDataSource Methods

extension CelebrityViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return celebritiesAndTheirFavoriteCigars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.celebrityCell, for: indexPath) as! CelebrityCell
        cell.celebrityText?.text = celebritiesAndTheirFavoriteCigars[indexPath.row].textAboutCelebrity
        cell.celebrityImage?.sd_setImage(with: URL(string: celebritiesAndTheirFavoriteCigars[indexPath.row].pictureAboutCelebrity))
        
        UIView.animate(withDuration: 0.5) {
            cell.contentView.layoutIfNeeded()
        }
        return cell
    }
}

