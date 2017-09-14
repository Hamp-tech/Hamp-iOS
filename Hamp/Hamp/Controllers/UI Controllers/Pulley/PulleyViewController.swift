//
//  PulleyViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 13/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

@objc public protocol PulleyDelegate: class {
    
    @objc optional func drawerPositionDidChange(drawer: PulleyViewController)
    @objc optional func makeUIAdjustmentsForFullscreen(progress: CGFloat)
    @objc optional func drawerChangedDistanceFromBottom(drawer: PulleyViewController, distance: CGFloat)
}

public protocol PulleyDrawerViewControllerDelegate: PulleyDelegate {
    
    func collapsedDrawerHeight() -> CGFloat
    func partialRevealDrawerHeight() -> CGFloat
    func supportedDrawerPositions() -> [PulleyPosition]
}

public protocol PulleyPrimaryContentControllerDelegate: PulleyDelegate {
    
    // Not currently used for anything, but it's here for parity with the hopes that it'll one day be used.
}
private let kPulleyDefaultCollapsedHeight: CGFloat = 68.0
private let kPulleyDefaultPartialRevealHeight: CGFloat = 264.0

public class PulleyViewController: HampViewController {
    
    // Interface Builder
    
    /// When using with Interface Builder only! Connect a containing view to this outlet.
    @IBOutlet public var primaryContentContainerView: UIView!
    
    /// When using with Interface Builder only! Connect a containing view to this outlet.
    @IBOutlet public var drawerContentContainerView: UIView!
    
    // Internal
    private let primaryContentContainer: UIView = UIView()
    private let drawerContentContainer: UIView = UIView()
    private let drawerScrollView: PulleyPassthroughScrollView = PulleyPassthroughScrollView()
    
    private var lastDragTargetContentOffset: CGPoint = CGPoint.zero
    
    /// The current content view controller (shown behind the drawer).
    public private(set) var primaryContentViewController: UIViewController! {
        willSet {
            
            guard let controller = primaryContentViewController else {
                return;
            }
            
            controller.view.removeFromSuperview()
            controller.willMove(toParentViewController: nil)
            controller.removeFromParentViewController()
        }
        
        didSet {
            
            guard let controller = primaryContentViewController else {
                return;
            }
            
            controller.view.translatesAutoresizingMaskIntoConstraints = true
            
            self.primaryContentContainer.addSubview(controller.view)
            self.addChildViewController(controller)
            controller.didMove(toParentViewController: self)
            
            if self.isViewLoaded
            {
                self.view.setNeedsLayout()
                self.setNeedsSupportedDrawerPositionsUpdate()
            }
        }
    }
    
    /// The current drawer view controller (shown in the drawer).
    public private(set) var drawerContentViewController: UIViewController! {
        willSet {
            
            guard let controller = drawerContentViewController else {
                return;
            }
            
            controller.view.removeFromSuperview()
            controller.willMove(toParentViewController: nil)
            controller.removeFromParentViewController()
        }
        
        didSet {
            
            guard let controller = drawerContentViewController else {
                return;
            }
            
            controller.view.translatesAutoresizingMaskIntoConstraints = true
            
            self.drawerContentContainer.addSubview(controller.view)
            self.addChildViewController(controller)
            controller.didMove(toParentViewController: self)
            
            if self.isViewLoaded
            {
                self.view.setNeedsLayout()
                self.setNeedsSupportedDrawerPositionsUpdate()
            }
        }
    }
    
    /// The content view controller and drawer controller can receive delegate events already. This lets another object observe the changes, if needed.
    public weak var delegate: PulleyDelegate?
    
