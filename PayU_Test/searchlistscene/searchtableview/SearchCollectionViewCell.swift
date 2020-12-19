//
//  SearchCollectionViewCell.swift
//  SwiggyTest
//
//  Created by Manas1 Mishra on 28/10/20.
//

import UIKit
import Kingfisher

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var releasingLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(name: String, releaseDate: String?, posterImageURL: URL?, description: String)  {
     
        self.releasingLabel.text = releaseDate ?? ""
        self.nameLabel.text = name
        self.descriptionLabel.text = description
        self.posterImageView.kf.setImage(with: posterImageURL, placeholder: UIImage(named: "poster"), options: nil, progressBlock: nil) { (res) in
        }
        
    }
}
