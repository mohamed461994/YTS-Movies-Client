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
        moviesData = MoviesData(url: urlForList,parameters:["page":1])
    }
    //=“flatliners”
    init(searchText:String){
        let urlForList="https://yts.am/api/v2/list_movies.json"
        moviesData = MoviesData(url: urlForList,parameters:["query_term":searchText])
    }
    func numberOfRows()->Int{
        return moviesData?.moviesList.count ?? 0
    }
    func movieName(indexPath:IndexPath)->String{
        return moviesData?.moviesList[indexPath.row].name ?? "Movie Name wrong"
    }
    func movieRating(indexPath:IndexPath)->String{
        return String(moviesData?.moviesList[indexPath.row].rate ?? 0.0)
    }
    func movieCategories(indexPath:IndexPath)->String{
       let list = moviesData?.moviesList[indexPath.row].typeList
        return (list?.joined(separator: " , "))!
    }
    func movieImgURL(indexPath:IndexPath)->URL{
        return URL(string: (moviesData?.moviesList[indexPath.row].imgURL!)!)!
    }
    func getMoreData(){
        moviesData?.getMoreDataWhenUserScroll()
    }
    func getMovieId(indexPath:IndexPath)-> Int{
        return (moviesData?.moviesList[indexPath.row].id)!
    }
}
