//
//  RoundedView.swift
//  LastUberClone
//
//  Created by Sherif  Wagih on 12/18/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class RoundedView: UIView {
    @IBInspectable var borderColor:UIColor? {
        didSet{
            setupViews()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    func setupViews()
    {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        self.layer.borderColor = borderColor?.cgColor
    }
}
