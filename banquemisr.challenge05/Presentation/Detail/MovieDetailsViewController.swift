//
//  MovieDetailsViewController.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 31/01/2025.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var viewmodel: MovieDetailsViewModelProtocol?
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Description"
        return textView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(contentStackView)
        if #available(iOS 11.0, *) {
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        } else {
            contentStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30).isActive = true
        }
        contentStackView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        contentStackView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        
        contentStackView.spacing = 50
        
        contentStackView.addArrangedSubview(imageView)
        
        imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: (imageView.image?.size.width ?? 20) / (imageView.image?.size.height ?? 20)).isActive = true

        contentStackView.addArrangedSubview(titleLabel)
        
        contentStackView.addArrangedSubview(descriptionTextView)
        
        
        viewmodel?.onResponse = { [weak self] result in
            self?.titleLabel.text = result.title
            self?.descriptionTextView.text = result.overview
            self?.imageView.imageViewLoading(urlString: "\(Constants.imagesUrl)\(result.poster_path ?? "")")
        }
    }
}
