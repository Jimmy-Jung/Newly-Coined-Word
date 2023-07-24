//
//  Font.swift
//  Newly-Coined-Word
//
//  Created by 정준영 on 2023/07/22.
//

import UIKit.UIFont

extension UIFont {
    enum Bemin: String {
        case BMHANNA_11yrs_ttf
        case BMHANNAAir_ttf
        case BMDOHYEON_ttf
    }
    
    static func BeminFont(font: Bemin, fontSize: CGFloat) -> UIFont {
        var customFont = ""

        switch font {
        case .BMDOHYEON_ttf:
            customFont = font.rawValue
        case .BMHANNAAir_ttf:
            customFont = font.rawValue
        case .BMHANNA_11yrs_ttf:
            customFont = font.rawValue
        }

        return UIFont(name: "\(customFont)", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .black)
    }
}
