import UIKit
import Foundation

let area = 200.0

let squareMeters = Measurement(value: area, unit: UnitArea.squareMeters)

let squareFeet = squareMeters.converted(to: UnitArea.squareFeet)

let sqF = Measurement(value: area, unit: UnitArea.squareMeters).converted(to: UnitArea.squareFeet)
