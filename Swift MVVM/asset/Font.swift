//
//  Font.swift
//  MathflatTeacher
//
//  Created by DONHO KO on 2020/10/19.
//

import SwiftUI

extension Font {
    static func spoqa(size:CGFloat = 10) -> Font {
        return Font.custom("SpoqaHanSans-Regular", size:size)
    }
    
    static func spoqaBold(size:CGFloat = 10) -> Font {
        return Font.custom("SpoqaHanSans-Bold", size:size)
    }
}

struct Spoqa {
    static let h1_48 = Font.spoqa(size: 48)
    static let h1_48_bold = Font.spoqaBold(size: 48)

    static let h2_32 = Font.spoqa(size: 32)
    static let h2_32_bold = Font.spoqaBold(size: 32)

    static let h3_24 = Font.spoqa(size: 24)
    static let h3_24_bold = Font.spoqaBold(size: 24)

    static let h4_20 = Font.spoqa(size: 20)
    static let h4_20_bold = Font.spoqaBold(size: 20)

    static let h5_18 = Font.spoqa(size: 18)
    static let h5_18_bold = Font.spoqaBold(size: 18)

    static let body1_16 = Font.spoqa(size: 16)
    static let body1_16_bold = Font.spoqaBold(size: 16)

    static let body2_14 = Font.spoqa(size: 14)
    static let body2_14_bold = Font.spoqaBold(size: 14)

    static let caption1_12 = Font.spoqa(size: 12)
    static let caption1_12_bold = Font.spoqaBold(size: 12)
    
    static let caption2_9 = Font.spoqa(size: 9)
    static let caption2_9_bold = Font.spoqaBold(size: 9)
}
