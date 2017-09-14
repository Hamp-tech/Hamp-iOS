//
//  PulleyViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 13/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

private let kPulleyDefaultCollapsedHeight: CGFloat = 264.0

public class PulleyViewController: HampViewController {
    
    // MARK: - IB Properties
    @IBOutlet public var primaryContentContainerView: UIView!
    @IBOutlet public var drawerContentContainerView: UIView!
    
    // MARK: - Properties
    private let primaryContentContainer: UIView = UIView()
    private let drawerContentContainer: UIView = UIView()
    private let drawerScrollView: PulleyPassthroughScrollView = PulleyPassthroughScrollView()
    private var lastDragTargetContentOffset: CGPoint = CGPoint.zero
    public private(set) var primaryContentViewController: UIViewController! {
        willSet {
            guard let controller = primaryContentViewController else { return }
            
            controller.view.removeFromSuperview()
            controller.willMove(toParentViewController: nil)
            controller.removeFromParentViewController()
        }
        
        didSet {
            
            guard let controller = primaryContentViewController else { return }
            
            controller.view.translatesAutoresizingMaskIntoConstraints = true
            
            self.primaryContentContainer.addSubview(controller.view)
            self.addChildViewController(controller)
            controller.didMove(toParentViewController: self)
            
            if self.isViewLoaded {
                self.view.setNeedsLayout()
                self.setNeedsSupportedDrawerPositionsUpdate()
            }
        }
    }
    
    public private(set) var drawerContentViewController: UIViewController! {
        willSet {
            guard let controller = drawerContentViewController else { return }
            
            controller.view.removeFromSuperview()
            controller.willMove(toParentViewController: nil)
            controller.removeFromParentViewController()
        }
        
        didSet {
            guard let controller = drawerContentViewController else { return }
            
            controller.view.translatesAutoresizingMaskIntoConstraints = true
            
            self.drawerContentContainer.addSubview(controller.view)
            self.addChildViewController(controller)
            controller.didMove(toParentViewController: self)
            
            if self.isViewLoaded {
                self.view.setNeedsLayout()
                self.setNeedsSupportedDrawerPositionsUpdate()
            }
        }
    }
    
    public private(set) var drawerPosition: PulleyPosition = .collapsed {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    @IBInspectable public var topInset: CGFloat = 80.0 {
        didSet {
            if self.isViewLoaded {
                self.view.setNeedsLayout()
            }
        }
    }
    
    public var initialDrawerPosition: PulleyPosition = .collapsed
    private var supportedDrawerPositions: [PulleyPosition] = PulleyPosition.all {
        didSet {
            
            guard self.isViewLoaded else { return }
            
            guard supportedDrawerPositions.count > 0 else {
                supportedDrawerPositions = PulleyPosition.all
                return
            }
            
            self.view.setNeedsLayout()
            
            if supportedDrawerPositions.contains(drawerPosition) {
                setDrawerPosition(position: drawerPosition)
            }
            else {
                let lowestDrawerState: PulleyPosition = supportedDrawerPositions.min { (pos1, pos2) -> Bool in
                    return pos1.rawValue < pos2.rawValue
                    } ?? .collapsed
                
                setDrawerPosition(position: lowestDrawerState, animated: false)
            }
            
            drawerScrollView.isScrollEnabled = supportedDrawerPositions.count > 1
        }
    }
    
    // MARK: - Life cycle
    required public init(contentViewController: UIViewController, drawerViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.primaryContentViewController = contentViewController
        self.drawerContentViewController = drawerViewController
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func loadView() {
        super.loadView()
    
        if primaryContentContainerView != nil { primaryContentContainerView.removeFromSuperview() }
        
        if drawerContentContainerView != nil { drawerContentContainerView.removeFromSuperview() }
        
        primaryContentContainer.backgroundColor = UIColor.white
        
        definesPresentationContext = true
        
        drawerScrollView.bounces = false
        drawerScrollView.delegate = self
        drawerScrollView.clipsToBounds = false
        drawerScrollView.showsVerticalScrollIndicator = false
        drawerScrollView.showsHorizontalScrollIndicator = false
        drawerScrollView.delaysContentTouches = true
        drawerScrollView.canCancelContentTouches = true
        drawerScrollView.backgroundColor = UIColor.clear
        drawerScrollView.decelerationRate = UIScrollViewDecelerationRateFast
        drawerScrollView.scrollsToTop = false
        drawerScrollView.touchDelegate = self
        
        drawerContentContainer.backgroundColor = UIColor.clear
        
        drawerScrollView.addSubview(drawerContentContainer)
        
        primaryContentContainer.backgroundColor = UIColor.white
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(primaryContentContainer)
        self.view.addSubview(drawerScrollView)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.transaparentBar()
        
        // IB Support
        if primaryContentViewController == nil || drawerContentViewController == nil {
            // Locate main content VC
            for child in self.childViewControllers {
                if child.view == primaryContentContainerView.subviews.first {
                    primaryContentViewController = child
                } else if child.view == drawerContentContainerView.subviews.first {
                    drawerContentViewController = child
                }
            }
        }
        
        setDrawerPosition(position: initialDrawerPosition, animated: false)
        
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setNeedsSupportedDrawerPositionsUpdate()
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        primaryContentContainer.frame = self.primaryContentViewController.view.frame
        
        let collapsedHeight:CGFloat = kPulleyDefaultCollapsedHeight
        
        let lowestStop = [(self.view.bounds.size.height - topInset), collapsedHeight].min() ?? 0
        let bounceOverflowMargin: CGFloat = 20.0
        
        if supportedDrawerPositions.contains(.open) {
            drawerScrollView.frame = CGRect(x: 0, y: topInset, width: self.view.bounds.width, height: self.view.bounds.height - topInset)
        }
        
        drawerContentContainer.frame = CGRect(x: 0, y: drawerScrollView.bounds.height - lowestStop, width: drawerScrollView.bounds.width, height: drawerScrollView.bounds.height + bounceOverflowMargin)
        drawerScrollView.contentSize = CGSize(width: drawerScrollView.bounds.width, height: (drawerScrollView.bounds.height - lowestStop) + drawerScrollView.bounds.height)
        
        
        // Make VC views match frames
        primaryContentViewController?.view.frame = primaryContentContainer.bounds
        drawerContentViewController?.view.frame = CGRect(x: drawerContentContainer.bounds.minX, y: drawerContentContainer.bounds.minY, width: drawerContentContainer.bounds.width, height: drawerContentContainer.bounds.height)
        
        setDrawerPosition(position: drawerPosition, animated: false)
    }
    
    // MARK: Configuration Updates
    public func setDrawerPosition(position: PulleyPosition, animated: Bool = true) {
        guard supportedDrawerPositions.contains(position) else {
            print("PulleyViewController: You can't set the drawer position to something not supported by the current view controller contained in the drawer. If you haven't already, you may need to implement the PulleyDrawerViewControllerDelegate.")
            return
        }
        
        drawerPosition = position
        
        let collapsedHeight:CGFloat = kPulleyDefaultCollapsedHeight
        let stopToMoveTo: CGFloat
        
        switch drawerPosition {

        case .collapsed:
            stopToMoveTo = collapsedHeight
        case .open:
            stopToMoveTo = (self.view.bounds.size.height - topInset)
        }
        
        let drawerStops = [(self.view.bounds.size.height - topInset), collapsedHeight]
        let lowestStop = drawerStops.min() ?? 0
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: { [weak self] () -> Void in
                
                self?.drawerScrollView.setContentOffset(CGPoint(x: 0, y: stopToMoveTo - lowestStop), animated: false)
                
                if let drawer = self {
                    drawer.view.layoutIfNeeded()
                }
                
                }, completion: nil)
        } else {
            drawerScrollView.setContentOffset(CGPoint(x: 0, y: stopToMoveTo - lowestStop), animated: false)
        }
    }

