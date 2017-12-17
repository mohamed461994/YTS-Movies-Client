//
//  MovieDetailesTableViewController.swift
//  YTS Movies Client
//
//  Created by MohamedSh on 12/17/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import UIKit

class MovieDetailesTableViewController: UITableViewController {
    @IBOutlet weak var lblDescription: UILabel!
    var id:Int?{
        didSet{updateUI()}
    }
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieCategories: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var lblRatting: UILabel!
    @IBOutlet weak var lblNumberOfLikes: UILabel!
    @IBOutlet weak var lblNumberOfDownloads: UILabel!
    @IBOutlet weak var lblMovieDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            //print(lblDescription.frame.height)
            return CGFloat(lblDescription.frame.height + 150 )
        }else{
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    func updateUI(){
        
    }
}
