//
//  FetchData.swift
//  moviedb-test
//
//  Created by José Javier on 3/31/19.
//  Copyright © 2019 José Pabón. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RealmSwift

class FetchData {
	static func get <T: Object> (type: T.Type,success:@escaping () -> Void, fail:@escaping (_ error:NSError)->Void)->Void where T:Mappable, T:Meta { // path: String, 
	
		Alamofire.request(type.url(), method: .get).responseObject { (response: DataResponse<MovieResponse>) in
	
			switch response.result {
			case .success:
				
				do {
					guard let listResult = response.result.value else{
						return
					}
					
					let realm = try Realm()
					try realm.write {
						for item in listResult.results! {
							realm.add(item, update: true)
						}
					}
				} catch let error as NSError {
					print("------ERROR-------")
					print(error.localizedDescription)
					print("------------------")
					fail(error)
				}
				success()
			case .failure(let error as NSError):
				print("------ERROR-------")
				print(error.localizedDescription)
				print("------------------")
				fail(error)
			}
		}
	}
}
