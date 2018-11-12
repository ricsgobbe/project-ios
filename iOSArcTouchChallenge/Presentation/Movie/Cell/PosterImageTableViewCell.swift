//
//  PosterImageTableViewCell.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 11/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import UIKit
import Reusable

class PosterImageTableViewCell: UITableViewCell, NibLoadable, Reusable {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var backdropImage: UIImageView!
    
    static let height: CGFloat = 193.0
    
}


extension PosterImageTableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension PosterImageTableViewCell {
    func render(poster: String, config: Configuration) {
        let placeholder = UIImage(named: "placeholder")
        let url = imageDownloadSetup(config: config, path: poster)
        posterImage.loadImageFromURL(stringUrl: url, placeholder: placeholder!, fadeInDuration: 0.2)
        backdropImage.loadImageFromURL(stringUrl: url, placeholder: placeholder!, fadeInDuration: 0.2)
    }
    
    func imageDownloadSetup(config: Configuration?, path: String) -> String {
        guard let configuration = config else {
            return ""
        }
        let secureUrl = configuration.image.secureBaseUrl
        let size = configuration.image.backdropSizes.first
        let imageUrl = secureUrl + size! + path
        return imageUrl
    }
}
