//
//  DetailAccessoriesTableViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 7/12/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class DetailAccessoriesTableViewController: UITableViewController {

    //MARK: Properties
    
    private var accessoriesPictures = [String]()
    private var accessoriesNames = [String]()
    var detailOfAccessories: AccessoriesData? {
        didSet {
            configurationView()
        }
    }
    
    //MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        title = detailOfAccessories?.accessoriesName
    }

    //MARK: Methods
    
    private func configurationView() {
        if let detailOfAccessories = detailOfAccessories {
            accessoriesNames = detailOfAccessories.accessoriesNames
            accessoriesPictures = detailOfAccessories.accessoriesPictures
        }
    }
    
    //MARK: UITableViewDatasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accessoriesNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.detailAccessoriesCell, for: indexPath) as! DetailAccessoriesCell
        cell.nameOfAccessories?.text = accessoriesNames[indexPath.row]
        cell.imageOfAccessories?.sd_setImage(with: URL(string: accessoriesPictures[indexPath.row]))
        
        UIView.animate(withDuration: 0.5) {
            cell.contentView.layoutIfNeeded()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360
    }
}
