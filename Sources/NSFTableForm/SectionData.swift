//
//  SectionData.swift
//  FormGame
//
//  Created by Alex Orlov on 09.05.2022.
//

import Foundation

public struct SectionData {
    public init(cells: [CellData] = []) {
        self.cells = cells
    }
    public let cells: [CellData]
}
