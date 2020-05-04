//
//  MasterData.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 03/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation


struct Masterdata {
static func initiateDB() {
    SCSQLite.initWithDatabase("MasterData")
}
}
