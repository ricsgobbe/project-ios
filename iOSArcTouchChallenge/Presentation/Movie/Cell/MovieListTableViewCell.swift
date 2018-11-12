//
//  MovieTableViewCell.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 11/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import UIKit
import Reusable

class MovieListTableViewCell: UITableViewCell, NibLoadable, Reusable {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var opacityView: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genres: UILabel!
    
    static var height: CGFloat = 276
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func render(movie: Movie) {
        labelShadowSetup()
        movieTitle.text = movie.name
        releaseDate.text = movie.releaseDate.convertDateFormater()
    }
    
    func setMovieGenres(genresList: [Genre]) {
        var genresString = ""
        genresList.forEach({ genresString += "\($0.name) " })
        genres.text = genresString
    }
    
    func imageDownloadSetup(config: Configuration?, backdropPath: String) {
        guard let configuration = config else {
            return
        }
        let secureUrl = configuration.image.secureBaseUrl
        let size = configuration.image.backdropSizes.first
        let imageUrl = secureUrl + size! + backdropPath
        downloadImageSetup(stringUrl: imageUrl)
    }
    
    fileprivate func downloadImageSetup(stringUrl: String) {
        let placeHolder = UIImage(named: "placeholder")
        let width = self.contentView.frame.width
        let height = MovieListTableViewCell.height
        let requiredSize = CGSize(width: width, height: height)
        moviePoster.loadImageFromUrlResized(with: stringUrl, placeholder: placeHolder!, fadeInDuration: 0.33, desiredSize: requiredSize)
    }
    
    fileprivate func labelShadowSetup() {
        movieTitle.layer.shadowColor = UIColor.black.cgColor
        movieTitle.layer.shadowRadius = 3.0
        movieTitle.layer.shadowOpacity = 1.0
        movieTitle.layer.shadowOffset = CGSize(width: 4, height: 4)
        movieTitle.layer.masksToBounds = false
    }
}
