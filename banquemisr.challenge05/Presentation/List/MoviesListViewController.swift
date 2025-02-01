//
//  MoviesListViewController.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 31/01/2025.
//

import UIKit

class MoviesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate {
    
    private lazy var moviesTableView: UITableView = {
        let moviesTableView = UITableView()
        view.addSubview(moviesTableView)
        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
        moviesTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        moviesTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        moviesTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        moviesTableView.bottomAnchor.constraint(equalTo:tabbar.topAnchor).isActive = true
        
        return moviesTableView
    }()
    
    private lazy var tabbar: UITabBar = {
        let tabbar = UITabBar()
        view.addSubview(tabbar)
        tabbar.isTranslucent = false
        tabbar.backgroundColor = .white
        tabbar.translatesAutoresizingMaskIntoConstraints = false
        tabbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        tabbar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
        tabbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
        
        let nowPlaying = UITabBarItem(title: "Now Playing", image: UIImage(systemName: "popcorn"), selectedImage: UIImage(systemName: "popcorn.fill"))
        nowPlaying.tag = 0
        let popular = UITabBarItem(title: "Popular", image: UIImage(systemName: "chart.line.uptrend.xyaxis"),selectedImage: UIImage(systemName: "chart.line.uptrend.xyaxis.fill"))
        popular.tag = 1
        let upComing = UITabBarItem(title: "Upcoming", image: UIImage(systemName: "movieclapper"),selectedImage: UIImage(systemName: "movieclapper.fill"))
        upComing.tag = 2
        
        tabbar.setItems([nowPlaying, popular, upComing], animated: true)
        tabbar.delegate = self
        tabbar.selectedItem = nowPlaying
        
        return tabbar
    }()
    
    var viewmodel: MoviesListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        
        navigationItem.title = "Movies"
        
        viewmodel?.didSelectTab(type: .nowPlaying)
        viewmodel?.onListFetched = { [weak self] in
            self?.moviesTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel?.moviesList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        cell.movie = viewmodel?.moviesList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewmodel?.didSelectMovie(index: indexPath)
        let movie = viewmodel?.moviesList[indexPath.row]
        ModuleFactory.shared.createDetailsModule(nav: self.navigationController, movieId: movie?.id ?? 0)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag{
        case 0:
            viewmodel?.didSelectTab(type: .nowPlaying)
        case 1:
            viewmodel?.didSelectTab(type: .popular)
        case 2:
            viewmodel?.didSelectTab(type: .upComing)
        default:
            viewmodel?.didSelectTab(type: .nowPlaying)
        }
    }
}
