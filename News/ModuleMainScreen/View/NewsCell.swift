//
//  TechnologyNewsCell.swift
//  News
//
//  Created by Ольга on 04.03.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import UIKit
import SDWebImage
import MaterialComponents.MaterialShadowLayer

class NewsCell: UICollectionViewCell {
    
    static let cellID = "newsCell"
    static let cellHeight: CGFloat = 370.0
    static let cellPadding: CGFloat = 8.0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override class var layerClass: AnyClass {
      return MDCShadowLayer.self
    }

    var shadowLayer: MDCShadowLayer? {
      return self.layer as? MDCShadowLayer
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowLayer?.elevation = ShadowElevation.cardResting
      layer.shouldRasterize = true
      layer.rasterizationScale = UIScreen.main.scale

      clipsToBounds = false
      imageView.clipsToBounds = true
    }
    
    var newsViewModel: NewsCellViewModelProtocol? {
        willSet(newsViewModel) {
            guard let newsViewModel = newsViewModel else { return }
            titleLabel.text = newsViewModel.title
            descriptionLabel.text = newsViewModel.description
            imageView.sd_setImage(with: newsViewModel.imageViewURL)
            
            if let date = newsViewModel.date {
                dateLabel.isHidden = false
                dateLabel.text = Formatters.shortDateFormatter.string(from: date)
            } else {
                dateLabel.isHidden = true
            }
        }
    }
    
    override func prepareForReuse() {
       super.prepareForReuse()
       imageView.sd_cancelCurrentImageLoad()
       titleLabel.text = nil
       descriptionLabel.text = nil
       dateLabel.text = nil
     }
}
