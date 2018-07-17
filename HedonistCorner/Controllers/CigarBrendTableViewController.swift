//
//  CigarBrendTableViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 6/30/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CigarBrendTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var ref: DatabaseReference?
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = "Search for Cigar Brand"
        }
    }
    
    //MARK: View

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        navigationItem.title = "Cigar Brands"
        searchBar.delegate = self
        readingDataFromFirebase()
    }
    
    //MARK: Methods
    
    private func readingDataFromFirebase() {
        
        cigarBrandsData = [CigarBrands]()
        
        ref?.child("cigarBrandsData").observe(.value, with: { (snapshot) in
            
            for brand in snapshot.children {
                guard let snap = brand as? DataSnapshot else {return}
                guard let brandData = snap.value as? [String: Any] else {return}
                let brandName = brandData["name"] as? String ?? ""
                let brandPicture = brandData["picture"] as? String ?? ""
                let brandText = brandData["text"] as? String ?? ""
                guard let cigarsData = brandData["cigars"] as? [String: [String: Any]] else {return}
                let sortedCigarsData = cigarsData.sorted {$0.key < $1.key}
                
                var cigarNames = [String]()
                var cigarPictures = [String]()
                var cigarTexts = [String]()
                var cigarStrenghts = [String]()
                var cigarRingGauges = [String]()
                var cigarLengts = [String]()
                var cigarFactoryNames = [String]()
                
                for cigar in sortedCigarsData {
                    let cigarName = cigar.value["name"] as? String ?? ""
                    cigarNames.append(cigarName)
                    let cigarPicture = cigar.value["picture"] as? String ?? ""
                    cigarPictures.append(cigarPicture)
                    let cigarText = cigar.value["text"] as? String ?? ""
                    cigarTexts.append(cigarText)
                    let cigarStrenght = cigar.value["strenght"] as? String ?? ""
                    cigarStrenghts.append(cigarStrenght)
                    let cigarRingGauge = cigar.value["ringGauge"] as? String ?? ""
                    cigarRingGauges.append(cigarRingGauge)
                    let cigarLengt = cigar.value["lengt"] as? String ?? ""
                    cigarLengts.append(cigarLengt)
                    let cigarFactoryName = cigar.value["factoryName"] as? String ?? ""
                    cigarFactoryNames.append(cigarFactoryName)
                }
                cigarBrandsData.append(CigarBrands(cigarBrandName: brandName, cigarBrandPicture: brandPicture, cigarBrandText: brandText, cigarNames: cigarNames, cigarTexts: cigarTexts, cigarPictures: cigarPictures, cigarStrenghts: cigarStrenghts, cigarRingGauges: cigarRingGauges, cigarLengts: cigarLengts, cigarFactoryNames: cigarFactoryNames))
            }
            self.tableView.reloadData()
        })
    }
    
    //MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchBarIsEmpty() {
            return cigarBrandsData.count
        } else {
            return filteredCigarBrandsData.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CigarBrend", for: indexPath) as! CigarBrendTableViewCell
        cell.tintColor = UIColor.black
        
        if searchBarIsEmpty() {
            cell.cigarBrendName?.text = cigarBrandsData[indexPath.row].cigarBrandName
            cell.cigarBrendImage?.sd_setImage(with: URL(string: cigarBrandsData[indexPath.row].cigarBrandPicture))
        } else {
            cell.cigarBrendName?.text = filteredCigarBrandsData[indexPath.row].cigarBrandName
            cell.cigarBrendImage?.sd_setImage(with: URL(string: filteredCigarBrandsData[indexPath.row].cigarBrandPicture))
        }
       
        UIView.animate(withDuration: 0.5) {
            cell.contentView.layoutIfNeeded()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SelectedCigarCell" {
            
            if let selectedCigarBrandVC = segue.destination as? SelectedCigarBrendTableViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let cigarBrand: CigarBrands
                    if searchBarIsEmpty() {
                        cigarBrand = cigarBrandsData[indexPath.row]
                    } else {
                        cigarBrand = filteredCigarBrandsData[indexPath.row]
                    }
                    selectedCigarBrandVC.selectedCigarBrand = cigarBrand
                }
            }
        } else if segue.identifier == "InfoCigarBrand" {
            
            if let infoCigarBrandVC = segue.destination as? InfoCigarBrendViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let cigarBrand: CigarBrands
                    if searchBarIsEmpty() {
                        cigarBrand = cigarBrandsData[indexPath.row]
                    } else {
                        cigarBrand = filteredCigarBrandsData[indexPath.row]
                    }
                    infoCigarBrandVC.infoCigarBrandVC = cigarBrand
                }
            }
        }
    }
}

extension CigarBrendTableViewController: UISearchBarDelegate {
    
    //MARK: Set up SearchBar
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

        searchBar.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarIsEmpty() -> Bool {
        
        return searchBar.text?.isEmpty ?? true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredCigarBrandsData = cigarBrandsData.filter({ (cigarBrand) -> Bool in
            cigarBrand.cigarBrandName.contains(searchText)
        })
        tableView.reloadData()
    }
}
