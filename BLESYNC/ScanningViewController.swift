//
//  ScanningViewController.swift
//  BLESYNC
//
//  Created by Prince on 18/05/24.
//

import Foundation
import UIKit
import CoreBluetooth
import Yams

class ScanningViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ScanningText: UILabel!
    
    // MARK: - Properties
    var centralManager: CBCentralManager?
    var discoveredDevices: [BLEDevice] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ScannedDeviceTableViewCell.nib(), forCellReuseIdentifier: ScannedDeviceTableViewCell.cellIdentifier)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
            self.centralManager?.stopScan()
            self.ScanningText.text = "Scanning Completed"
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.stopScanning()
        self.discoveredDevices = []
    }
    
    // MARK: - BLE Scan Methods
    func stopScanning() {
        centralManager?.stopScan()
        print("Scanning stopped.")
    }
    
}

// MARK: - Tableview Datasource and Delegate
extension ScanningViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.discoveredDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScannedDeviceTableViewCell.cellIdentifier, for: indexPath) as? ScannedDeviceTableViewCell else { return UITableViewCell() }
        cell.configureCellData(device:self.discoveredDevices[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.discoveredDevices[indexPath.row].isConnectable {
            
        }else {
            return
        }
    }
}

// MARK: - CBCentralManager and CBPeripheral Delegate
extension ScanningViewController: CBCentralManagerDelegate, CBPeripheralDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Bluetooth is powered on.")
            centralManager?.scanForPeripherals(withServices: nil, options: nil)
        case .poweredOff:
            print("Bluetooth is powered off.")
        case .resetting:
            print("Bluetooth is resetting.")
        case .unauthorized:
            print("Bluetooth is not authorized.")
        case .unsupported:
            print("Bluetooth is not supported.")
        case .unknown:
            print("Bluetooth state is unknown.")
        @unknown default:
            print("A new state is available that is not handled.")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        print("Discovered \(peripheral.name ?? "unknown device") at \(RSSI)")
        print("advertisementData -", advertisementData)
        
        var manufacturerDataString = "N/A"
        var companyName = "Unknown"
        var isConnectable = false
        
        if let connectable = advertisementData["kCBAdvDataIsConnectable"] as? Int {
            if connectable == 1 {
                isConnectable = true
            }else {
                isConnectable = false
            }
        }
        
        if let manufacturerData = advertisementData[CBAdvertisementDataManufacturerDataKey] as? Data {
            manufacturerDataString = manufacturerData.map { String(format: "%02hhx", $0) }.joined()
        }
        
        let device = BLEDevice(deviceName: peripheral.name ?? "Unknown Device", deviceUDID: "\(peripheral.identifier)", deviceManufacturer: manufacturerDataString, isConnectable: isConnectable, deviceRSSi: "\(RSSI)")
        
        if !discoveredDevices.contains(where: {$0.deviceUDID == device.deviceUDID}) {
            discoveredDevices.append(device)
        }
        
        self.tableView.reloadData()
    }
    
}