    /// The current position of the drawer.
    public private(set) var drawerPosition: PulleyPosition = .collapsed {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    /// The inset from the top of the view controller when fully open.
    @IBInspectable public var topInset: CGFloat = 50.0 {
        didSet {
            if self.isViewLoaded
            {
                self.view.setNeedsLayout()
            }
        }
    }
    
    /// The corner radius for the drawer.
    @IBInspectable public var drawerCornerRadius: CGFloat = 13.0 {
        didSet {
            if self.isViewLoaded
            {
                self.view.setNeedsLayout()
            }
        }
    }
    
    
    /// The starting position for the drawer when it first loads
    public var initialDrawerPosition: PulleyPosition = .collapsed
    
    /// This is here exclusively to support IBInspectable in Interface Builder because Interface Builder can't deal with enums. If you're doing this in code use the -initialDrawerPosition property instead. Available strings are: open, closed, partiallyRevealed, collapsed
    @IBInspectable public var initialDrawerPositionFromIB: String? {
        didSet {
            initialDrawerPosition = PulleyPosition.positionFor(string: initialDrawerPositionFromIB)
        }
    }
    
    /// The drawer positions supported by the drawer
    private var supportedDrawerPositions: [PulleyPosition] = PulleyPosition.all {
        didSet {
            
            guard self.isViewLoaded else {
                return
            }
            
            guard supportedDrawerPositions.count > 0 else {
                supportedDrawerPositions = PulleyPosition.all
                return
            }
            
            self.view.setNeedsLayout()
            
            if supportedDrawerPositions.contains(drawerPosition)
            {
                setDrawerPosition(position: drawerPosition)
            }
            else
            {
                let lowestDrawerState: PulleyPosition = supportedDrawerPositions.min { (pos1, pos2) -> Bool in
                    return pos1.rawValue < pos2.rawValue
                    } ?? .collapsed
                
                setDrawerPosition(position: lowestDrawerState, animated: false)
            }
            
            drawerScrollView.isScrollEnabled = supportedDrawerPositions.count > 1
        }
    }
    
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
        
        // IB Support
        if primaryContentContainerView != nil
        {
            primaryContentContainerView.removeFromSuperview()
        }
        
        if drawerContentContainerView != nil
        {
            drawerContentContainerView.removeFromSuperview()
        }
        
        // Setup
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(getCategoryName), name: NSNotification.Name(rawValue: "categoryName"), object: nil)
        
        // IB Support
        if primaryContentViewController == nil || drawerContentViewController == nil
        {
            assert(primaryContentContainerView != nil && drawerContentContainerView != nil, "When instantiating from Interface Builder you must provide container views with an embedded view controller.")
            
            // Locate main content VC
            for child in self.childViewControllers
            {
                if child.view == primaryContentContainerView.subviews.first
                {
                    primaryContentViewController = child
                }
                
                if child.view == drawerContentContainerView.subviews.first
                {
                    drawerContentViewController = child
                }
            }
            
            assert(primaryContentViewController != nil && drawerContentViewController != nil, "Container views must contain an embedded view controller.")
        }
        
        setDrawerPosition(position: initialDrawerPosition, animated: false)
        
