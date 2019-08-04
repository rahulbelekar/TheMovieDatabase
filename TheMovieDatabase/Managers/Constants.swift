//
//  Constants.swift
//  TheMovieDatabase
//
//  Created by Rahul  Belekar on 03/08/19.
//  Copyright © 2019 Rahul  Belekar. All rights reserved.
//

import UIKit

//Constants file contains all constants used in the application
struct Constants {
    struct API {
        //Base URL String
        static let BaseURL = "https://api.themoviedb.org/3"
        //The Movie Database Key
        static let APIKey = "e7d3538e958b374dc44ab98a864965a0"
        
        struct URLS {
            //Popularity movie URL String
            static let PopularMoviesURL = Constants.API.BaseURL + "/movie/popular?api_key=" + Constants.API.APIKey
            //Image download URL
            static let ImageDownloadURL = "https://image.tmdb.org/t/p/w500"
            //Detail Page API
            static let MovieDetailURL = Constants.API.BaseURL + "/movie/"
        }
    }
}
