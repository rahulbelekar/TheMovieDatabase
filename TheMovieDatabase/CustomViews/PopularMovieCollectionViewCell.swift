//
//  PopularMovieCollectionViewCell.swift
//  TheMovieDatabase
//
//  Created by Rahul  Belekar on 03/08/19.
//  Copyright © 2019 Rahul  Belekar. All rights reserved.
//

import UIKit
import Kingfisher

class PopularMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var posterView: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var ratings: UILabel!
    
    var movie: Results! {
        didSet {
            let url = URL(string: Constants.API.URLS.ImageDownloadURL + (movie.poster_path ?? ""))
            posterView.kf.setImage(with: url)
            movieTitle.text = movie.title
            ratings.text = "Rating: \(movie.vote_average ?? 0.0)"
        }
    }
    
}
