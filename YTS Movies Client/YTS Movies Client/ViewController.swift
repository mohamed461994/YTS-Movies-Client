//
//  ViewController.swift
//  YTS Movies Client
//
//  Created by MohamedSh on 12/15/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import UIKit
let notificationForReloadTable="reload"
class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    var viewModel=ViewModel()
    
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
        return cell
    }
    func createNotificationForReloadData(){
        let notifiReload = Notification.Name(notificationForReloadTable)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reload) , name: notifiReload, object: nil)
    }
    @objc func reload(notification:NSNotification){
        //print("Get Notified")
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
}