        scrollViewDidScroll(drawerScrollView)
    }
    @objc func getCategoryName(_ notification: Notification)
    {
        self.navigationItem.title = notification.object as? String
        
    }
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setNeedsSupportedDrawerPositionsUpdate()
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Layout main content
        primaryContentContainer.frame = self.view.bounds
        
        // Layout container
        var collapsedHeight:CGFloat = kPulleyDefaultCollapsedHeight
        var partialRevealHeight:CGFloat = kPulleyDefaultPartialRevealHeight
        
        if let drawerVCCompliant = drawerContentViewController as? PulleyDrawerViewControllerDelegate
        {
            collapsedHeight = drawerVCCompliant.collapsedDrawerHeight()
            partialRevealHeight = drawerVCCompliant.partialRevealDrawerHeight()
        }
        
        let lowestStop = [(self.view.bounds.size.height - topInset), collapsedHeight, partialRevealHeight].min() ?? 0
        let bounceOverflowMargin: CGFloat = 20.0
        
        if supportedDrawerPositions.contains(.open)
        {
            // Layout scrollview
            drawerScrollView.frame = CGRect(x: 0, y: topInset, width: self.view.bounds.width, height: self.view.bounds.height - topInset)
        }
        else
        {
            // Layout scrollview
            let adjustedTopInset: CGFloat = supportedDrawerPositions.contains(.partiallyRevealed) ? partialRevealHeight : collapsedHeight
            drawerScrollView.frame = CGRect(x: 0, y: self.view.bounds.height - adjustedTopInset, width: self.view.bounds.width, height: adjustedTopInset)
        }
        
        drawerContentContainer.frame = CGRect(x: 0, y: drawerScrollView.bounds.height - lowestStop, width: drawerScrollView.bounds.width, height: drawerScrollView.bounds.height + bounceOverflowMargin)
        drawerScrollView.contentSize = CGSize(width: drawerScrollView.bounds.width, height: (drawerScrollView.bounds.height - lowestStop) + drawerScrollView.bounds.height)
        
        // Update rounding mask and shadows
        let borderPath = UIBezierPath(roundedRect: drawerContentContainer.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: drawerCornerRadius, height: drawerCornerRadius)).cgPath
        
        let cardMaskLayer = CAShapeLayer()
        cardMaskLayer.path = borderPath
        cardMaskLayer.frame = drawerContentContainer.bounds
        cardMaskLayer.fillColor = UIColor.white.cgColor
        cardMaskLayer.backgroundColor = UIColor.clear.cgColor
        drawerContentContainer.layer.mask = cardMaskLayer
        
        // Make VC views match frames
        primaryContentViewController?.view.frame = primaryContentContainer.bounds
        drawerContentViewController?.view.frame = CGRect(x: drawerContentContainer.bounds.minX, y: drawerContentContainer.bounds.minY, width: drawerContentContainer.bounds.width, height: drawerContentContainer.bounds.height)
        
        setDrawerPosition(position: drawerPosition, animated: false)
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Configuration Updates
    
    /**
     Set the drawer position, with an option to animate.
     
     - parameter position: The position to set the drawer to.
     - parameter animated: Whether or not to animate the change. (Default: true)
     */
    public func setDrawerPosition(position: PulleyPosition, animated: Bool = true)
    {
        guard supportedDrawerPositions.contains(position) else {
            
            print("PulleyViewController: You can't set the drawer position to something not supported by the current view controller contained in the drawer. If you haven't already, you may need to implement the PulleyDrawerViewControllerDelegate.")
            return
        }
        
        drawerPosition = position
        
        var collapsedHeight:CGFloat = kPulleyDefaultCollapsedHeight
        var partialRevealHeight:CGFloat = kPulleyDefaultPartialRevealHeight
        
        if let drawerVCCompliant = drawerContentViewController as? PulleyDrawerViewControllerDelegate
        {
            collapsedHeight = drawerVCCompliant.collapsedDrawerHeight()
            partialRevealHeight = drawerVCCompliant.partialRevealDrawerHeight()
        }
        
        let stopToMoveTo: CGFloat
        
        switch drawerPosition {
            
        case .collapsed:
            stopToMoveTo = collapsedHeight
            
        case .partiallyRevealed:
            stopToMoveTo = partialRevealHeight
            
        case .open:
            stopToMoveTo = (self.view.bounds.size.height - topInset)
            
        case .closed:
            stopToMoveTo = 0
        }
        
        let drawerStops = [(self.view.bounds.size.height - topInset), collapsedHeight, partialRevealHeight]
        let lowestStop = drawerStops.min() ?? 0
        
        if animated
        {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: { [weak self] () -> Void in
                
                self?.drawerScrollView.setContentOffset(CGPoint(x: 0, y: stopToMoveTo - lowestStop), animated: false)
                
                if let drawer = self
                {
                    drawer.delegate?.drawerPositionDidChange?(drawer: drawer)
                    (drawer.drawerContentViewController as? PulleyDrawerViewControllerDelegate)?.drawerPositionDidChange?(drawer: drawer)
                    (drawer.primaryContentViewController as? PulleyPrimaryContentControllerDelegate)?.drawerPositionDidChange?(drawer: drawer)
                    
                    drawer.view.layoutIfNeeded()
                }
                
                }, completion: nil)
        }
        else
        {
            drawerScrollView.setContentOffset(CGPoint(x: 0, y: stopToMoveTo - lowestStop), animated: false)
            
            delegate?.drawerPositionDidChange?(drawer: self)
            (drawerContentViewController as? PulleyDrawerViewControllerDelegate)?.drawerPositionDidChange?(drawer: self)
            (primaryContentViewController as? PulleyPrimaryContentControllerDelegate)?.drawerPositionDidChange?(drawer: self)
        }
    }
    
    /**
     Change the current primary content view controller (The one behind the drawer)
     
     - parameter controller: The controller to replace it with
     - parameter animated:   Whether or not to animate the change. Defaults to true.
     */
    public func setPrimaryContentViewController(controller: UIViewController, animated: Bool = true)
    {
        if animated
        {
            UIView.transition(with: primaryContentContainer, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { [weak self] () -> Void in
                
                self?.primaryContentViewController = controller
                
                }, completion: nil)
        }
        else
        {
            primaryContentViewController = controller
        }
    }
    
    /**
     Change the current drawer content view controller (The one inside the drawer)
     
     - parameter controller: The controller to replace it with
     - parameter animated:   Whether or not to animate the change.
     */
    public func setDrawerContentViewController(controller: UIViewController, animated: Bool = true)
    {
        if animated
        {
            UIView.transition(with: drawerContentContainer, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { [weak self] () -> Void in
                
                self?.drawerContentViewController = controller
                self?.setDrawerPosition(position: self?.drawerPosition ?? .collapsed, animated: false)
                
                }, completion: nil)
        }
        else
        {
            drawerContentViewController = controller
            setDrawerPosition(position: drawerPosition, animated: false)
        }
    }
    
    /**
     Update the supported drawer positions allows by the Pulley Drawer
     */
    public func setNeedsSupportedDrawerPositionsUpdate()
    {
        if let drawerVCCompliant = drawerContentViewController as? PulleyDrawerViewControllerDelegate
        {
            supportedDrawerPositions = drawerVCCompliant.supportedDrawerPositions()
        }
        else
        {
            supportedDrawerPositions = PulleyPosition.all
        }
    }
    
    // MARK: Actions
    
    // MARK: Propogate child view controller style / status bar presentation based on drawer state
    
    override open var childViewControllerForStatusBarStyle: UIViewController? {
        get {
            
            if drawerPosition == .open {
                return drawerContentViewController
            }
            
            return primaryContentViewController
        }
    }
    
    override open var childViewControllerForStatusBarHidden: UIViewController? {
        get {
            if drawerPosition == .open {
                return drawerContentViewController
            }
            
            return primaryContentViewController
        }
    }
}

