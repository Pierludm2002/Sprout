//
//  AppStyles.swift
//  Sprout
//
//  Created by Pierluigi De Meo on 18/10/25.
//

import SwiftUI

struct AppStyles {
    struct TextStyle{
        static let pageTitle  = Font.system(size: 32, weight: .bold, design: .rounded)
        static let subtitle = Font.system(size: 28, weight: .semibold, design: .rounded)
        static let subsubtitle = Font.system(size: 24, weight: .semibold, design: .rounded)
        static let body = Font.system(size: 22, weight: .regular, design: .rounded)
        static let secInfos = Font.system(size: 22, weight: .regular)
        static let highlight = Font.system(size: 22, weight: .bold, design: .rounded)
        
    }
    
    struct ColorStyle{
        static let primary = Color("Primary")
        static let secondary = Color.gray.opacity(0.8)
    }
}
