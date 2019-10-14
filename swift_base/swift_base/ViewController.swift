//
//  ViewController.swift
//  swift_base
//
//  Created by JackLee on 2019/10/12.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit


enum Sex : Int {
    case Man
    case Woman
    case Unknow
}

enum Country : Int{
    case China
    case American
    case Japan
}

struct People {
    var age : Int?
    var sex : Sex? {
        didSet{
            switch self.sex {
            case .Man?:
                self.like = .Woman
            case .Woman?:
                self.like = .Man
            default:
                self.like = .Unknow
            }
        }
    }
    
    var like : Sex?
    var country : Country?
    mutating func setValue(fromData data: Data) ->People? {
        if data.count < 3{
            return nil
        }
        self.age = Int(data[0])
        self.sex = Sex(rawValue: Int(data[1]))
        self.country = Country(rawValue: Int(data[2]))
        return self
    }
}


struct Traffic {
    //1 byte
    var type : TrafficType!
    
    var speed: Int? = 0//2 byte
    
    var speedUnit : SpeedUnit? = nil
    
    init(fromBusWithSpeed speed: Int){
        self.type = .Bus
        self.speed = speed
//        self.speedUnit = speedUnit
    }
    
//    init(fromBus )
    
    init(fromData data: Data){
        if data.count > 4 {
            return
        }
        self.type = TrafficType(rawValue: Int(data[0]))
        self.speed = Int(data[1]+data[2])
        self.speedUnit = SpeedUnit(rawValue: Int(data[3]))
    }
}

enum SpeedUnit: Int {
    case KmH
    case MH
    case MMins
}

enum TrafficType: Int {
    case Bus
    case Airplane
    case Subway
    case Bike
}


class EveryDay: NSObject {
    var findSth : (People?()) = {
        someone in
        print(someone)
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        testTraffic()
    }
    
    func testTraffic() {
        
//        var data = Data()
//        data.append(Data(bytes: [UInt8(10)], count: 1))
//        data.append(Data(bytes: [UInt16(300)], count: 2))
//        data.append(Data(bytes: [UInt8(2)], count: 1))
        
        let bytes : [UInt8] = [0x01,0x2c,0x01,0x02]
        let data = Data(bytes)
        
        for i in 0..<bytes.count {
            print(bytes[i])
        }
        
        
        let traffic = Traffic(fromData: data)
        let type = traffic.type
        let speed = traffic.speed
        let speedUnit = traffic.speedUnit
        
        
        print("traffic:\(String(describing: type)),\(String(describing: speed)),\(String(describing: speedUnit))")
        
        
        
        
        let traffic2 = Traffic(fromBusWithSpeed: 100)
        
        print("traffic2:\(String(describing: traffic2.type)),\(String(describing:  traffic2.speed)),\(String(describing:  traffic2.speedUnit))")
    }
    
    
    func testPeople() {
        
        var data = Data()
        data.append(Data(bytes: [UInt8(10)], count: 1))
        data.append(Data(bytes: [UInt8(1)], count: 1))
        data.append(Data(bytes: [UInt8(3)], count: 1))
        
        var newPeople = People()
        
        let people = newPeople.setValue(fromData: data)
        
        let age = people?.age
        let sex = people?.sex
        let like = people?.like
        //        let like = people.setValue(fromData: data)?.like
        //        let country = people.setValue(fromData: data)?.country
        print("people:\(String(describing: age)),\(String(describing: sex)),\(String(describing: like))")
    }
    
    
    
}

