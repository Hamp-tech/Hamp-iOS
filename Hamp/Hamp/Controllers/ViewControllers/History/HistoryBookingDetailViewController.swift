//
//  HistoryBookingDetailViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 13/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import MapKit

private enum TablePosition {
    case up
    case down
}

class HistoryBookingDetailViewController: HampViewController {
    
    // MARK: - IB Properties
    @IBOutlet private weak var map: MKMapView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewTopConstraint: NSLayoutConstraint!
    private var tablePosition = TablePosition.down
    private var foo: CGFloat!
    private lazy var tapTableViewGesture: UITapGestureRecognizer =  {
        let tapTableViewGesture = UITapGestureRecognizer.init(target: self, action: #selector(tableWasTapped(sender:)))
        return tapTableViewGesture
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.transaparentBar()
        
    
    }
    
    @objc func tableWasTapped(sender: UITapGestureRecognizer) {
        let foobar: CGFloat
        switch self.tablePosition {
        case .up:
            foobar = -30
        case .down:
            foobar = -(tableView.frame.origin.y - navigationController!.navigationBar.frame.height)
        }
        
        self.tablePosition = self.tablePosition == .up ? .down : .up
        
        self.tableViewTopConstraint.constant = foobar

    }

}

extension HistoryBookingDetailViewController: UITableViewDelegate {
    
}

extension HistoryBookingDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
}

private extension HistoryBookingDetailViewController {
    
}

