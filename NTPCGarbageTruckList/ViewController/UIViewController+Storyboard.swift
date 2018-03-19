//
//  UIViewController+Storyboard.swift
//  NTPCGarbageTruckList
//
//  Created by Hao Lee on 2018/3/19.
//

import UIKit

extension UIViewController {
    class func initFromStoryboard(_ storyboard: UIStoryboard? = nil,
                                  storyboardId: String? = nil) -> Self {

        let isEmptyId = storyboardId?.isEmpty ?? true

        var nonemptyStoryboard: UIStoryboard
        if let storyboard = storyboard {
            nonemptyStoryboard = storyboard
        } else if let storyboardName = Bundle.main.infoDictionary?["UIMainStoryboardFile"] as? String {
            nonemptyStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        } else {
            fatalError("The method need parameter: storyboard.")
        }

        var nonemptyStoryboardId: String
        if !isEmptyId {
            nonemptyStoryboardId = storyboardId!
        } else {
            nonemptyStoryboardId = self.className()
        }

        return UIViewController.initFromStoryboardHelper(storyboard: nonemptyStoryboard,
                                                         storyboardId: nonemptyStoryboardId)
    }

    private class func initFromStoryboardHelper<T>(storyboard: UIStoryboard, storyboardId: String) -> T {

        guard let controller = storyboard.instantiateViewController(withIdentifier: storyboardId) as? T else {
            fatalError(self.className() + " has not set an identifier.")
        }

        return controller
    }
}
