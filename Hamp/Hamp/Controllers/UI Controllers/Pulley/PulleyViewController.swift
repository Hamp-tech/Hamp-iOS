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
    @IBOutlet public var draggableContentContainerView: UIView!
    
    // MARK: - Properties
    private let primaryContentContainer: UIView = UIView()
    private let draggableContentContainer: UIView = UIView()
    private let draggableScrollView: PulleyPassthroughScrollView = PulleyPassthroughScrollView()
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
                self.setNeedsSupporteddraggablePositionsUpdate()
            }
        }
    }
    
    public private(set) var draggableContentViewController: UIViewController! {
        willSet {
            guard let controller = draggableContentViewController else { return }
            
            controller.view.removeFromSuperview()
            controller.willMove(toParentViewController: nil)
            controller.removeFromParentViewController()
        }
        
        didSet {
            guard let controller = draggableContentViewController else { return }
            
            controller.view.translatesAutoresizingMaskIntoConstraints = true
            
            self.draggableContentContainer.addSubview(controller.view)
            self.addChildViewController(controller)
            controller.didMove(toParentViewController: self)
            
            if self.isViewLoaded {
                self.view.setNeedsLayout()
                self.setNeedsSupporteddraggablePositionsUpdate()
            }
        }
    }
    
    public private(set) var draggablePosition: PulleyPosition = .collapsed {
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
    
    public var initialdraggablePosition: PulleyPosition = .collapsed
    private var supporteddraggablePositions: [PulleyPosition] = PulleyPosition.all {
        didSet {
            
            guard self.isViewLoaded else { return }
            
            guard supporteddraggablePositions.count > 0 else {
                supporteddraggablePositions = PulleyPosition.all
                return
            }
            
            self.view.setNeedsLayout()
            
            if supporteddraggablePositions.contains(draggablePosition) {
                setdraggablePosition(position: draggablePosition)
            }
            else {
                let lowestdraggableState: PulleyPosition = supporteddraggablePositions.min { (pos1, pos2) -> Bool in
                    return pos1.rawValue < pos2.rawValue
                    } ?? .collapsed
                
                setdraggablePosition(position: lowestdraggableState, animated: false)
            }
            
            draggableScrollView.isScrollEnabled = supporteddraggablePositions.count > 1
        }
    }
    
    // MARK: - Life cycle
    required public init(contentViewController: UIViewController, draggableViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.primaryContentViewController = contentViewController
        self.draggableContentViewController = draggableViewController
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func loadView() {
        super.loadView()
    
        if primaryContentContainerView != nil { primaryContentContainerView.removeFromSuperview() }
        
        if draggableContentContainerView != nil { draggableContentContainerView.removeFromSuperview() }
        
        primaryContentContainer.backgroundColor = UIColor.white
        
        definesPresentationContext = true
        
        draggableScrollView.bounces = false
        draggableScrollView.delegate = self
        draggableScrollView.clipsToBounds = false
        draggableScrollView.showsVerticalScrollIndicator = false
        draggableScrollView.showsHorizontalScrollIndicator = false
        draggableScrollView.delaysContentTouches = true
        draggableScrollView.canCancelContentTouches = true
        draggableScrollView.backgroundColor = UIColor.clear
        draggableScrollView.decelerationRate = UIScrollViewDecelerationRateFast
        draggableScrollView.scrollsToTop = false
        draggableScrollView.touchDelegate = self
        
        draggableContentContainer.backgroundColor = UIColor.clear
        
        draggableScrollView.addSubview(draggableContentContainer)
        
        primaryContentContainer.backgroundColor = UIColor.white
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(primaryContentContainer)
        self.view.addSubview(draggableScrollView)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.transaparentBar()
        
        draggableContentContainerView.backgroundColor = UIColor.green
        if primaryContentViewController == nil || draggableContentViewController == nil {
            for child in self.childViewControllers {
                if child.view == primaryContentContainerView.subviews.first {
                    primaryContentViewController = child
                }
                
                if child.view == draggableContentContainerView.subviews.first {
                    draggableContentViewController = child
                }
            }
        }
        setdraggablePosition(position: initialdraggablePosition, animated: false)
        
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsSupporteddraggablePositionsUpdate()
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        primaryContentContainer.frame = primaryContentViewController.view.frame
        
        let collapsedHeight:CGFloat = kPulleyDefaultCollapsedHeight
        
        let lowestStop = [(self.view.bounds.size.height - topInset), collapsedHeight].min() ?? 0
        
        if supporteddraggablePositions.contains(.open) {
            draggableScrollView.frame = CGRect(x: 0, y: topInset, width: self.view.bounds.width, height: self.view.bounds.height - topInset)

        }
        
        if draggableContentViewController != nil {
           draggableContentContainer.frame = CGRect(x: (draggableScrollView.bounds.width-draggableContentViewController.view.bounds.size.width)/2, y: draggableScrollView.bounds.height - lowestStop, width: draggableContentViewController.view.bounds.width, height: draggableScrollView.bounds.height)
        }
        
        draggableScrollView.contentSize = CGSize(width: draggableScrollView.bounds.width, height: (draggableScrollView.bounds.height - lowestStop) + draggableScrollView.bounds.height)
        
        
        primaryContentViewController?.view.frame = primaryContentContainer.bounds
        draggableContentViewController?.view.frame = CGRect(x: draggableContentContainer.bounds.minX, y: draggableContentContainer.bounds.minY, width: draggableContentContainer.bounds.width, height: draggableContentContainer.bounds.height)
        
        setdraggablePosition(position: draggablePosition, animated: false)
    }
    
    // MARK: Configuration Updates
    public func setdraggablePosition(position: PulleyPosition, animated: Bool = true) {
        
        draggablePosition = position
        
        let collapsedHeight:CGFloat = kPulleyDefaultCollapsedHeight
        let stopToMoveTo: CGFloat
        
        switch draggablePosition {

        case .collapsed:
            stopToMoveTo = collapsedHeight
        case .open:
            stopToMoveTo = (self.view.bounds.size.height - topInset)
        }
        
        let draggableStops = [(self.view.bounds.size.height - topInset), collapsedHeight]
        let lowestStop = draggableStops.min() ?? 0
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: { [weak self] () -> Void in
                
                self?.draggableScrollView.setContentOffset(CGPoint(x: 0, y: stopToMoveTo - lowestStop), animated: false)
                
                if let draggable = self {
                    draggable.view.layoutIfNeeded()
                }
                
                }, completion: nil)
        } else {
            draggableScrollView.setContentOffset(CGPoint(x: 0, y: stopToMoveTo - lowestStop), animated: false)
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
    
    public func setdraggableContentViewController(controller: UIViewController, animated: Bool = true) {
        if animated {
            UIView.transition(with: draggableContentContainer, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { [weak self] () -> Void in
                
                self?.draggableContentViewController = controller
                self?.setdraggablePosition(position: self?.draggablePosition ?? .collapsed, animated: false)
                
                }, completion: nil)
        }
        else {
            draggableContentViewController = controller
            setdraggablePosition(position: draggablePosition, animated: false)
        }
    }
    
    public func setNeedsSupporteddraggablePositionsUpdate() {
        supporteddraggablePositions = PulleyPosition.all
    }
    
    // MARK: - Propogate child view controller style / status bar presentation based on draggable state
    
    override open var childViewControllerForStatusBarStyle: UIViewController? {
        get {
           return draggablePosition == .open ? draggableContentViewController : primaryContentViewController
        }
    }
    
    override open var childViewControllerForStatusBarHidden: UIViewController? {
        get {
            return draggablePosition == .open ? draggableContentViewController : primaryContentViewController
        }
    }
}

extension PulleyViewController: PulleyPassthroughScrollViewDelegate {
    
    func shouldTouchPassthroughScrollView(scrollView: PulleyPassthroughScrollView, point: CGPoint) -> Bool {
        let contentdraggableLocation = draggableContentContainer.frame.origin.y
        return point.y < contentdraggableLocation
    }
    
    func viewToReceiveTouch(scrollView: PulleyPassthroughScrollView) -> UIView {
        return primaryContentContainer
    }
}

extension PulleyViewController: UIScrollViewDelegate {
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == draggableScrollView {
            let collapsedHeight:CGFloat = kPulleyDefaultCollapsedHeight
            
            var draggableStops: [CGFloat] = [CGFloat]()
            
            if supporteddraggablePositions.contains(.open) {
                draggableStops.append((self.view.bounds.size.height - topInset))
            }
            
            if supporteddraggablePositions.contains(.collapsed) {
                draggableStops.append(collapsedHeight)
            }
            
            let lowestStop = draggableStops.min() ?? 0
            let distanceFromBottomOfView = lowestStop + lastDragTargetContentOffset.y
            var currentClosestStop = lowestStop
            
            for currentStop in draggableStops {
                if abs(currentStop - distanceFromBottomOfView) < abs(currentClosestStop - distanceFromBottomOfView) {
                    currentClosestStop = currentStop
                }
            }
            
            if abs(Float(currentClosestStop - (self.view.bounds.size.height - topInset))) <= Float.ulpOfOne && supporteddraggablePositions.contains(.open) {
                setdraggablePosition(position: .open, animated: true)
            } else if abs(Float(currentClosestStop - collapsedHeight)) <= Float.ulpOfOne && supporteddraggablePositions.contains(.collapsed) {
                setdraggablePosition(position: .collapsed, animated: true)
            }
        }
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView == draggableScrollView {
            lastDragTargetContentOffset = targetContentOffset.pointee
            targetContentOffset.pointee = scrollView.contentOffset
        }
    }
    
}

