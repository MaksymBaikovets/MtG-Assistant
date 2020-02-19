//
//  BackgroundsDAtaSource.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 16.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

// -------------------------------------------------------------------
// MARK: Backgrounds arrays:
// -------------------------------------------------------------------

class Backgrounds {
    func whiteTableBackground() -> UIImage {
        let whiteBackgrounds = [#imageLiteral(resourceName: "1stWhite"), #imageLiteral(resourceName: "2ndWhite"), #imageLiteral(resourceName: "3rdWhite"), #imageLiteral(resourceName: "4thWhite"), #imageLiteral(resourceName: "5thWhite"), #imageLiteral(resourceName: "6thWhite"), #imageLiteral(resourceName: "7thWhite"), #imageLiteral(resourceName: "8thWhite")]
        return whiteBackgrounds[Int(arc4random_uniform(UInt32(whiteBackgrounds.count)))]
    }

    func redTableBackground() -> UIImage {
        let redBackgrounds = [#imageLiteral(resourceName: "1stRed"), #imageLiteral(resourceName: "2ndRed"), #imageLiteral(resourceName: "3rdRed"), #imageLiteral(resourceName: "4thRed"), #imageLiteral(resourceName: "5thRed"), #imageLiteral(resourceName: "6thRed"), #imageLiteral(resourceName: "7thRed"), #imageLiteral(resourceName: "8thRed"), #imageLiteral(resourceName: "9thRed"), #imageLiteral(resourceName: "10thRed")]
        return redBackgrounds[Int(arc4random_uniform(UInt32(redBackgrounds.count)))]
    }

    func blackTableBackground() -> UIImage {
        let blackBackgrounds = [#imageLiteral(resourceName: "1stBlack"), #imageLiteral(resourceName: "2ndBlack"), #imageLiteral(resourceName: "3rdBlack"), #imageLiteral(resourceName: "4thBlack"), #imageLiteral(resourceName: "5thBlack"), #imageLiteral(resourceName: "6thBlack"), #imageLiteral(resourceName: "7thBlack"), #imageLiteral(resourceName: "8thBlack")]
        return blackBackgrounds[Int(arc4random_uniform(UInt32(blackBackgrounds.count)))]
    }

    func greenTableBackground() -> UIImage {
        let greenBackgrounds = [#imageLiteral(resourceName: "1stGreen"), #imageLiteral(resourceName: "2ndGreen"), #imageLiteral(resourceName: "3rdGreen"), #imageLiteral(resourceName: "4thGreen"), #imageLiteral(resourceName: "5thGreen"), #imageLiteral(resourceName: "6thGreen"), #imageLiteral(resourceName: "7thGreen"), #imageLiteral(resourceName: "8thGreen"), #imageLiteral(resourceName: "9thGreen"), #imageLiteral(resourceName: "10thGreen")]
        return greenBackgrounds[Int(arc4random_uniform(UInt32(greenBackgrounds.count)))]
    }

    func blueTableBackground() -> UIImage {
        let blueBackgrounds = [#imageLiteral(resourceName: "1stBlue"), #imageLiteral(resourceName: "2ndBlue"), #imageLiteral(resourceName: "3rdBlue"), #imageLiteral(resourceName: "4thBlue"), #imageLiteral(resourceName: "5thBlue"), #imageLiteral(resourceName: "6thBlue"), #imageLiteral(resourceName: "7thBlue"), #imageLiteral(resourceName: "8thBlue"), #imageLiteral(resourceName: "9thBlue")]
        return blueBackgrounds[Int(arc4random_uniform(UInt32(blueBackgrounds.count)))]
    }
}
