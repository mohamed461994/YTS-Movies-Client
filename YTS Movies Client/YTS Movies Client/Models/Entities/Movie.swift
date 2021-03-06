//
//  Movie.swift
//  YTS Movies Client
//
//  Created by MohamedSh on 12/16/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import Foundation
/**
     this struct represent movie information for first view controller
 */
struct Movie {
    var id: Int?
    var imgURL: String?
    var name: String?
    var rate: Float?
    var typeList: [String]=[]
}
