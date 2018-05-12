//
//  ModeViewForSingleMovie.swift
//  YTS Movies Client
//
//  Created by MohamedSh on 12/17/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import Foundation
/// ViewModel For MVVM
class DetailsViewModel{
    var movieData: MoviesAPI?
    init(id: Int){
        let urlForList="https://yts.am/api/v2/movie_details.json"
        movieData = MoviesAPI(url: urlForList,parameters: ["movie_id": id])
    }
    /**
     this function is used to return title for a movie
     */
    func getTitle()->String{
        return (movieData?.singleMovieDetails?.title)!
    }
    /**
     this function is used to return description for a movie
     */
    func getDescription()->String{
        return (movieData?.singleMovieDetails?.description)!
    }
    /**
     this function is used to return count of donloads times for a movie
     */
    func getDownloadsCount()->String{
        return String((movieData?.singleMovieDetails?.downloads)!)
    }
    /**
     this function is used to return year of production for a movie
     */
    func getYear()->String{
        return String((movieData?.singleMovieDetails?.year)!)
    }
    /**
     this function is used to return movie categories for a movie
     */
    func getCategores()->String{
        let lis = (movieData?.singleMovieDetails?.category)!
        return lis.joined(separator: " / ")
    }
    /**
     this function is used to return ratting for a movie
     */
    func getRating()->String{
        let rat = (movieData?.singleMovieDetails?.rating)!
        return String(rat)
    }
    /**
     this function is used to return Image URL for a movie
     */
    func getImgURL()->URL{
        return URL( string:(movieData?.singleMovieDetails?.imgURL)!)!
    }
    /**
     this function is used to return count of likes for a movie
     */
    func getLikesCount()->String{
        return String((movieData?.singleMovieDetails?.likes)!)
    }
}
