//
//  MovieDetailViewController.swift
//  TheMovieDatabase
//
//  Created by Rahul  Belekar on 03/08/19.
//  Copyright © 2019 Rahul  Belekar. All rights reserved.
//

import UIKit
import AVKit
import Toast_Swift
import YoutubeDirectLinkExtractor

class MovieDetailViewController: UIViewController {
    
    private var movie: Movie!
    var movieID: Int!
    
    @IBOutlet weak var tableView: UITableView!
    
    //Creating new instance of view controller
    static func create() -> MovieDetailViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieDetails()
    }
    
    override func refreshView() {
        if AlamofireManager.isConnectedToInternet {
            getMovieDetails()
        }
    }
    
    //API call to fetch movie details
    func getMovieDetails() {
        let  url = URL(string: Constants.API.URLS.MovieDetailURL + "\(movieID ?? 0)?api_key=" + Constants.API.APIKey + "&append_to_response=videos")
        AlamofireManager.getRequest(url: url!) { [weak self] (data, error) in
            if let err = error {
                self?.view.makeToast(err)
                return
            }
            let jsonDecoder = JSONDecoder()
            if let model = try? jsonDecoder.decode(Movie.self, from: data!) {
                self?.movie = model
                self?.tableView.reloadData()
            }
        }
    }
    
    //Play video
    //@str : youtube url
    func playVideo(str: String) {
        let url = URL(string: str)
        let player = AVPlayer(url: url!)
        let vc = AVPlayerViewController()
        vc.player = player
        if #available(iOS 11.0, *) {
            vc.entersFullScreenWhenPlaybackBegins = true
        } else {
            // Fallback on earlier versions
        }
        present(vc, animated: true) {
            vc.player?.play()
        }
    }
    
    //Action to watch trailer button
    @IBAction func watchTrailer() {
        if movie == nil {
            self.view.makeToast("Please reselect the movie")
            return
        }
        if !AlamofireManager.isConnectedToInternet {
            self.view.makeToast("You are not connected to the internet.")
            return
        }
        //Used YouTubeDirectLinkExtractor Library to fetch youtube url
        if let videos = movie.videos?.results, videos.count > 0, let key = videos[0].key {
            YoutubeDirectLinkExtractor().extractInfo(for: .id(key), success: { [weak self] (info) in
                self?.playVideo(str: info.highestQualityPlayableLink!)
            }) { (error) in
                self.view.makeToast(error.localizedDescription)
            }
        } else {
            self.view.makeToast("No video links available")
        }
    }
    
}

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie == nil ? 0 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Movie") as! DetailHeaderTableViewCell
            cell.movie = movie
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Data") as! HomeDataTableViewCell
            cell.titleTxt?.text = "Genres"
            cell.subTxt?.text = movie.genres?.genre()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Data") as! HomeDataTableViewCell
            cell.titleTxt?.text = "Date"
            cell.subTxt?.text = movie.release_date
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Data") as! HomeDataTableViewCell
            cell.titleTxt?.text = "Overview"
            cell.subTxt?.text = movie.overview
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
