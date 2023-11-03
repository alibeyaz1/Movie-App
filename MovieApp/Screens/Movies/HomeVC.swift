//
//  HomeVC.swift
//  MovieApp
//
//  Created by Ali Beyaz on 1.11.2023.
//

import Foundation
import UIKit
import SnapKit
import Reachability

class HomeVC: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: MovieViewModelType = HomeViewModel(apiManager: APIManager())
    let header = HeaderView(title: "MovieLIST")
    lazy var movieTableView: MoviesTableView = {
        let movieTableView = MoviesTableView(viewModel: viewModel as! HomeViewModel)
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        movieTableView.delegate = self
        return movieTableView
    }()
    
    let addButton = CustomGradientButton(title: "Add", icon: UIImage(systemName: "plus"))
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reach = try! Reachability()
        
        if  reach.connection == .unavailable {
            viewModel.fetchMovieCoreDate()
            
        } else {
            
        }
        setupViews()
    }
    
    // MARK: - View Setup
    
    func setupViews(){
        
        view.addSubview(header)
        
        header.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        view.addSubview(movieTableView)
        movieTableView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
        
        view.addSubview(addButton)
        view.bringSubviewToFront(addButton)
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaInsets).inset(24)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalToSuperview().multipliedBy(0.06)
        }
    }
}

// MARK: - MovieListItemDelegate

extension HomeVC: MovieListItemDelegate {
    func selectedMovie(movie: Movie) {
        let vc = MovieDetailsVC(apiManager: APIManager())
        vc.movie = movie
        vc.header.titleLabel.text = movie.title
        vc.header.backAction = {
            self.dismiss(animated: true)
        }
        vc.header.setupBackButton(show: true)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
}


