//
//  GarbageTruckListViewController.swift
//  NTPCGarbageTruckList
//
//  Created by Hao Lee on 2018/3/19.
//

import UIKit

class GarbageTruckListViewController: ViewController {

    var cityName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.cityName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
