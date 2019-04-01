//
//  MovieDetailViewController.swift
//  moviedb-test
//
//  Created by José Javier on 4/1/19.
//  Copyright © 2019 José Pabón. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

	@IBOutlet weak var imageBackground: UIImageView!
	@IBOutlet weak var movieTitle: UILabel!
	@IBOutlet weak var date: UILabel!
	@IBOutlet weak var voteAvarage: UILabel!
	@IBOutlet weak var overview: UITextView!
	
	var movie = Movie()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let resource = ImageResource(downloadURL: URL(string: "\(Constant.IMAGE_URL)/\(Constant.POSTER_SIZES["original"] ?? "original")\(movie.backdrop_path)")!, cacheKey: "\(Constant.IMAGE_URL)\(movie.backdrop_path)")
		self.imageBackground.kf.indicatorType = .activity
		self.imageBackground.kf.setImage(with: resource)
		self.movieTitle.text = movie.title
		self.date.text = movie.release_date
		self.voteAvarage.text = "\(movie.vote_average)"
		self.overview.isEditable = false
		self.overview.text = movie.overview
        // Do any additional setup after loading the view.
    }
    


}

