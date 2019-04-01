//
//  NetworkManager.swift
//  moviedb-test
//
//  Created by José Javier on 4/1/19.
//  Copyright © 2019 José Pabón. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NetworkManager {
	
	//shared instance
	static let shared = NetworkManager()
	
	let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
	
	func startNetworkReachabilityObserver() {
		
		reachabilityManager?.listener = { status in
			switch status {
				
			case .notReachable:
				print("The network is not reachable")
				
			case .unknown :
				print("It is unknown whether the network is reachable")
				
			case .reachable(.ethernetOrWiFi):
				print("The network is reachable over the WiFi connection")
				
			case .reachable(.wwan):
				print("The network is reachable over the WWAN connection")
				
			}
		}
		
		// start listening
		reachabilityManager?.startListening()
	}
}
