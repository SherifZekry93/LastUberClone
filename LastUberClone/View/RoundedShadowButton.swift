//
//  RoundedShadowIImage.swift
//  LastUberClone
//
//  Created by Sherif  Wagih on 12/18/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class RoundedShadowButton: UIButton {
    var originalSize:CGRect?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        //animateButton(shouldLoad: true, with: "")
    }
    func setupViews()
    {
        originalSize = self.frame
        self.layer.cornerRadius = 5.0
        self.layer.shadowRadius = 10.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
    }
    func animateButton(shouldLoad:Bool,with message:String?)
    {
        let spinnerView = UIActivityIndicatorView()
        spinnerView.style = .whiteLarge
        spinnerView.color = .darkGray
        spinnerView.alpha = 0.0
        spinnerView.hidesWhenStopped = true
        self.addSubview(spinnerView)
        spinnerView.center = CGPoint(x: self.frame.width / 2 + 1, y: self.frame.height / 2 + 1)
        if shouldLoad
        {
            self.setTitle("", for: .normal)
            UIView.animate(withDuration: 1, animations: {
                self.layer.cornerRadius = self.frame.height / 2
                self.frame = CGRect(x: self.frame.midX - (self.frame.height / 2), y: self.frame.origin.y, width: self.frame.height, height: self.frame.height)
            }) { (completed) in
                if completed
                {
                    spinnerView.center = CGPoint(x: self.frame.width / 2 + 1, y: self.frame.height / 2 + 1)
                    UIView.animate(withDuration: 0.2, delay: 0,  options: .curveEaseIn, animations: {
                        spinnerView.startAnimating()
                        spinnerView.alpha = 1
                    }, completion: nil)
                }
            }
            self.isUserInteractionEnabled = false
        }
        else
        {
            spinnerView.removeFromSuperview()
            self.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.2,  animations: {
                self.frame = self.originalSize!
            }) { (completed) in
                
            }
            self.setTitle(message, for: .normal)
        }
    }
}
