//
//  ViewController.swift
//  YTS Movies Client
//
//  Created by MohamedSh on 12/15/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
import UIKit
import Kingfisher
/// this varible is used to create notification observer pattern 
let notificationForReloadTable="reloadDataInMainViewController"
class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate{
    var viewModel=ViewModel()
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var moviesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        createObserverForReloadData()
    }
    /**
     This function is used to prepare view controller views when load for first time
     */
    func prepareUI(){
        creatSearchBar()
        moviesTableView.isHidden = true
        spinner?.startAnimating()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
    }
    /**
     This function cis used to creat search bar
     */
    func creatSearchBar(){
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat(70)))
        moviesTableView.tableHeaderView = searchBar
        searchBar.delegate=self
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel = ViewModel(searchText: searchBar.text!)
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
        if indexPath.row == lastItem && lastItem % 19 == 0{
            viewModel.getMoreData()
        }
    }
    /**
     This function used to creat observer to get notified when data is ready
     */
    func createObserverForReloadData(){
        let notifiReload = Notification.Name(notificationForReloadTable)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reload) , name: notifiReload, object: nil)
    }
    /**
         This function called when data is ready to be presented
     */
    @objc func reload(notification:NSNotification){
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
            self.spinner?.stopAnimating()
            self.moviesTableView.isHidden = false
        }
        if self.viewModel.ckeckIfReturnedMovieNil(){
            presentAllert()
        }
    }
    /**
      this function to present allert in case if there is no Movies like searching text
     */
    func presentAllert(){
        let alert = UIAlertController(title: "Sorr!!", message: "but No movies like what you write", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "cancell", style: UIAlertActionStyle.default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelecteMovie"{
            if let vC = segue.destination as? MovieDetailesTableViewController {
                vC.id = viewModel.getMovieId(indexPath: (moviesTableView.indexPathForSelectedRow)!)
            }
        }
    }
}
