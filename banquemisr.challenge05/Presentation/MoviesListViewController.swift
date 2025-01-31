//
//  MoviesListViewController.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 31/01/2025.
//

import UIKit

class MoviesListViewController: UIViewController, UITableViewDataSource {
    
    var viewmodel: MoviesListViewModelProtocol?
    

    let contactsTableView = UITableView() // view

    override func viewDidLoad() {
        view.addSubview(contactsTableView)
        
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false
        contactsTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true

        contactsTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        contactsTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        contactsTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        
        //regiester cell
        contactsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "movieCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
//          cell.textLabel?.text = movies[indexPath.row].name
          return cell
    }
}
