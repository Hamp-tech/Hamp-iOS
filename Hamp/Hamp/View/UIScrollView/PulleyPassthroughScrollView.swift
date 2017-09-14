//
//  PulleyPassthroughScrollView.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 14/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

protocol PulleyPassthroughScrollViewDelegate: class {
    func shouldTouchPassthroughScrollView(scrollView: PulleyPassthroughScrollView, point: CGPoint) -> Bool
    func viewToReceiveTouch(scrollView: PulleyPassthroughScrollView) -> UIView
}

class PulleyPassthroughScrollView: UIScrollView {

    // MARK: - Properties
    weak var touchDelegate: PulleyPassthroughScrollViewDelegate?

    // MARK: - Overriding
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        guard let touchDelegate = touchDelegate else { return super.hitTest(point, with: event) }
        
        guard touchDelegate.shouldTouchPassthroughScrollView(scrollView: self, point: point) else { return super.hitTest(point, with: event) }
        
        return touchDelegate.viewToReceiveTouch(scrollView: self)
                .hitTest(touchDelegate.viewToReceiveTouch(scrollView: self)
                .convert(point, from: self), with: event)
    }

}
