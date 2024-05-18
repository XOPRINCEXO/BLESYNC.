//
//  ViewModel.swift
//  BLESYNC
//
//  Created by Prince on 18/05/24.
//

import Foundation

struct BLEDevice {
    var deviceName: String
    var deviceUDID: String
    var deviceManufacturer: String
    var isConnectable: Bool
    var deviceRSSi: String
    
    init(deviceName: String, deviceUDID: String, deviceManufacturer: String, isConnectable: Bool, deviceRSSi: String) {
        self.deviceName = deviceName
        self.deviceUDID = deviceUDID
        self.deviceManufacturer = deviceManufacturer
        self.isConnectable = isConnectable
        self.deviceRSSi = deviceRSSi
    }
}
