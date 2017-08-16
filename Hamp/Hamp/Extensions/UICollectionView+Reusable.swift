//
//  UICollectionView.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

extension UICollectionView {
    /// Register cell
    ///
    /// - Parameter _: cell type to register
    func registerReusableCell<T: UICollectionViewCell>(_ : T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    /// Deque a reusable cell
    ///
    /// - Parameter indexPath: indexPath of cell
    /// - Returns: cell on this indexPath
    func dequeReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: Reusable  {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
