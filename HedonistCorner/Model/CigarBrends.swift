//
//  CigarBrends.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 6/28/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import Foundation

//Model for CelebrityViewControler

struct CelebritiesAndTheirFavoriteCigars {
    let textAboutCelebrity: String
    let pictureAboutCelebrity: String
}

//Model for GuidelinesViewControler

struct Guideliness {
    let guide: String
}

//Model for CigarBrandViewControler

struct CigarBrands {
    let cigarBrandName: String
    let cigarBrandPicture: String
    let cigarBrandText: String
    let cigarNames: [String]
    let cigarTexts: [String]
    let cigarPictures: [String]
    let cigarStrenghts: [String]
    let cigarRingGauges: [String]
    let cigarLengts: [String]
    let cigarFactoryNames: [String]
}

//Model for SelectedCigarBrandViewControler

struct SelectedCigarBrand {
    let cigarName: String
    let cigarText: String
    let cigarPicture: String
    let cigarStrenght: String
    let cigarRingGauge: String
    let cigarLengt: String
    let cigarFactoryName: String
}

//Model for AccessoriesTableViewControler

struct AccessoriesData {
    let accessoriesName: String
    let accessoriesText: String
    let accessoriesNames: [String]
    let accessoriesPictures: [String]
}

//Model for CigarArtTableViewControler

struct CigarArt {
    let cigarArtName: String
    let cigarArtText: String
}

//Model for CigarAndSpiritViewControler

struct CigarAndSpirit {
    
    let cigarAndSpiritName: String
    let cigarAndSpiritText: String
}

//Model for PointOfSaleTableViewControler

struct PointOfSale {
    let storeName: String
    let storeImage: String
    let storeAddress: String
    let storePhone: String
    let mondayWorkTime: String
    let tuesdayWorkTime: String
    let wednesdayWorkTime: String
    let thursdayWorkTime: String
    let fridayWorkTime: String
    let saturdayWorkTime: String
    let sundayWorkTime: String
}

