//
//  GarbageTruckListViewController.swift
//  NTPCGarbageTruckList
//
//  Created by Hao Lee on 2018/3/19.
//

import UIKit

class GarbageTruckListViewController: ViewController {

    @IBOutlet var tableView: UITableView?

    var cityName: String?

    var stations: [GarbageStationModel] = []
    var connectionStatus = ConnectionStatus.idle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.cityName

        self.loadGarbageStationInfoList()
    }

    func loadGarbageStationInfoList() {
        guard self.connectionStatus == .idle else { return }
        self.connectionStatus = .connecting

        guard let cityName = cityName else { return }

        guard !cityName.isEmpty else { return }

        let taskCompletionHandler = { [weak self] (datas: [GarbageStationModel]?, _: Error?) in
            guard let `self` = self else {
                return
            }

            defer {
                if datas?.isEmpty == true {
                    self.connectionStatus = .eof
                } else {
                    self.connectionStatus = .idle
                }
            }

            guard let datas = datas else {
                assert(false, "Datas is empty")
                return
            }

            self.stations += datas

            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }

        NTPCOpenDataConnect.shared.getGarbageStationInfoList(startIndex: UInt(self.stations.count),
                                                             limit: 200,
                                                             on: cityName,
                                                             completionHandler: taskCompletionHandler)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension GarbageTruckListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as GarbageTruckTableViewCell

        let stationInfo = self.stations[indexPath.row]
        cell.nameLabel?.text = stationInfo.name
        cell.timeLabel?.text = stationInfo.time

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.stations.count - 20 < indexPath.row {
            self.loadGarbageStationInfoList()
        }
    }
}
