//
//  PermissionUtil.swift
//  swift_demo
//
//  Created by JackLee on 2019/10/26.
//  Copyright © 2019 Jack. All rights reserved.
//

import Foundation
import CoreBluetooth

typealias PermissionHandler = ((Bool) -> ())

internal protocol PermissionUtilProtocal {
    func checkBluetooth(resultHandler: @escaping  PermissionHandler)
}


class PermissionUtil: NSObject {
    
    private var centralManager: CBCentralManager?
//    private var bluetoothResultHandler: PermissionHandler?
    
    override init() {
        super.init()
        let centralManagerOps = [CBCentralManagerOptionShowPowerAlertKey: false]
        self.centralManager = CBCentralManager.init(delegate: self, queue: nil, options: centralManagerOps)
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(notification:)), name: .applicationDidEnterBackground, object: nil)
    }
    
    @objc func applicationDidEnterBackground(notification: Notification) {
//        self.centralManager = nil
    }
}

extension PermissionUtil: PermissionUtilProtocal {

    func checkBluetooth(resultHandler: @escaping PermissionHandler) {
        print("self.centralManager:", self.centralManager?.state.rawValue as Any)
        guard let state = self.centralManager?.state, state != .unknown else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.checkBluetooth(resultHandler: resultHandler)
            }
            return
        }
        
        if state == .poweredOn {
            resultHandler(true)
        }
        else {
            resultHandler(false)
        }
    }
}

extension PermissionUtil: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {

        switch central.state {
            //for printing
        case .poweredOff:
            print("central.state change to .poweredOff", central.state.rawValue)
        case .unknown:
            print("central.state change to .unknown", central.state.rawValue)
        case .resetting:
            print("central.state change to .resetting", central.state.rawValue)
        case .unsupported:
            print("central.state change to .unsupported", central.state.rawValue)
        case .unauthorized:
            print("central.state change to .unauthorized", central.state.rawValue)
        case .poweredOn:
            print("central.state change to .poweredOn", central.state.rawValue)
        }
    }
}
