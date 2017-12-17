//
//  ModeViewForSingleMovie.swift
//  YTS Movies Client
//
//  Created by MohamedSh on 12/17/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import Foundation
class ViewModelForSingleMovie{
    var movieData:MoviesData?
    init(id:Int){
        let urlForList="https://yts.am/api/v2/movie_details.json"
        movieData = MoviesData(url: urlForList,parameters:["movie_id":id])
    }
    func getTitle()->String{
        return (movieData?.singleMovieDetails?.title)!
    }
    func getDescription()->String{
        return (movieData?.singleMovieDetails?.description)!
    }
    func getDownloadsCount()->String{
        return String((movieData?.singleMovieDetails?.downloads)!)
    }
    func getYear()->Int{
        return (movieData?.singleMovieDetails?.year)!
    }
    func getCategores()->String{
        let lis = (movieData?.singleMovieDetails?.category)!
        return lis.joined(separator: " / ")
    }
    func getRating()->String{
        let rat = (movieData?.singleMovieDetails?.rating)!
        return String(rat)
    }
    func getImgURL()->String{
        return (movieData?.singleMovieDetails?.imgURL)!
    }
    func getLikesCount()->String{
        return String((movieData?.singleMovieDetails?.likes)!)
    }
}
