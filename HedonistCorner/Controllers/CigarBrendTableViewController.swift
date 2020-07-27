//
//  CigarBrendTableViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 6/30/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import Firebase

class CigarBrendTableViewController: UITableViewController {
    
    //MARK: Properties
    
    private var cigarBrandsData = [CigarBrands]()
    private var filteredCigarBrandsData = [CigarBrands]()
    private var ref: DatabaseReference?
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = K.PlaceholderNames.cigarBrend
        }
    }
    
    //MARK: View

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        title = K.Names.cigarBrend
        searchBar.delegate = self
        readingDataFromFirebase()
    }
    
    //MARK: ReadingData Methods
    
    private func readingDataFromFirebase() {

        ref?.child(K.FirebaseCollectionNames.cigarBrend).observe(.value, with: {[weak self] (snapshot) in
            guard let self = self else {return}
            for brand in snapshot.children {
                guard let snap = brand as? DataSnapshot else {return}
                guard let brandData = snap.value as? [String: Any] else {return}
                let brandName = brandData[K.FirebaseCollectionNames.brend] as? String ?? ""
                let brandPicture = brandData[K.PictureNames.image] as? String ?? ""
                let brandText = brandData[K.FirebaseCollectionNames.text] as? String ?? ""
                guard let cigarsData = brandData[K.FirebaseCollectionNames.cigars] as? [String: [String: Any]] else {return}
                let sortedCigarsData = cigarsData.sorted {$0.key < $1.key}
                
                var cigarNames = [String]()
                var cigarPictures = [String]()
                var cigarTexts = [String]()
                var cigarStrenghts = [String]()
                var cigarRingGauges = [String]()
                var cigarLengts = [String]()
                var cigarFactoryNames = [String]()
                
                for cigar in sortedCigarsData {
                    let cigarName = cigar.value[K.FirebaseCollectionNames.brend] as? String ?? ""
                    cigarNames.append(cigarName)
                    let cigarPicture = cigar.value[K.PictureNames.image] as? String ?? ""
                    cigarPictures.append(cigarPicture)
                    let cigarText = cigar.value[K.FirebaseCollectionNames.text] as? String ?? ""
                    cigarTexts.append(cigarText)
                    let cigarStrenght = cigar.value[K.FirebaseCollectionNames.cigarStrenght] as? String ?? ""
                    cigarStrenghts.append(cigarStrenght)
                    let cigarRingGauge = cigar.value[K.FirebaseCollectionNames.cigarRingGauge] as? String ?? ""
                    cigarRingGauges.append(cigarRingGauge)
                    let cigarLengt = cigar.value[K.FirebaseCollectionNames.cigarLengt] as? String ?? ""
                    cigarLengts.append(cigarLengt)
                    let cigarFactoryName = cigar.value[K.FirebaseCollectionNames.cigarFactory] as? String ?? ""
                    cigarFactoryNames.append(cigarFactoryName)
                }
                self.cigarBrandsData.append(CigarBrands(cigarBrandName: brandName, cigarBrandPicture: brandPicture, cigarBrandText: brandText, cigarNames: cigarNames, cigarTexts: cigarTexts, cigarPictures: cigarPictures, cigarStrenghts: cigarStrenghts, cigarRingGauges: cigarRingGauges, cigarLengts: cigarLengts, cigarFactoryNames: cigarFactoryNames))
            }
            self.tableView.reloadData()
        })
    }
    
    //MARK: UITableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarIsEmpty() {
            return cigarBrandsData.count
        } else {
            return filteredCigarBrandsData.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.cigarBrendCell, for: indexPath) as! CigarBrendTableViewCell
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
    
    //MARK: Navigation Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == K.Seque.selectedCigarSeque {
            if let selectedCigarBrandVC = segue.destination as? SelectedCigarBrendTableViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let cigarBrand: CigarBrands
                    if searchBarIsEmpty() {
                        cigarBrand = cigarBrandsData[indexPath.row]
                    } else {
                        cigarBrand = filteredCigarBrandsData[indexPath.row]
                    }
                    selectedCigarBrandVC.selectedCigarBrand = cigarBrand
                    tableView.endEditing(true)
                }
            }
        } else if segue.identifier == K.Seque.infoCigarSeque {
            if let infoCigarBrandVC = segue.destination as? InfoCigarBrendViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let cigarBrand: CigarBrands
                    if searchBarIsEmpty() {
                        cigarBrand = cigarBrandsData[indexPath.row]
                    } else {
                        cigarBrand = filteredCigarBrandsData[indexPath.row]
                    }
                    infoCigarBrandVC.infoCigarBrandVC = cigarBrand
                    tableView.endEditing(true)
                }
            }
        }
    }
}

//MARK: - UISearchBarDelegate Methods

extension CigarBrendTableViewController: UISearchBarDelegate {
    
    //MARK: Setup SearchBar
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCigarBrandsData = cigarBrandsData.filter { (cigarBrand) -> Bool in
            cigarBrand.cigarBrandName.contains(searchText)
        }
        tableView.reloadData()
    }
}
