//
//  NewsTableViewCell.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import UIKit
import Kingfisher

#warning("UICollectionViewCell არ არის, გვჭირდება UITableViewCell")
final class NewsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
#warning("mainStackView-ს რადგან translatesAutoresizingMaskIntoConstraints = false უწერია, ყველგან ამის დაწერა აღარ გვჭირდება, ამიტომ ვშლი")
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return imageView
    }()
    
    private var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
#warning("label.isHidden = true გვინდა, რომ ლეიბლი გამოჩნდეს, ამიტომ ამას ვშლი.")
        return label
    }()
    
    private var newsAuthorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newsTitleLabel, newsAuthorLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newsImageView, textStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupSubview() {
        contentView.addSubview(mainStackView)
    }
    
    private func setupConstraints() {
#warning("rightAnchor და leftAnchor არა, trailingAnchor და leadingAnchor. ქონსთრეინთები თავისთავად გასასწორებელი")
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Configure
#warning("კონტროლერმა რომ დაინახოს, არ უნდა იყოს configure ფუნქცია private")
    func configure(with news: News) {
        let url = URL(string: news.urlToImage ?? "")
        newsImageView.kf.setImage(with: url)
        newsTitleLabel.text = news.title
        newsAuthorLabel.text = news.author
    }
}


