//
//  MovieTableViewCell.swift
//  moviedb-test
//
//  Created by José Javier on 4/1/19.
//  Copyright © 2019 José Pabón. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
	@IBOutlet weak var movieTitle: UILabel!
	@IBOutlet weak var voteAvarage: UILabel!
	@IBOutlet weak var poster: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
