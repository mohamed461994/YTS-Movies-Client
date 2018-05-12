//
//  ViewMode.swift
//  YTS Movies Client
//
//  Created by MohamedSh on 12/16/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import Foundation
class MoviesViewModel{
    
    var moviesData:MoviesAPI?
    /// first intializer it used for
    init(){
        let urlForList="https://yts.am/api/v2/list_movies.json"
        moviesData = MoviesAPI(url: urlForList,parameters:["page":1])
    }
    /// second intializer used for searching it takes one parameter for searching using it
    init(searchText:String){
        if moviesData != nil {
            moviesData?.moviesList=[]
        }
        let urlForList="https://yts.am/api/v2/list_movies.json"
        moviesData = MoviesAPI(url: urlForList,parameters:["query_term":searchText])
    }
    /**
     this function used to return movies count
     */
    func numberOfRows()->Int{
        return (moviesData?.moviesList.count)!
    }
    /**
     this function used to return movie name it takes parameter of type IndexPath
     */
    func movieName(indexPath:IndexPath)->String{
        return (moviesData?.moviesList[indexPath.row].name)!
    }
    /**
     this function used to return movie rrate it takes parameter of type IndexPath
     */
    func movieRating(indexPath:IndexPath)->String{
        return String(moviesData?.moviesList[indexPath.row].rate ?? 0.0)
    }
    /**
     this function used to return movie categories and transform it from string seprated by / it takes parameter of type IndexPath
     */
    func movieCategories(indexPath:IndexPath)->String{
       let list = moviesData?.moviesList[indexPath.row].typeList
        return (list?.joined(separator: " / "))!
    }
    /**
     this function used to return movie image url it takes parameter of type IndexPath
     */
    func movieImgURL(indexPath:IndexPath)->URL{
        return URL(string: (moviesData?.moviesList[indexPath.row].imgURL!)!)!
    }
    /**
     this function used to load more data when user scroll
     */
    func getMoreData(){
        moviesData?.getMoreDataWhenUserScroll()
    }
    /**
     this function used to get movie id to use it in getting its information in second view
     */
    func getMovieId(indexPath:IndexPath)-> Int{
        return (moviesData?.moviesList[indexPath.row].id)!
    }
    /**
     this function used to check for search result if its 0 return true
     */
    func ckeckIfReturnedMovieNil()->Bool{
        if (moviesData?.moviesList.isEmpty)!{
            return true
        }
        return false
    }
}
