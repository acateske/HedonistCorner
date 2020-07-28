//
//  SelectedCigarBrendTableViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 6/30/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class SelectedCigarBrendTableViewController: UITableViewController {

    //MARK: Properties
    
    private var selectedCigarBrandCigars = [SelectedCigarBrand]()
    private var filteredSelectedCigarBrandCigars = [SelectedCigarBrand]()
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = K.PlaceholderNames.searchCigars
        }
    }
    private var cigarNames = [String]()
    private var cigarPictures = [String]()
    private var cigarTexts = [String]()
    private var cigarStrenghts = [String]()
    private var cigarRingGauges = [String]()
    private var cigarLenghts = [String]()
    private var cigarFactories = [String]()
    
    var selectedCigarBrand: CigarBrands? {
        didSet {
            configurationView()
        }
    }
    
    //MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedCigarBrand?.cigarBrandName
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.separatorStyle = .none
        searchBar.delegate = self
    }
    
    //MARK: Methods
    
    private func configurationView() {
                
        if let selectedCigarBrand = selectedCigarBrand {
            cigarNames = selectedCigarBrand.cigarNames
            cigarPictures = selectedCigarBrand.cigarPictures
            cigarTexts = selectedCigarBrand.cigarTexts
            cigarStrenghts = selectedCigarBrand.cigarStrenghts
            cigarRingGauges = selectedCigarBrand.cigarRingGauges
            cigarLenghts = selectedCigarBrand.cigarLengts
            cigarFactories = selectedCigarBrand.cigarFactoryNames
        }
        for i in 0...cigarNames.count - 1 {
            selectedCigarBrandCigars.append(SelectedCigarBrand(cigarName: cigarNames[i], cigarText: cigarTexts[i], cigarPicture: cigarPictures[i], cigarStrenght: cigarStrenghts[i], cigarRingGauge: cigarRingGauges[i], cigarLengt: cigarLenghts[i], cigarFactoryName: cigarFactories[i]))
        }
    }
    
    //MARK: - UITableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchBarIsEmpty() {
            return selectedCigarBrandCigars.count
        } else {
            return filteredSelectedCigarBrandCigars.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.selectedCigarCell, for: indexPath) as!
        SelectedCigarCell
        
        if searchBarIsEmpty() {
            cell.cigarName?.text = selectedCigarBrandCigars[indexPath.row].cigarName
            cell.cigarPicture?.sd_setImage(with: URL(string: selectedCigarBrandCigars[indexPath.row].cigarPicture), placeholderImage: UIImage(named: K.PictureNames.placeholderImage), options: .continueInBackground)
            cell.cigarText?.text = selectedCigarBrandCigars[indexPath.row].cigarText
            cell.cigarStrenght?.text = selectedCigarBrandCigars[indexPath.row].cigarStrenght
            cell.cigarRingGauge?.text = selectedCigarBrandCigars[indexPath.row].cigarRingGauge
            cell.cigarLenght?.text = selectedCigarBrandCigars[indexPath.row].cigarLengt
            cell.cigarFactoryName?.text = selectedCigarBrandCigars[indexPath.row].cigarFactoryName
        } else {
            cell.cigarName?.text = filteredSelectedCigarBrandCigars[indexPath.row].cigarName
            cell.cigarPicture?.sd_setImage(with: URL(string: filteredSelectedCigarBrandCigars[indexPath.row].cigarPicture), placeholderImage: UIImage(named: K.PictureNames.placeholderImage), options: .continueInBackground)
            cell.cigarText?.text = filteredSelectedCigarBrandCigars[indexPath.row].cigarText
            cell.cigarStrenght?.text = filteredSelectedCigarBrandCigars[indexPath.row].cigarStrenght
            cell.cigarRingGauge?.text = filteredSelectedCigarBrandCigars[indexPath.row].cigarRingGauge
            cell.cigarLenght?.text = filteredSelectedCigarBrandCigars[indexPath.row].cigarLengt
            cell.cigarFactoryName?.text = filteredSelectedCigarBrandCigars[indexPath.row].cigarFactoryName
        }
        cell.selectionStyle = .none
        UIView.animate(withDuration: 0.5) {
            cell.contentView.layoutIfNeeded()
        }
       return cell
    }
}

//MARK: - UISearchBarDelegate Methods

extension SelectedCigarBrendTableViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
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
        filteredSelectedCigarBrandCigars = selectedCigarBrandCigars.filter({ (selectedCigar) -> Bool in
            selectedCigar.cigarName.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}
