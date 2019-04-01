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
	var popularMovies		: Results<Popular>?//[Movie]()
	var upcomingMovies 		: Results<Upcomming>?//[Movie]()
	var topRatedMovies 		: Results<TopRated>?//[Movie]()
	var moviesDataSource 	: Results<Movie>?
	var categoryPath = "/popular"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.popularMovies		=	self.realm.objects(Popular.self)
		self.upcomingMovies		=	self.realm.objects(Upcomming.self)
		self.topRatedMovies		=	self.realm.objects(TopRated.self)
		self.moviesDataSource	=	self.realm.objects(Movie.self)
		print("\(Realm.Configuration.defaultConfiguration.fileURL)")
		getMovies()
		// Do any additional setup after loading the view.
	}
	
	
	//MARK:- Functions

	@IBAction func categorySelected(_ sender: Any) {
		
		switch category.selectedSegmentIndex {
		case 1:
			//moviesDataSource = upcomingMovies
			categoryPath = "/upcoming"
		case 2:
			//moviesDataSource = topRatedMovies
			categoryPath = "/top_rated"
		default:
			//moviesDataSource = popularMovies
			categoryPath = "/popular"
		}
		getMovies()
	}
	
	func getMovies() {
		FetchData.get(type: Movie.self, success: { //path: self.categoryPath, 
			print("OK")
			
			switch self.category.selectedSegmentIndex {
			case 1:
				//moviesDataSource = upcomingMovies
				self.upcomingMovies = self.realm.objects(Upcomming.self)
			case 2:
				//moviesDataSource = topRatedMovies
				self.topRatedMovies = self.realm.objects(TopRated.self)
			default:
				//moviesDataSource = popularMovies
				self.popularMovies = self.realm.objects(Popular.self)
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
		
		guard let numberOfRow = moviesDataSource?.count else {
			return 0
		}
		return numberOfRow
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier:  "MovieTableViewCell") as! MovieTableViewCell? else{
			return UITableViewCell()
		}
		var movie: Movie? //moviesDataSource?[indexPath.row]
		switch self.category.selectedSegmentIndex {
		case 1:
			//moviesDataSource = upcomingMovies
			self.upcomingMovies = self.realm.objects(Upcomming.self)
			movie = upcomingMovies?[indexPath.row]
		case 2:
			//moviesDataSource = topRatedMovies
			self.topRatedMovies = self.realm.objects(TopRated.self)
			movie = topRatedMovies?[indexPath.row]
		default:
			//moviesDataSource = popularMovies
			self.popularMovies = self.realm.objects(Popular.self)
			movie = popularMovies?[indexPath.row]
		}
		cell.movieTitle.text = movie?.title
		cell.tagline.text = movie?.tagline
		cell.tagline.text = "\(String(describing: movie?.vote_average))"
		return cell
	}
	
	
}

