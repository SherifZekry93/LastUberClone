//
//  CenterVCDelegate.swift
//  LastUberClone
//
//  Created by Sherif  Wagih on 12/18/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelVC()
    func animateLeftPanel(shouldExpand:Bool)
}

