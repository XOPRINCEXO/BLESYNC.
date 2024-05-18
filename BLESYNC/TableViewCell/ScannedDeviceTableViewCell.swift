//
//  ScannedDeviceTableViewCell.swift
//  BLESYNC
//
//  Created by Prince on 18/05/24.
//

import UIKit
import CoreBluetooth

class ScannedDeviceTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mainCellView: UIView!
    @IBOutlet weak var deviceManufacturer: UILabel!
    @IBOutlet weak var deviceMacAddress: UILabel!
    @IBOutlet weak var deviceName: UILabel!
    @IBOutlet weak var deviceIcon: UIImageView!
    @IBOutlet weak var rfValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUi()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class var cellIdentifier: String {
        get {
            return "ScannedDeviceTableViewCell"
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ScannedDeviceTableViewCell", bundle: nil)
    }
    
    private func setupUi() {
        self.mainCellView.layer.cornerRadius = 10
    }
    
    func configureCellData(device: BLEDevice) {
        self.deviceName.text = device.deviceName
        self.deviceMacAddress.text = "\(device.deviceUDID)"
        self.rfValue.text = device.deviceRSSi
        self.deviceManufacturer.text = device.deviceManufacturer
        
        if self.deviceName.text == "Unknown Device" {
            self.deviceIcon.image = UIImage(systemName: "questionmark.circle.fill")
        }else {
            self.deviceIcon.image = UIImage(systemName: "headphones")
        }
        
        if device.isConnectable {
            self.deviceName.textColor = .red
        }else {
            self.deviceName.textColor = .black
        }
    }
    
}
