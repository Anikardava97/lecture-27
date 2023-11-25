//
//  NewsViewController.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import UIKit

final class NewsViewController: UIViewController {
    
    // MARK: - Properties
    private var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private var news = [News]()
    private var viewModel = DefaultNewsViewModel()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTableView()
        setupViewModelDelegate()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Setup TableView
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupViewModelDelegate() {
        viewModel.delegate = self
    }
}

// MARK: - TableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
#warning("newsCell უნდა გვეწეროს და identifier-ში და არა NewsCell")
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Could not dequeue NewsCell")
        }
        cell.configure(with: news[indexPath.row])
        return cell
    }
}

// MARK: - TableViewDelegate
#warning("როცა 0-აბრუნებს, იმას ნიშნავს, რომ როუ დამალული იქნება. ამ შემთხვევაში კი დამალვა არ გვჭირდება.")
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - MoviesListViewModelDelegate
extension NewsViewController: NewsViewModelDelegate {
    func newsFetched(_ news: [News]) {
        self.news = news
        tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        print("error")
    }
}

