//
//  RoundedShadowView.swift
//  LastUberClone
//
//  Created by Sherif  Wagih on 12/18/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class RoundedShadowView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    func setupViews()
    {
        self.layer.cornerRadius = 5
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
