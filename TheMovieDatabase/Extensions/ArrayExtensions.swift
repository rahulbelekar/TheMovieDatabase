//
//  ArrayExtensions.swift
//  TheMovieDatabase
//
//  Created by Rahul  Belekar on 03/08/19.
//  Copyright © 2019 Rahul  Belekar. All rights reserved.
//

import UIKit

extension Array {
    //Create genre string from IDs
    func genre() -> String? {
        if self.count == 0 { return "" }
        let genreIDs = [28: "Action",
        12: "Adventure",
        16: "Animation",
        35: "Comedy",
        80: "Crime",
        99: "Documentary",
        18: "Drama",
        10751: "Family",
        14: "Fantasy",
        36: "History",
        27: "Horror",
        10402: "Music",
        9648: "Mystery",
        10749: "Romance",
        878: "Science Fiction",
        10770: "TV Movie",
        53: "Thriller",
        10752: "War",
        37: "Western"]
        var txt = ""
        for itm in (self as! [Genres]) {
            let value = genreIDs[itm.id!]
            txt += value!
            if itm.id! != (self.last! as! Genres).id! {
                txt += ", "
            }
        }
        return txt
    }
}
