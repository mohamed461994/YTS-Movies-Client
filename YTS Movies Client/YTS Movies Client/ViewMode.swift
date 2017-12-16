//
//  ViewMode.swift
//  YTS Movies Client
//
//  Created by MohamedSh on 12/16/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import Foundation
class ViewModel{
    var moviesData:MoviesData?
    init(){
        let urlForList="https://yts.am/api/v2/list_movies.json"
        moviesData = MoviesData(url: urlForList,parameters:["page":100])
    }
    func numberOfRows()->Int{
        return moviesData?.moviesList.count ?? 0
    }
    func movieName(indexPath:IndexPath)->String{
        return moviesData?.moviesList[indexPath.row].name ?? "Movie Name wrong"
    }
}
