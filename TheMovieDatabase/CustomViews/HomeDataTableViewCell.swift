//
//  HomeDataTableViewCell.swift
//  TheMovieDatabase
//
//  Created by Rahul  Belekar on 04/08/19.
//  Copyright © 2019 Rahul  Belekar. All rights reserved.
//

import UIKit

class HomeDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var subTxt: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
