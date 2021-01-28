//
//  ViewController.swift
//  newproj
//
//  Created by Andrei Volkau on 28.01.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let encodeBtn = UIButton(type: .system)
        encodeBtn.setTitle("ENCODE", for: .normal)
        encodeBtn.backgroundColor = .systemRed
        encodeBtn.layer.cornerRadius = 50
        encodeBtn.addTarget(self, action: #selector(handleEncode), for: .touchUpInside)
        
        let decodeBtn = UIButton(type: .system)
        decodeBtn.setTitle("DECODE", for: .normal)
        decodeBtn.backgroundColor = .systemGray
        decodeBtn.layer.cornerRadius = 50
        decodeBtn.addTarget(self, action: #selector(handleDecode), for: .touchUpInside)
        
        view.addSubview(encodeBtn)
        view.addSubview(decodeBtn)
        
        encodeBtn.frame = .init(x: 0, y: 50, width: view.frame.width / 2, height: view.frame.height / 4)
        decodeBtn.frame = .init(x: 0, y: view.frame.height / 2, width: view.frame.width / 2, height: view.frame.height / 4)
        encodeBtn.center.x = view.center.x
        decodeBtn.center.x = view.center.x
    }
    
    @objc func handleEncode() {
        var packet = Packet()
        packet.data = 2
        packet.version = "1"
        APIPreferencesLoader.write(preferences: packet)
    }
    
    @objc func handleDecode() {
        let packet = APIPreferencesLoader.load()
        if let packet = packet {
            APIPreferencesLoader.write(preferences: packet) //for changed data
            print(packet)
        } else {
            print("Bad data or nil")
        }
    }
}
