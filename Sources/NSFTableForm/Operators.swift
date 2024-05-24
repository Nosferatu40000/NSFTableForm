//
//  Operators.swift
//  FormGame
//
//  Created by Alex Orlov on 27.05.2022.
//

import Foundation

infix operator + : AdditionPrecedence
public func +(left: [SectionData], right: SectionData) -> [SectionData] {
    var left = left
    left.append(right)
    return left
}
public func +(left: SectionData, right: SectionData) -> [SectionData] {
    return [left, right]
}

precedencegroup FormGenerative { // создал группу под свой оператор
    associativity: left // Читаем слева - направо
    higherThan: AdditionPrecedence // Говорим, что приоритет выше, чем у сложения
}

infix operator <<< : FormGenerative // Присваиваем
public func <<<(left: SectionData, right: CellData) -> SectionData {
    var cells = left.cells
    cells.append(right)
    return SectionData(cells: cells)
}
public func <<<(left: [SectionData], right: CellData) -> [SectionData] {
    var cells = left.last?.cells ?? []
    cells.append(right)
    var sections = left
    sections.removeLast()
    sections.append(SectionData(cells: cells))
    return sections
}
