//
//  ViewMode.swift
//  YTS Movies Client
//
//  Created by MohamedSh on 12/16/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import Foundation
class ViewModel{
    init(){
        test()
    }
    func numberOfRows()->Int{
        return 10
    }
    func movieName()->String{
        
        return "Flatliners (2017)"
    }
    func test(){
        let urlForList="https://yts.am/api/v2/list_movies.json"
        let m = MoviesData(url: urlForList,parameters:["page":100])
    }
    
}
