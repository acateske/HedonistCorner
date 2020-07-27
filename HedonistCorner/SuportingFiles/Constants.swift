//
//  Constants.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 6/26/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import Foundation

struct K {
    
    static let cornerRadius: CGFloat = 10
    static let masksToBounds: Bool = true
    static let background_color = UIColor.init(red: 50/255, green: 54/255, blue: 74/255, alpha: 1)
    static let minimumZoomScale: CGFloat = 1.0
    static let maximumZoomScale: CGFloat = 2.0
    static let lineWidth: CGFloat = 0.8
    
    struct Seque {
        static let startSeque = "startSeque"
        static let selectedCigarSeque = "SelectedCigarCell"
        static let infoCigarSeque = "InfoCigarBrand"
        static let detailAccessoryVC = "detailVC"
        static let infoAccessoryVC = "infoVC"
    }
    
    struct Names {
        static let appName = "HEDONIST CORNER"
        static let celebritiesCigars = "Celebrities and their Favorite Cigars"
        static let guide = "Guideliness"
        static let cigarBrend = "Cigar Brands"
        static let accessories = "Accessories"
        static let fontName = "Marker Felt"
        static let cigarArt = "Cigar Art"
        static let cigarAndSpirit = "Cigar and Spirit"
        static let salePoint = "Point of Sale"
        static let buttonTittle = "More"
    }
    
    struct FirebaseCollectionNames {
        static let celebritiesCigars = "celebritiesAndTheirFavoriteCigars"
        static let text = "text"
        static let quide = "guideliness"
        static let cigarBrend = "cigarBrandsData"
        static let brend = "name"
        static let cigars = "cigars"
        static let cigarStrenght = "strenght"
        static let cigarRingGauge = "ringGauge"
        static let cigarLengt = "lengt"
        static let cigarFactory = "factoryName"
        static let accessoriesData = "accessoriesData"
        static let accessories = "accessories"
        static let cigarArtData = "cigarArt"
        static let cigarAndSpiritData = "cigarAndSpirit"
        static let salePointData = "pointOfSaleData"
        static let address = "address"
        static let phone = "phone"
        static let mondayWorkTime = "mondayWorkTime"
        static let tuesdayWorkTime = "tuesdayWorkTime"
        static let wednesdayWorkTime = "wednesdayWorkTime"
        static let thursdayWorkTime = "thursdayWorkTime"
        static let fridayWorkTime = "fridayWorkTime"
        static let saturdayWorkTime = "saturdayWorkTime"
        static let sundayWorkTime = "sundayWorkTime"
    }
    
    struct PictureNames {
        static let backgroundImage = "cigarLeaves"
        static let image = "picture"
        static let placeholderImage = "back"
    }
    
    struct CellIdentifier {
        static let celebrityCell = "CelebrityCell"
        static let guideCell = "GuideCell"
        static let cigarBrendCell = "CigarBrend"
        static let selectedCigarCell = "SelectedCigarBrend"
        static let accessoriesCell = "AccessoriesCell"
        static let detailAccessoriesCell = "DetailAccessoriesCell"
        static let cigarArtCell = "CigarArtTableViewCell"
        static let cigarAndSpiritCell = "CigarAndSpiritTableViewCell"
        static let pointOfSaleCell = "PointOfSaleTableViewCell"
    }
    
    struct PlaceholderNames {
        static let cigarBrend = "Search for Cigar Brand"
        static let searchCigars = "Search for cigar"
    }
}


