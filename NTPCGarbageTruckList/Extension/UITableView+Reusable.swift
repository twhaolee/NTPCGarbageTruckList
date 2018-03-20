//
//  UITableView+Reusable.swift
//  NTPCGarbageTruckList
//
//  Created by Hao Lee on 2018/3/21.
//

import UIKit

extension UITableView {
    func register<T>(_ cellClass: T.Type) where T: UITableViewCell, T: Reusable {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T where T: UITableViewCell, T: Reusable {
        let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T

        assert(cell != nil, T.className() + "'s identifier isn't failure.")

        return cell!
    }
}
