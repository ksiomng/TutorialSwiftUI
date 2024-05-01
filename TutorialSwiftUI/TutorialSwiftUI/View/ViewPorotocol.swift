//
//  ViewPorotocol.swift
//  TutorialSwiftUI
//
//  Created by Chung Wussup on 5/1/24.
//

import Foundation


protocol ViewPorotocol {
    
    func copyCode(_ code: String)
    func didDismiss()
    func sheetViewCode() -> String
    func basecode() -> String
}
