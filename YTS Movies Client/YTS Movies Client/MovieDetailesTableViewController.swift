//
//  MovieDetailesTableViewController.swift
//  YTS Movies Client
//
//  Created by MohamedSh on 12/17/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//
let notificationForLoadData = "loadDataWhenNotify"

import UIKit
import Kingfisher
class MovieDetailesTableViewController: UITableViewController {
    @IBOutlet weak var lblDescription: UITextView!
    /// this varible is used to get all data for spesific ID
    var id:Int?{
        didSet{
         viewModel = ViewModelForSingleMovie(id: id!)
        }
    }
    var viewModel : ViewModelForSingleMovie?
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieCategories: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var lblRatting: UILabel!
    @IBOutlet weak var lblNumberOfLikes: UILabel!
    @IBOutlet weak var lblNumberOfDownloads: UILabel!
    @IBOutlet weak var lblMovieDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        createObserverForReloadData()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return CGFloat(lblDescription.frame.height + 150 )
        }else{
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    /**
     This function to create observer to get notifies when data is ready
     */
    func createObserverForReloadData(){
        let notifiReload = Notification.Name(notificationForLoadData)
        NotificationCenter.default.addObserver(self, selector: #selector(MovieDetailesTableViewController.reloadData) , name: notifiReload, object: nil)
    }
    /**
     This function called when notification is pushed
     */
    @objc func reloadData(notification:NSNotification){
        DispatchQueue.main.async { [weak self] in
            self?.lblRatting.text = self?.viewModel?.getRating()
            self?.lblMovieName.text = self?.viewModel?.getTitle()
            self?.title = self?.viewModel?.getTitle()
            self?.lblMovieYear.text = self?.viewModel?.getYear()
            self?.lblDescription.text = self?.viewModel?.getDescription()
            self?.lblNumberOfLikes.text = self?.viewModel?.getLikesCount()
            self?.lblNumberOfDownloads.text = self?.viewModel?.getDownloadsCount()
            self?.lblMovieCategories.text = self?.viewModel?.getCategores()
            self?.movieImage.kf.setImage(with: self?.viewModel?.getImgURL() )
            self?.tableView.isHidden = false
        }
    }
}
