//
//  MovieDetailsVC.swift
//  MovieApp
//
//  Created by Ali Beyaz on 1.11.2023.
//

import UIKit

class MovieDetailsVC: UIViewController {
    
    var movie: Movie?
    let header = HeaderView(title: "")
    
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let movie = movie {
            movieTitle.text = movie.title
        }
        
        setupView()
    }
    
    func setupView() {
        
        view.addSubview(header)
        
        header.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            
            
        }
        view.addSubview(movieTitle)
        
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.center.equalToSuperview()
        }
        
    }
    
}
