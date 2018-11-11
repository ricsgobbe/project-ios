//
//  MovieInfoTableViewCell.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 11/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import UIKit
import Reusable

class MovieInfoTableViewCell: UITableViewCell, NibLoadable, Reusable {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var titleGenre: UILabel!
    
    
}

extension MovieInfoTableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension MovieInfoTableViewCell {
    
    func render(movieDetail: MovieDetail) {
        movieTitle.text = movieDetail.name
        releaseDate.text = movieDetail.releaseDate.convertDateFormater()
        overview.text = movieDetail.overview
        var genres = ""
        movieDetail.genre.forEach { (genre) in
            genres += "\(genre.name) "
        }
        titleGenre.text = genres
    }
    
}

