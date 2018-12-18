//
//  GradientView.swift
//  LastUberClone
//
//  Created by Sherif  Wagih on 12/18/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class GradientView: UIView {
    //let gradient = CAGradientLayer()
    
    func setupGradientLayer()
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.white.cgColor,UIColor.init(white: 1, alpha: 0).cgColor]
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.locations = [0.8,1.0]
        self.layer.addSublayer(gradientLayer)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGradientLayer()
    }
}
