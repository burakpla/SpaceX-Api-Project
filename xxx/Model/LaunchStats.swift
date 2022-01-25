//
//  LaunchStats.swift
//  xxx
//
//  Created by Burak Pala on 25.01.2022.
//

import Foundation

struct LaunchStats:Decodable{
    let mission_name:String?
    let launch_year:String?
    let flight_number:Int?
    let links:LinkResponse?
    let details: String?
}
struct LinkResponse: Decodable {
    let mission_patch: String?
}


