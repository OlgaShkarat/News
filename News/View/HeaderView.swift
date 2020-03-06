//
//  HeaderView.swift
//  News
//
//  Created by Ольга on 04.03.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    let imageView: UIImageView = {
      let imageView = UIImageView(image: #imageLiteral(resourceName: "backgroundNews"))
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      return imageView
    }()

    init() {
      super.init(frame: .zero)
      autoresizingMask = [.flexibleWidth, .flexibleHeight]
      clipsToBounds = true
      configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    func configureView() {
      backgroundColor = .darkGray
      addSubview(imageView)
    }

   override func layoutSubviews() {
      super.layoutSubviews()
      imageView.frame = bounds
    }
}
