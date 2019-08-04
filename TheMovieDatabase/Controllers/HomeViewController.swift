//
//  HomeViewController.swift
//  TheMovieDatabase
//
//  Created by Rahul  Belekar on 03/08/19.
//  Copyright © 2019 Rahul  Belekar. All rights reserved.
//

import UIKit
import Toast_Swift

class HomeViewController: UIViewController {
    
    private var currentIdx: Int = 1
    private var moviesList: MoviesBase!
    
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        getPopularMovies()
    }
    
    override func refreshView() {
        if AlamofireManager.isConnectedToInternet {
            getPopularMovies()
        }
    }
    
    //API call to get popular movies
    func getPopularMovies() {
        let  url = URL(string: Constants.API.URLS.PopularMoviesURL + "&page=\(currentIdx)")
        AlamofireManager.getRequest(url: url!) { [weak self] (data, error) in
            if let err = error {
                self?.view.makeToast(err)
                return
            }
            let jsonDecoder = JSONDecoder()
            if let model = try? jsonDecoder.decode(MoviesBase.self, from: data!) {
                if self?.moviesList == nil { self?.moviesList = model }
                else if (self?.moviesList.page)! < model.page! { self?.moviesList.update(data: model) }
                self?.collectionView.reloadData()
            }
        }
    }

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return moviesList?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Movie", for: indexPath) as! PopularMovieCollectionViewCell
        cell.movie = moviesList.results![indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (moviesList.results?.count ?? 0) - 1 {
            if currentIdx < (moviesList.total_pages ?? 0) {
                currentIdx += 1
                getPopularMovies()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController.create()
        vc.movieID = moviesList.results![indexPath.item].id
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
