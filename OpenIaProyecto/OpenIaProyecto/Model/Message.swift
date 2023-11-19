//
//  Message.swift
//  OpenIaProyecto
//
//  Created by Davis Cruz on 11/18/23.
//

import Foundation


struct Message: Identifiable {
    var id = UUID()
    var content: String
    var isFromUser: Bool
}
