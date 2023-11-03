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
    let moviePoster = UIImageView()
    let overview = UILabel()
    let apiManager: APIManager?
    
    init(apiManager: APIManager?) {
        self.apiManager = apiManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let movie = movie {
            overview.text = movie.overview
            loadImage(path: movie.backdropPath) { image in
                DispatchQueue.main.async {
                    self.moviePoster.image = image
                }
            }
        }
        
        setupView()
    }
    
    func setupView() {
        
        view.addSubview(header)
        
        header.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            
        }
        moviePoster.contentMode = .scaleAspectFit
        view.addSubview(moviePoster)
        
        moviePoster.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        
        overview.numberOfLines = 0
        overview.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(overview)
        overview.snp.makeConstraints { make in
            make.top.equalTo(moviePoster.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
        
    }
    
    func loadImage (path: String, completion: @escaping (UIImage?) -> Void) {
        apiManager?.loadImage(path) { (result) in
            switch result {
            case .success (let image):
                completion (image)
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
    
}