    public func setPrimaryContentViewController(controller: UIViewController, animated: Bool = true) {
        if animated {
            UIView.transition(with: primaryContentContainer, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { [weak self] () -> Void in
                
                self?.primaryContentViewController = controller
                
                }, completion: nil)
        }
        else {
            primaryContentViewController = controller
        }
    }
    
    public func setDrawerContentViewController(controller: UIViewController, animated: Bool = true) {
        if animated {
            UIView.transition(with: drawerContentContainer, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { [weak self] () -> Void in
                
                self?.drawerContentViewController = controller
                self?.setDrawerPosition(position: self?.drawerPosition ?? .collapsed, animated: false)
                
                }, completion: nil)
        }
        else {
            drawerContentViewController = controller
            setDrawerPosition(position: drawerPosition, animated: false)
        }
    }
    
    public func setNeedsSupportedDrawerPositionsUpdate() {
        supportedDrawerPositions = PulleyPosition.all
    }
    
    // MARK: - Propogate child view controller style / status bar presentation based on drawer state
    
    override open var childViewControllerForStatusBarStyle: UIViewController? {
        get {
           return drawerPosition == .open ? drawerContentViewController : primaryContentViewController
        }
    }
    
    override open var childViewControllerForStatusBarHidden: UIViewController? {
        get {
            return drawerPosition == .open ? drawerContentViewController : primaryContentViewController
        }
    }
}

extension PulleyViewController: PulleyPassthroughScrollViewDelegate {
    
    func shouldTouchPassthroughScrollView(scrollView: PulleyPassthroughScrollView, point: CGPoint) -> Bool {
        let contentDrawerLocation = drawerContentContainer.frame.origin.y
        return point.y < contentDrawerLocation
    }
    
    func viewToReceiveTouch(scrollView: PulleyPassthroughScrollView) -> UIView {
        return primaryContentContainer
    }
}

extension PulleyViewController: UIScrollViewDelegate {
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == drawerScrollView {
            let collapsedHeight:CGFloat = kPulleyDefaultCollapsedHeight
            
            var drawerStops: [CGFloat] = [CGFloat]()
            
            if supportedDrawerPositions.contains(.open) {
                drawerStops.append((self.view.bounds.size.height - topInset))
            }
            
            if supportedDrawerPositions.contains(.collapsed) {
                drawerStops.append(collapsedHeight)
            }
            
            let lowestStop = drawerStops.min() ?? 0
            let distanceFromBottomOfView = lowestStop + lastDragTargetContentOffset.y
            var currentClosestStop = lowestStop
            
            for currentStop in drawerStops {
                if abs(currentStop - distanceFromBottomOfView) < abs(currentClosestStop - distanceFromBottomOfView) {
                    currentClosestStop = currentStop
                }
            }
            
            if abs(Float(currentClosestStop - (self.view.bounds.size.height - topInset))) <= Float.ulpOfOne && supportedDrawerPositions.contains(.open) {
                setDrawerPosition(position: .open, animated: true)
            } else if abs(Float(currentClosestStop - collapsedHeight)) <= Float.ulpOfOne && supportedDrawerPositions.contains(.collapsed) {
                setDrawerPosition(position: .collapsed, animated: true)
            }
        }
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView == drawerScrollView {
            lastDragTargetContentOffset = targetContentOffset.pointee
            targetContentOffset.pointee = scrollView.contentOffset
        }
    }
    
}

