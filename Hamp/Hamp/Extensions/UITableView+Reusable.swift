//
//  UITableView+Reusable.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

extension UITableView {
    /// Register cell
    ///
    /// - Parameter _: cell type to register
    func registerReusableCell<T: UITableViewCell>(_ : T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    /// Deque a reusable cell
    ///
    /// - Parameter indexPath: indexPath of cell
    /// - Returns: cell on this indexPath
    func dequeReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: Reusable  {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
}
