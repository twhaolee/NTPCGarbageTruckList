//
//  UICollectionView+Reusable.swift
//  NTPCGarbageTruckList
//
//  Created by Hao Lee on 2018/3/20.
//

import UIKit

extension UICollectionView {
    func register<T>(_ cellClass: T.Type) where T: UICollectionViewCell, T: Reusable {
        self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T where T: UICollectionViewCell, T: Reusable {
        let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T

        assert(cell != nil, T.className() + "'s identifier isn't failure.")

        return cell!
    }
}
