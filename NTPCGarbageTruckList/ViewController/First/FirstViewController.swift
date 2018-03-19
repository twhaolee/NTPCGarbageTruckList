//
//  FirstViewController.swift
//  NTPCGarbageTruckList
//
//  Created by Hao Lee on 2018/3/19.
//

import UIKit

class FirstViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func presentCityListAction(_ sender: UIButton) {
        let viewController = CityListViewController.initFromStoryboard(self.storyboard)

        self.show(viewController, sender: self)
    }

}
