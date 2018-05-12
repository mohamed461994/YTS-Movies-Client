//
//  MoviesData.swift
//  YTS Movies Client
//
//  Created by MohamedSh on 12/16/17.
//  Copyright © 2017 MohamedSh. All rights reserved.

import Foundation
import Alamofire
/**
 This class is used to deal with API to get information from yts API
 */
class MoviesAPI {
    /// this varible is to detect if request is from first view controller or not
    private var requestedFromFirstViewController=true
    /// this list will contains movies information for the first view controller
    var moviesList:[Movie]=[]
    private var url:String?
    /// this varible used for pagginatin to get more data from the API
    private var requestPageNumberOfMoviesData = 1
    /// this varaible store parameter as dictionary of type [String:Any]
    private var parameters: Parameters?
    /// this tuble will be used to store mapped data in case of it's request for the second view controller
    var singleMovieDetails:(id:Int,title:String,rating:Float, category:[String],imgURL:String,year:Int,likes:Int,description:String ,downloads:Int
    )?
    /** this varible use property opservers to push notification when it set */
    private var parseIsDone:Bool?{
        didSet{
            /// push notification to reload data in first view controllet
            let notifiReload = Notification.Name(notificationForReloadTable)
            NotificationCenter.default.post(name: notifiReload, object: nil)
        }
    }
    /// this varaible is comtained JSON data that came from API
    private var jsonData:Any?{ didSet{parseJSON()} }
    init(url:String , parameters: Parameters) {
        self.url = url
        if parameters["movie_id"] != nil{ requestedFromFirstViewController = false }
        self.parameters=parameters
        getJSON()
    }
    /// this function is used to make the request using Alamofire and assing json return to variable  jsonData this function is using threads t
    private func getJSON(){
        let utilityQueue=DispatchQueue.global(qos: .utility)
        Alamofire.request(url!, method: .get,parameters: parameters).responseJSON(queue: utilityQueue){ response in
            if let json = response.result.value {
                self.jsonData=json
            }
        }
    }
}

extension MoviesAPI{
     /// this function is used to mapping json information to moviesList in case of requesc from first view controller or to tuble called singleMovieDetails if it's the second view controller
    private func parseJSON(){
        let allData = jsonData as? [String : Any]
        let movesData = allData!["data"] as? [String : Any]
        if requestedFromFirstViewController{
            if let movies = movesData!["movies"] as? [[String:Any]]{
                for movie in movies {
                    moviesList.append(Movie(id: movie["id"] as? Int,
                                            imgURL: movie["medium_cover_image"] as? String,
                                            name: movie["title_english"] as? String,
                                            rate:  movie["rating"] as? Float ,
                                            typeList: (movie["genres"] as? [String])!))
                }
            }
        }
        else{
            parsingDataForSeconViewController(movie: (movesData!["movie"] as? [String:Any])!)
        }
        parseIsDone=true
    }
}
extension MoviesAPI{
    /**
     this function used to pagination when used scroll down to last cell in table view
     this funtion will make new request to the API with parameter page +1 to last page
     */
    func getMoreDataWhenUserScroll(){
        requestPageNumberOfMoviesData += 1
        parameters!["page"] = requestPageNumberOfMoviesData
        getJSON()
    }
}
extension MoviesAPI{
    /// this function gets information of a single movie and set it to the tuble singleMovieDetails
    private func parsingDataForSeconViewController(movie: [String:Any]){
        singleMovieDetails = (id: (movie["id"] as? Int)!
            ,title:(movie["title_english"] as? String)!
            ,rating:(movie["rating"] as? Float)!
            , category:(movie["genres"] as? [String])!
            ,imgURL: (movie["medium_cover_image"] as? String)!
            ,year:(movie["year"] as? Int)!
            ,likes:(movie["like_count"] as? Int)!
            ,description:(movie["description_intro"] as? String)!
            ,downloads: (movie["download_count"] as? Int)!
        )
        fireNotificationForSecondViewController()
    }
    ///  this function used to push notification when data processing is finished
    private func fireNotificationForSecondViewController(){
        let notifiReload = Notification.Name(notificationForLoadData)
        NotificationCenter.default.post(name: notifiReload, object: nil)
    }
}