extension PulleyViewController: PulleyPassthroughScrollViewDelegate {
    
    func shouldTouchPassthroughScrollView(scrollView: PulleyPassthroughScrollView, point: CGPoint) -> Bool
    {
        let contentDrawerLocation = drawerContentContainer.frame.origin.y
        
        if point.y < contentDrawerLocation
        {
            return true
        }
        
        return false
    }
    
    func viewToReceiveTouch(scrollView: PulleyPassthroughScrollView) -> UIView {
        return primaryContentContainer
    }
}

extension PulleyViewController: UIScrollViewDelegate {
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == drawerScrollView
        {
            // Find the closest anchor point and snap there.
            var collapsedHeight:CGFloat = kPulleyDefaultCollapsedHeight
            var partialRevealHeight:CGFloat = kPulleyDefaultPartialRevealHeight
            
            if let drawerVCCompliant = drawerContentViewController as? PulleyDrawerViewControllerDelegate
            {
                collapsedHeight = drawerVCCompliant.collapsedDrawerHeight()
                partialRevealHeight = drawerVCCompliant.partialRevealDrawerHeight()
            }
            
            var drawerStops: [CGFloat] = [CGFloat]()
            
            if supportedDrawerPositions.contains(.open)
            {
                drawerStops.append((self.view.bounds.size.height - topInset))
            }
            
            if supportedDrawerPositions.contains(.partiallyRevealed)
            {
                drawerStops.append(partialRevealHeight)
            }
            
            if supportedDrawerPositions.contains(.collapsed)
            {
                drawerStops.append(collapsedHeight)
            }
            
            let lowestStop = drawerStops.min() ?? 0
            
            let distanceFromBottomOfView = lowestStop + lastDragTargetContentOffset.y
            
            var currentClosestStop = lowestStop
            
            for currentStop in drawerStops
            {
                if abs(currentStop - distanceFromBottomOfView) < abs(currentClosestStop - distanceFromBottomOfView)
                {
                    currentClosestStop = currentStop
                }
            }
            
            if abs(Float(currentClosestStop - (self.view.bounds.size.height - topInset))) <= Float.ulpOfOne && supportedDrawerPositions.contains(.open)
            {
                setDrawerPosition(position: .open, animated: true)
            } else if abs(Float(currentClosestStop - collapsedHeight)) <= Float.ulpOfOne && supportedDrawerPositions.contains(.collapsed)
            {
                setDrawerPosition(position: .collapsed, animated: true)
            } else if supportedDrawerPositions.contains(.partiallyRevealed){
                setDrawerPosition(position: .partiallyRevealed, animated: true)
            }
        }
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView == drawerScrollView
        {
            lastDragTargetContentOffset = targetContentOffset.pointee
            
            // Halt intertia
            targetContentOffset.pointee = scrollView.contentOffset
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == drawerScrollView
        {
            var partialRevealHeight:CGFloat = kPulleyDefaultPartialRevealHeight
            var collapsedHeight:CGFloat = kPulleyDefaultCollapsedHeight
            
            if let drawerVCCompliant = drawerContentViewController as? PulleyDrawerViewControllerDelegate
            {
                collapsedHeight = drawerVCCompliant.collapsedDrawerHeight()
                partialRevealHeight = drawerVCCompliant.partialRevealDrawerHeight()
            }
            
            var drawerStops: [CGFloat] = [CGFloat]()
            
            if supportedDrawerPositions.contains(.open)
            {
                drawerStops.append((self.view.bounds.size.height - topInset))
            }
            
            if supportedDrawerPositions.contains(.partiallyRevealed)
            {
                drawerStops.append(partialRevealHeight)
            }
            
            if supportedDrawerPositions.contains(.collapsed)
            {
                drawerStops.append(collapsedHeight)
            }
            
            let lowestStop = drawerStops.min() ?? 0
            
            if scrollView.contentOffset.y > partialRevealHeight - lowestStop
            {
                // Calculate percentage between partial and full reveal
                let fullRevealHeight = (self.view.bounds.size.height - topInset)
                
                let progress = (scrollView.contentOffset.y - (partialRevealHeight - lowestStop)) / (fullRevealHeight - (partialRevealHeight))
                
                delegate?.makeUIAdjustmentsForFullscreen?(progress: progress)
                (drawerContentViewController as? PulleyDrawerViewControllerDelegate)?.makeUIAdjustmentsForFullscreen?(progress: progress)
                (primaryContentViewController as? PulleyPrimaryContentControllerDelegate)?.makeUIAdjustmentsForFullscreen?(progress: progress)
            }
            else {
                delegate?.makeUIAdjustmentsForFullscreen?(progress: 0.0)
                (drawerContentViewController as? PulleyDrawerViewControllerDelegate)?.makeUIAdjustmentsForFullscreen?(progress: 0.0)
                (primaryContentViewController as? PulleyPrimaryContentControllerDelegate)?.makeUIAdjustmentsForFullscreen?(progress: 0.0)
                
            }
        
        delegate?.drawerChangedDistanceFromBottom?(drawer: self, distance: scrollView.contentOffset.y + lowestStop)
        (drawerContentViewController as? PulleyDrawerViewControllerDelegate)?.drawerChangedDistanceFromBottom?(drawer: self, distance: scrollView.contentOffset.y + lowestStop)
        (primaryContentViewController as? PulleyPrimaryContentControllerDelegate)?.drawerChangedDistanceFromBottom?(drawer: self, distance: scrollView.contentOffset.y + lowestStop)
    }
}
}

