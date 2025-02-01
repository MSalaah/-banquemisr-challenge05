//
//  MovieTableViewCell.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 31/01/2025.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var movie: Movie? {
        didSet {
            guard let movieItem = movie else {return}
            if let name = movieItem.title {
                posterImageView.image =  UIImage(named: "placeholder")
                movieTitle.text = name
            }
            if let posterPath = movieItem.poster_path {
                posterImageView.imageViewLoading(urlString: "\(Constants.imagesUrl)\(posterPath)")
            }
            
            if let releaseDate = movieItem.release_date {
                releaseDateLabel.text = releaseDate
            }
        }
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    let posterImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseDateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .white
        label.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(posterImageView)
        containerView.addSubview(movieTitle)
        containerView.addSubview(releaseDateLabel)
        self.contentView.addSubview(containerView)
        
        posterImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.posterImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        movieTitle.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        movieTitle.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        movieTitle.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        releaseDateLabel.topAnchor.constraint(equalTo:self.movieTitle.bottomAnchor).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        releaseDateLabel.topAnchor.constraint(equalTo:self.movieTitle.bottomAnchor).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
