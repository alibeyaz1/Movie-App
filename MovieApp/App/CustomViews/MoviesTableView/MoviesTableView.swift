//
//  HomeView.swift
//  MovieApp
//
//  Created by Ali Beyaz on 1.11.2023.
//


import UIKit

class MoviesTableView: UIView {
    
    weak var delegate: MovieListItemDelegate?
    
    
    var viewModel: HomeViewModel
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        
        setupViews()
    }
    
    func setupViews() {
        
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
    }
    
}

//MARK: - UITableViewDataSource
extension MoviesTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell
        
        let movie = viewModel.getMovie(at: indexPath.row)
        
        cell?.selectionStyle = .none
        cell!.movieNameLabel.text = movie.title
        
        let year = movie.releaseDate.split(separator: "-")
        cell!.movieReleaseDate.text = "\(year[0])"
        
        switch true {
        case movie.voteAverage < 7.0:
            cell?.starImageView.tintColor = .red
            cell?.voteAverageLabel.textColor = .red
        case movie.voteAverage >= 7.0 && movie.voteAverage < 9.0:
            cell?.starImageView.tintColor = .orange
            cell?.voteAverageLabel.textColor = .orange
        case movie.voteAverage >= 9.0:
            cell?.starImageView.tintColor = .green
            cell?.voteAverageLabel.textColor = .green
        default:
            break
        }
        
        let movieAverage = movie.voteAverage
        cell!.voteAverageLabel.text = "\(String(format: "%.1f", movieAverage)) / 10 "
        
        
        
        viewModel.loadImage(path: movie.posterImagePath) { image in
            DispatchQueue.main.async {
                cell!.movieImageView.image = image
            }
        }
        
        return cell ?? UITableViewCell()
    }
}

//MARK: - UITableViewDelegate
extension MoviesTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.getMovie(at: indexPath.row)
        delegate?.selectedMovie(movie: movie)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.count - 4 {
            viewModel.fetchMovies()
        }
    }
    
}

//MARK: - MovieViewModelDelegate
extension MoviesTableView: MovieViewModelDelegate {
    func moviesLoaded() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
