//
//  NewStruct.swift
//  newproj
//
//  Created by Andrei Volkau on 28.01.2021.
//

import Foundation

struct Packet: Codable {
    var version: String?
    var data: Int? //change to String?
    
    private enum CodingKeys: String, CodingKey {
        case version, data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        version = try values.decode(String?.self, forKey: .version)
        
        if (try? values.decode(Int?.self, forKey: .data)) != nil {
            data = try values.decode(Int?.self, forKey: .data)
        } else if (try? values.decode(String?.self, forKey: .data)) != nil {
            data = 1234
        }
        /*
         if (try? values.decode(String?.self, forKey: .data)) != nil {
             data = try values.decode(String?.self, forKey: .data)
         } else if (try? values.decode(Int?.self, forKey: .data)) != nil {
             data = "newDataValue"
         }
         */
        
    }
    init() { }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try container.encode(version, forKey: .version)
    }
}
