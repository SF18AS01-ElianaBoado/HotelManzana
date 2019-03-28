//
//  RoomType.swift
//  HotelManzana
//
//  Created by Eliana Boado on 3/7/19.
//  Copyright © 2019 Eliana Boado. All rights reserved.
//

import Foundation;

struct RoomType: Equatable {   //pp. 688, 706
    var id: Int;
    var name: String;
    var shortName: String;
    var price: Double;
    
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {   //p. 688
        return lhs.id == rhs.id;
    }
    
    static var all: [RoomType] {   //p. 706
        return [
            RoomType(id: 0, name: "Two Queens",      shortName: "2Q",  price: 179.00),
            RoomType(id: 1, name: "One King",        shortName: "K",   price: 209.00),
            RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309.00)
        ];
    }
}
