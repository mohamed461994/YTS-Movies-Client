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
    private var jsonData:Any?{
        didSet{
            parseJSON()
        }
    }
    init(url:String , parameters: Parameters) {
        self.url = url
        self.parameters=parameters
        getJSON()
    }

    func getJSON(){
        let utilityQueue=DispatchQueue.global(qos: .utility)
        Alamofire.request(url!, method: .get,parameters: parameters).responseJSON(queue: utilityQueue){ response in
            if let json = response.result.value {
                self.jsonData=json
            }
        }
    }
}

extension MoviesData{
    func parseJSON(){
        let allData = jsonData as? [String : Any]
        let movesData = allData!["data"] as? [String : Any]
        let movies = movesData!["movies"] as? [[String:Any]]
        print(movies)
    }
}
