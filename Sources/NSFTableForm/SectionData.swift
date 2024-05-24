//
//  SectionData.swift
//  FormGame
//
//  Created by Alex Orlov on 09.05.2022.
//

import Foundation

public struct SectionData {
    init(cells: [CellData] = []) {
        self.cells = cells
    }
    let cells: [CellData]
}
