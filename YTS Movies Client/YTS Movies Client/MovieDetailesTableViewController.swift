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
        id = 10
        createObserverForReloadData()
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
        let viewModel=ViewModelForSingleMovie()
    }
    func createObserverForReloadData(){
        let notifiReload = Notification.Name(notificationForReloadTable)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewModelForSingleMovie.reloadData) , name: notifiReload, object: nil)
    }
    @objc func reloadData(notification:NSNotification){
        //print("Get Notified")
        DispatchQueue.main.async {
            
        }
    }
}
