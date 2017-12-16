//
//  ViewController.swift
//  YTS Movies Client
//
//  Created by MohamedSh on 12/15/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    var viewModel=ViewModel()
    @IBOutlet weak var searchLTxtField: UITextField!{
        didSet{
            searchLTxtField.delegate=self
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // search for movies
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        
        // Do any additional setup after loading the view, typically from a nib.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoviesTableViewCell
        cell.lblName.text = viewModel.movieName()
        return cell
    }


}

