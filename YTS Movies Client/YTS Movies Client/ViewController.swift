//
//  ViewController.swift
//  YTS Movies Client
//
//  Created by MohamedSh on 12/15/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import UIKit
import Kingfisher
let notificationForReloadTable="reload"
class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    var viewModel=ViewModel()
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var searchLTxtField: UITextField!{
        didSet{searchLTxtField.delegate=self}
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // search for movies
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.isHidden = true
        spinner?.startAnimating()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        createNotificationForReloadData()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoviesTableViewCell
        cell.lblName.text = viewModel.movieName(indexPath: indexPath)
        cell.lblRating.text = viewModel.movieRating(indexPath: indexPath)
        cell.lblCategory.text = viewModel.movieCategories(indexPath: indexPath)
        cell.moviesImage.kf.setImage(with: viewModel.movieImgURL(indexPath: indexPath))
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = viewModel.numberOfRows() - 1
        if indexPath.row == lastItem {
            viewModel.getMoreData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selectedId = ",viewModel.getMovieId(indexPath: indexPath) )
    }
    func createNotificationForReloadData(){
        let notifiReload = Notification.Name(notificationForReloadTable)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reload) , name: notifiReload, object: nil)
    }
    @objc func reload(notification:NSNotification){
        //print("Get Notified")
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
            self.spinner?.stopAnimating()
            self.moviesTableView.isHidden = false
        }
    }
}

