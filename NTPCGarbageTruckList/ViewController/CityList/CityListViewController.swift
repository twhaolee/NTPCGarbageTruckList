//
//  CityListViewController.swift
//  NTPCGarbageTruckList
//
//  Created by Hao Lee on 2018/3/19.
//

import UIKit

class CityListViewController: ViewController {

    @IBOutlet var collectionView: UICollectionView?

    var citys: [ZipcodeModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "City list"

        self.loadCityList()
    }

    func loadCityList() {
        NTPCOpenDataConnect.shared.getZipcodeList { [weak self] (datas, _) in
            guard let `self` = self else {
                return
            }
            guard let datas = datas else {
                assert(false, "Datas is empty")
                return
            }

            self.citys = datas

            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CityListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.citys.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as CityNameCollectionViewCell

        cell.cityNameLabel?.text = self.citys[indexPath.row].district

        return cell
    }
}
