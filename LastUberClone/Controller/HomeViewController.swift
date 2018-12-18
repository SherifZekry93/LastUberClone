//
//  ViewController.swift
//  LastUberClone
//
//  Created by Sherif  Wagih on 12/18/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import MapKit
class HomeViewController: UIViewController,MKMapViewDelegate {
    var delegate:CenterVCDelegate?
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func requestRideButtonClick(_ sender: RoundedShadowButton) {
        
    }
    
    @IBAction func toggleSideMenu(_ sender: UIButton) {
        delegate?.toggleLeftPanel()
    }
}
