//
//  Model.swift
//  moviedb-test
//
//  Created by José Javier on 3/31/19.
//  Copyright © 2019 José Pabón. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

protocol Meta {
	static func url(path: String) -> String
}

class MovieResponse: Mappable {
	var results: [Movie]?
	
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		results <- map["results"]
	}
}

class Movie: Object, Mappable, Meta {
		
	@objc dynamic var id = 0
	@objc dynamic var adult: Bool = false
	@objc dynamic var backdrop_path: String = ""
	@objc dynamic var budget: Int = 0
	@objc dynamic var homepage: String = ""
	@objc dynamic var imdb_id: String = ""
	@objc dynamic var original_language: String = ""
	@objc dynamic var original_title: String = ""
	@objc dynamic var overview: String = ""
	@objc dynamic var popularity: Double = 0.0
	@objc dynamic var poster_path: String = ""
	@objc dynamic var release_date: String = ""
	@objc dynamic var revenue: Int = 0
	@objc dynamic var runtime: Int = 0
	@objc dynamic var status: String = ""
	@objc dynamic var tagline: String = ""
	@objc dynamic var title: String = ""
	@objc dynamic var video: Bool = false
	@objc dynamic var vote_average: Double = 0.0
	@objc dynamic var vote_count: Int = 0
	//@objc dynamic var objGenres = [Genres]()
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	//Impl. of Mappable protocol
	required convenience init?(map: Map) {
		self.init()
	}
	
	func mapping(map: Map) {
		id					<- map["id"]
		adult				<- map["adult"]
		backdrop_path		<- map["backdrop_path"]
		budget				<- map["budget"]
		homepage			<- map["homepage"]
		imdb_id				<- map["imdb_id"]
		original_language	<- map["original_language"]
		original_title		<- map["original_title"]
		overview			<- map["overview"]
		popularity			<- map["popularity"]
		poster_path			<- map["poster_path"]
		release_date		<- map["release_date"]
		revenue				<- map["revenue"]
		runtime				<- map["runtime"]
		status				<- map["status"]
		tagline				<- map["tagline"]
		title				<- map["title"]
		video				<- map["video"]
		vote_average		<- map["vote_average"]
		vote_count			<- map["vote_count"]
		
	}
	
	//Impl. of Meta protocol
	static func url(path: String = "") -> String {
		return "\(Constant.API_URL)/movie\(path)?api_key=\(Constant.API_KEY)"
	}
}
