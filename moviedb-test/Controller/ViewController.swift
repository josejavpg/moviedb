//
//  ViewController.swift
//  moviedb-test
//
//  Created by José Javier on 3/30/19.
//  Copyright © 2019 José Pabón. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
import Kingfisher

class MovieListViewController: UIViewController {
	
	//MARK:- Properties
	
	@IBOutlet weak var category: UISegmentedControl!
	
	@IBOutlet weak var tableView: UITableView!
	
	let realm = try! Realm()
	var popularMovies		: Results<Movie>?//Poppular
	var upcomingMovies 		: Results<Movie>?//Upcomming
	var topRatedMovies 		: Results<Movie>?//TopRated
	var moviesDataSource 	: Results<Movie>?
	var categoryPath = "/popular"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.popularMovies		=	self.realm.objects(Movie.self)
		self.upcomingMovies		=	self.realm.objects(Movie.self)
		self.topRatedMovies		=	self.realm.objects(Movie.self)
		self.moviesDataSource	=	self.realm.objects(Movie.self)
		getMovies()
		// Do any additional setup after loading the view.
	}
	
	
	//MARK:- Functions

	@IBAction func categorySelected(_ sender: Any) {
		try? realm.write {
			realm.deleteAll()
		}
		switch category.selectedSegmentIndex {
		case 1:
			moviesDataSource = upcomingMovies
			categoryPath = "/upcoming"
		case 2:
			moviesDataSource = topRatedMovies
			categoryPath = "/top_rated"
		default:
			moviesDataSource = popularMovies
			categoryPath = "/popular"
		}
		getMovies()
	}
	
	func getMovies() {
		FetchData.get(type: Movie.self, path: self.categoryPath, success: {
			print("OK")
			
			switch self.category.selectedSegmentIndex {
			case 1:
				//moviesDataSource = upcomingMovies
				self.upcomingMovies = self.realm.objects(Movie.self)
			case 2:
				//moviesDataSource = topRatedMovies
				self.topRatedMovies = self.realm.objects(Movie.self)
			default:
				//moviesDataSource = popularMovies
				self.popularMovies = self.realm.objects(Movie.self)
			}
			self.tableView.reloadData()
		}) { (error) in
			print("------ERROR-------")
			print(error.localizedDescription)
			print("------------------")
		}
	}
	
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		switch self.category.selectedSegmentIndex {
		case 1:
			return upcomingMovies?.count ?? 0
		case 2:
			return topRatedMovies?.count ?? 0
		default:
			return popularMovies?.count ?? 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier:  "MovieTableViewCell") as! MovieTableViewCell? else{
			return UITableViewCell()
		}
		guard let movie = moviesDataSource?[indexPath.row] else{
			return UITableViewCell()
		}
		
		cell.movieTitle.text = movie.title
		cell.voteAvarage.text = "\(movie.vote_average)"
		let resource = ImageResource(downloadURL: URL(string: "\(Constant.IMAGE_URL)/\(Constant.POSTER_SIZES["small"] ?? "original")\(movie.poster_path)")!, cacheKey: "\(Constant.IMAGE_URL)\(movie.poster_path)")
		cell.poster.kf.indicatorType = .activity
		cell.poster.kf.setImage(with: resource)
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 180.0
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showDetail" {
			if let indexPath = self.tableView.indexPathForSelectedRow{
				guard let movie = moviesDataSource?[indexPath.row] else{
					return
				}
				guard let controller = segue.destination as? MovieDetailViewController else{
					return
				}
				controller.movie = movie
			}
		}
	}
	
}

