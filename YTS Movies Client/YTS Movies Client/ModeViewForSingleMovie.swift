//
//  ModeViewForSingleMovie.swift
//  YTS Movies Client
//
//  Created by MohamedSh on 12/17/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import Foundation
class ViewModelForSingleMovie{
    var moviesData:MoviesData?
    init(){
        let urlForList="https://yts.am/api/v2/movie_details.json"
        moviesData = MoviesData(url: urlForList,parameters:["movie_id":10])
    }
    
}
