//
//  ScanningViewController.swift
//  BLESYNC
//
//  Created by Prince on 18/05/24.
//

import Foundation
import UIKit

class ScanningViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ScanningText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ScannedDeviceTableViewCell.nib(), forCellReuseIdentifier: ScannedDeviceTableViewCell.cellIdentifier)
    }


}

extension ScanningViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScannedDeviceTableViewCell.cellIdentifier, for: indexPath) as? ScannedDeviceTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}
