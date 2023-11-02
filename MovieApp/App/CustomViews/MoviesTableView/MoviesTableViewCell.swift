//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by Ali Beyaz on 1.11.2023.
//

import UIKit
import SnapKit


class MoviesTableViewCell : UITableViewCell{
    
    let bgView = UIView()
    let movieImageView = UIImageView()
    let movieNameLabel = UILabel()
    let arrowButton = UIButton()
    let movieReleaseDate = UILabel()
    let starImageView = UIImageView()
    let voteAverageLabel = UILabel()
    
    
    static let identifier = "MoviesCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .lightText
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        
        bgView.layer.cornerRadius = 10
        bgView.backgroundColor = .white
        bgView.layer.shadowColor = UIColor(red: 0.682, green: 0.682, blue: 0.753, alpha: 0.4).cgColor
        bgView.layer.shadowOpacity = 1
        bgView.layer.shadowRadius = 20
        bgView.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.translatesAutoresizingMaskIntoConstraints = true
        movieImageView.clipsToBounds = true
        movieImageView.layer.cornerRadius = 10
        
        bgView.addSubview(movieImageView)
        movieImageView.snp.makeConstraints { make in
            make.height.equalTo(160)
            make.width.equalTo(120)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        arrowButton.setImage(UIImage(systemName: "chevron.right" ), for: .normal)
        bgView.addSubview(arrowButton)
        arrowButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(bgView.snp.centerY)
        }
        
        
        movieNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        movieNameLabel.textColor = .black
        movieNameLabel.textAlignment = .left
        movieNameLabel.numberOfLines = 0
        
        bgView.addSubview(movieNameLabel)
        movieNameLabel.snp.makeConstraints { make in
            make.left.equalTo(movieImageView.snp.right).offset(12)
            make.centerY.equalTo(movieImageView.snp.centerY)
            make.right.equalTo(arrowButton.snp.left).offset(-8)
        }
        
        movieReleaseDate.font = UIFont.systemFont(ofSize: 14)
        movieReleaseDate.textColor = .gray
        movieReleaseDate.textAlignment = .left
        movieReleaseDate.numberOfLines = 1
        
        bgView.addSubview(movieReleaseDate)
        movieReleaseDate.snp.makeConstraints { make in
            make.left.equalTo(movieNameLabel.snp.left)
            make.top.equalTo(movieNameLabel.snp.bottom).offset(8)
        }
        
        starImageView.image = UIImage(systemName: "star.fill")
        starImageView.image?.withTintColor(.red)
        
        bgView.addSubview(starImageView)
        starImageView.snp.makeConstraints { make in
            make.left.equalTo(movieNameLabel.snp.left)
            make.top.equalTo(movieReleaseDate.snp.bottom).offset(8)
        }
        
        voteAverageLabel.textAlignment = .left
        voteAverageLabel.numberOfLines = 1
        voteAverageLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        bgView.addSubview(voteAverageLabel)
        voteAverageLabel.snp.makeConstraints { make in
            make.left.equalTo(starImageView.snp.right).offset(4)
            make.centerY.equalTo(starImageView.snp.centerY)
        }
        
    }
}
