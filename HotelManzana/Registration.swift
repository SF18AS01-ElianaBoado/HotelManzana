//
//  Registration.swift
//  HotelManzana
//
//  Created by Eliana Boado on 3/7/19.
//  Copyright © 2019 Eliana Boado. All rights reserved.
//

import Foundation;

struct Registration {
    var firstName: String;
    var lastName: String;
    var emailAddress: String;
    
    var checkInDate: Date;
    var checkOutDate: Date;
    
    var numberOfAdults: Int;
    var numberOfChildren: Int;
    
    var roomType: RoomType;
    var hasWifi: Bool;
}
