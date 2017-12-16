//
//  MoviesData.swift
//  YTS Movies Client
//
//  Created by MohamedSh on 12/16/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import Foundation
import Alamofire
class MoviesData{
    private var url:String?
    private var parameters: Parameters?
    init(url:String , parameters: Parameters) {
        self.url = url
        self.parameters=parameters
        getJSON()
    }
    func getJSON(){
        
    }
    
}
