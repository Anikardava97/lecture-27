//
//  NewsViewModel.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

#warning("Anyobject გვინდა, რათა პროტოკოლი კლასის ინსტანსებმა მიიღონ და მემორი მენეჯმენტსაც უკავშირდება, ვინაიდან, საშუალებას აძლევს პროტოკოლს, რომ weak reference გამოიყენოს დელეგატებისთვის. ამით retain cycle-ს ავიცილებთ თავიდან. თუ ობიექტი, რომელიც პროტოკოლს მიიღებს და შემდეგ deallocated იქნება, რეფერენსი დელეგატის ფროფერთიშიც ავტომატურად ნილი გახდება.")

protocol NewsViewModelDelegate: AnyObject {
    func newsFetched(_ news: [News])
    func showError(_ error: Error)
}
#warning("ეს პროტოკოლი მგონია, რომ საერთოდ არ გვჭირდება. DefaultNewsViewModel-ში ისედაც გვაქვს NewsViewModelDelegate-ის ცვლადი. და მგონია, რომ არასაჭირო კოდით YAGNI-ის პრინციპი ირღვევა.")
//protocol NewsViewModel: AnyObject {
//    var delegate: NewsViewModelDelegate? { get set }
//    func viewDidLoad()
//}

final class DefaultNewsViewModel {
    
    // MARK: - Properties
#warning("ეს სჯობს ცალკე კონსტანტების ფაილში მქონდეს, მაგრამ ამ ეტაპზე იყოს ასე:დდ")
    private let newsAPI = "https://newsapi.org/v2/everything?q=tesla&from=2023-10-25&sortBy=publishedAt&apiKey=5caafd85a03e4e6ca9d985f69f5439a8"
    
    private var newsList = [News]()
    
    weak var delegate: NewsViewModelDelegate?
    
    // MARK: - Public Methods
    func viewDidLoad() {
        fetchNews()
    }
    
    // MARK: - Private Methods
    private func fetchNews() {
        NetworkManager.shared.get(from: newsAPI) { [weak self] (result: Result<Article, Error>) in
            switch result {
            case .success(let fetchedNews):
                self?.delegate?.newsFetched(fetchedNews.articles)
                self?.newsList.append(contentsOf: fetchedNews.articles)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}

