//
//  DetailHeaderTableViewCell.swift
//  TheMovieDatabase
//
//  Created by Rahul  Belekar on 04/08/19.
//  Copyright © 2019 Rahul  Belekar. All rights reserved.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    
    var movie: Movie! {
        didSet {
            let url = URL(string: Constants.API.URLS.ImageDownloadURL + (movie.backdrop_path ?? ""))
            posterImage.kf.setImage(with: url) { result in
                self.setNeedsLayout()
            }
            movieTitle.text = movie.title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
