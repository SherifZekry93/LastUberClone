//
//  ContainerVC.swift
//  LastUberClone
//
//  Created by Sherif  Wagih on 12/18/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import QuartzCore
enum SlideOutState{
    case collapsed
    case leftPanelExpanded
}
enum ShowWhichVC
{
    case homeVC
   // case Payment
}
var showVC:ShowWhichVC = .homeVC
class ContainerVC: UIViewController {
    var homeVC:HomeViewController!
    var leftVC:LeftSidePanelVC!
    var currentState:SlideOutState = .collapsed{
        didSet{
            let shouldShowShadow = (currentState != .collapsed)
            shouldShowShadowForCenterVC(shouldShowShadow)
        }
    }
    var isHidden = false
    var centerController:UIViewController!
    let centerPanelExpandedOffset:CGFloat = 160
    var tap:UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        initCenter(screen: showVC)
    }
    func initCenter(screen:ShowWhichVC)
    {
        var persentingController:UIViewController
        showVC = screen
        if homeVC == nil
        {
            homeVC = UIStoryboard.homeVC()
            homeVC.delegate = self
        }
        persentingController = homeVC
        if let con = centerController
        {
            con.view.removeFromSuperview()
            con.removeFromParent()
        }
        centerController = persentingController
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return UIStatusBarAnimation.slide
    }
    override var prefersStatusBarHidden: Bool{
        return isHidden
    }
}

extension ContainerVC:CenterVCDelegate
{
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        if notAlreadyExpanded
        {
            addLeftPanelVC()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftPanelVC() {
        if leftVC == nil
        {
            leftVC = UIStoryboard.leftSidePanelVC()
            addChildSidePanelVC(leftVC)
        }
    }
    
    @objc func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand
        {
            isHidden = !isHidden
            animateStatusBar()
            setupWhiteCoverView()
            currentState = .leftPanelExpanded
            anmiateCenterPanelXPosition(targetPosition: centerController.view.frame.width - centerPanelExpandedOffset)
        }
        else
        {
            isHidden = !isHidden
            animateStatusBar()
            hideWhiteCoverView()
            //currentState = .collapsed
            anmiateCenterPanelXPosition(targetPosition: 0) { (finished) in
                if finished
                {
                    self.currentState = .collapsed
                    self.leftVC = nil
                }
            }
        }
    }
    
    func animateStatusBar()
    {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
    func setupWhiteCoverView()
    {
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCoverView.alpha = 0
        whiteCoverView.backgroundColor = .white
        whiteCoverView.tag = 25
        
        centerController.view.addSubview(whiteCoverView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            whiteCoverView.alpha = 0.75
        }, completion: nil)
        tap = UITapGestureRecognizer(target: self, action: #selector(animateLeftPanel(shouldExpand:)))
        tap.numberOfTouchesRequired = 1
        self.centerController.view.addGestureRecognizer(tap)
    }
    func hideWhiteCoverView()
    {
        centerController.view.removeGestureRecognizer(tap)
        for subview in self.centerController.view.subviews
        {
            if subview.tag == 25
            {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    subview.alpha = 0
                }) { (completed) in
                    if completed
                    {
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
    func addChildSidePanelVC(_ sidePanelController:LeftSidePanelVC)
    {
        view.insertSubview(sidePanelController.view, at: 0)
        addChild(sidePanelController)
        sidePanelController.didMove(toParent: self)
    }
    func anmiateCenterPanelXPosition(targetPosition:CGFloat,completion: ((Bool) -> Void)! = nil)
    {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.centerController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    func shouldShowShadowForCenterVC(_ status:Bool)
    {
        if status
        {
            centerController.view.layer.shadowOpacity = 0.6
        }
        else
        {
            centerController.view.layer.shadowOpacity = 0
        }
    }
}
private extension UIStoryboard
{
    class func mainStoryBoard() ->UIStoryboard
    {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    class func leftSidePanelVC() -> LeftSidePanelVC?
    {
        return mainStoryBoard().instantiateViewController(withIdentifier: "LeftSidePanel") as? LeftSidePanelVC
    }
    class func homeVC() -> HomeViewController?
    {
         return mainStoryBoard().instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController
    }
}
