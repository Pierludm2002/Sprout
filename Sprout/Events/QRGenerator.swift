//
//  QRGenerator.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 24/10/25.
//

import Foundation
import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeGenerator {
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    func make(from string: String, scale: CGFloat = 10) -> UIImage? {
        filter.message = Data(string.utf8)
        filter.correctionLevel = "M"
        guard let ci = filter.outputImage else { return nil }
        let scaled = ci.transformed(by: .init(scaleX: scale, y: scale))
        guard let cg = context.createCGImage(scaled, from: scaled.extent) else { return nil }
        return UIImage(cgImage: cg)
    }
}
