//
//  ScannedDeviceTableViewCell.swift
//  BLESYNC
//
//  Created by Prince on 18/05/24.
//

import UIKit

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
    
}
