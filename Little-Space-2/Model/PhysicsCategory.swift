//
//  PhysicsCategory.swift
//  Little-Space-2
//
//  Created by Henry Calderon on 7/8/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import Foundation

struct PhysicsCategory {
    static let None:      UInt32 = 0          // 0000000
    static let Ship:      UInt32 = 0b1        // 0000001
    static let Meteor:    UInt32 = 0b10       // 0000010
    static let Bullet:    UInt32 = 0b100
}
