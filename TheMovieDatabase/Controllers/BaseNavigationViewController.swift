//
//  BaseNavigationViewController.swift
//  TheMovieDatabase
//
//  Created by Rahul  Belekar on 04/08/19.
//  Copyright © 2019 Rahul  Belekar. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Overrriding trait collection to have portrait view on iPad
    override func overrideTraitCollection(forChild childViewController: UIViewController) -> UITraitCollection? {
            if view.bounds.width < view.bounds.height {
                let traitCollections = [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)]
                return UITraitCollection(traitsFrom: traitCollections)
            } else {
                let traitCollections = [UITraitCollection(horizontalSizeClass: .unspecified), UITraitCollection(verticalSizeClass: .unspecified)]
                return UITraitCollection(traitsFrom: traitCollections)
            }
    }

}
