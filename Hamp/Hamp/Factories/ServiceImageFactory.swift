//
//  ServiceImageFactory.swift
//  Hamp
//
//  Created by Aleix Baggerman on 17/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

struct ServiceImageFactory {
    private static let imagesDictionary: [String:UIImage] = [ServiceType.bigBag.name:#imageLiteral(resourceName: "big-bag"),
                                                      ServiceType.smallBag.name:#imageLiteral(resourceName: "small-bag"),
                                                      ServiceType.bigQuilt.name:#imageLiteral(resourceName: "big-quilt"),
                                                      ServiceType.blanket.name:#imageLiteral(resourceName: "blanket"),
                                                      ServiceType.curtain.name:#imageLiteral(resourceName: "curtain"),
                                                      ServiceType.cushion.name:#imageLiteral(resourceName: "cushion"),
                                                      ServiceType.sofaCover.name:#imageLiteral(resourceName: "sofa-cover"),
                                                      ServiceType.smallQuilt.name:#imageLiteral(resourceName: "small-quilt")]
    
    static func getImageWith (serviceName: String) -> UIImage {
        return imagesDictionary[serviceName]!
    }
}
