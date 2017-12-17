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
    var moviesList:[Movie]=[]
    private var url:String?
    var requestPageNumberOfMoviesData = 1
    private var parameters: Parameters?
    var singleMovieDetails:(id:Int,title:String,rating:Float, category:[String],imgURL:String,year:Int,likes:Int,description:String ,downloads:Int
        )?{
        didSet{
        }
    }
    var requestedFromFirstViewController=true
    private var parseIsDone:Bool?{
        didSet{
            //push notification to reload data
            let notifiReload = Notification.Name(notificationForReloadTable)
            NotificationCenter.default.post(name: notifiReload, object: nil)
        }
    }
    private var jsonData:Any?{
        didSet{parseJSON()}
    }
    init(url:String , parameters: Parameters) {
        self.url = url
        if parameters["movie_id"] != nil{
            requestedFromFirstViewController = false
        }
        self.parameters=parameters
        getJSON()
    }

    func getJSON(){
        let utilityQueue=DispatchQueue.global(qos: .utility)
        Alamofire.request(url!, method: .get,parameters: parameters).responseJSON(queue: utilityQueue){ response in
            if let json = response.result.value {
                print(json)
                self.jsonData=json
            }
        }
    }
}

extension MoviesData{
    func parseJSON(){
        let allData = jsonData as? [String : Any]
        let movesData = allData!["data"] as? [String : Any]
        print(movesData!)
        if requestedFromFirstViewController{
            let movies = movesData!["movies"] as? [[String:Any]]
            for movie in movies! {
                moviesList.append(Movie(id: movie["id"] as? Int,
                                        imgURL: movie["medium_cover_image"] as? String,
                                        name: movie["title_english"] as? String,
                                        rate:  movie["rating"] as? Float ,
                                        typeList: (movie["genres"] as? [String])!))
            }
        }
        else{
            parsingDataForSeconViewController(movie: (movesData!["movie"] as? [String:Any])!)
        }

        parseIsDone=true
    }
}
extension MoviesData{
    func getMoreDataWhenUserScroll(){
        requestPageNumberOfMoviesData += 1
        parameters!["page"] = requestPageNumberOfMoviesData
        getJSON()
    }
}
extension MoviesData{
    func parsingDataForSeconViewController(movie: [String:Any]){
        print("it's Work")

        
    }
    
}
