//
//  RoundedVew.swift
//  LastUberClone
//
//  Created by Sherif  Wagih on 12/18/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class RoundedImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
