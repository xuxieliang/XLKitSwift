//
//  UIImage+YXAdd.swift
//  YXKitSwift
//
//  Created by zx on 2021/12/1.
//

import UIKit

public enum YXImageArrowDirection {
    case up
    case down
    case left
    case right
}

public extension UIImage {
    
    /// 颜色生成图片
    static func yx_image(_ color: UIColor, _ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
        return image
    }
    
    /// 颜色生成图片
    static func yx_image(_ color: Int, _ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return yx_image(UIColor(color), size)
    }
    
    /// 图片变颜色
    func yx_imageByTintColor(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        color.set()
        UIRectFill(rect)
        draw(at: CGPoint.zero, blendMode: .destinationIn, alpha: 1)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image ?? self
    }
    
    /// 根据内容，生成二维码
    /// - Parameters:
    ///   - content: 二维码的内容
    ///   - size: 二维码大小
    static func yx_QRCodeImage(form content: String?, size: CGFloat) -> UIImage? {
        
        guard let data = content?.data(using: .utf8) else {
            return nil
        }
        
        guard let image = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data])?.outputImage else {
            return nil
        }

        let extent = image.extent.integral
        let scale = min(size / extent.width, size / extent.height)
        
        let width = size_t(extent.width * scale)
        let height = size_t(extent.height * scale)
        let cs = CGColorSpaceCreateDeviceGray()
        
        guard let bitmap = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: 1) else {
            return nil
        }
        
        let context = CIContext()
        guard let bitmapImage = context.createCGImage(image, from: extent) else {
            return nil
        }
        bitmap.interpolationQuality = .none
        bitmap.scaleBy(x: scale, y: scale)
        bitmap.draw(bitmapImage, in: extent)
        
        guard let scaledImage = bitmap.makeImage() else {
            return nil
        }
        
        return UIImage(cgImage: scaledImage)
    }
    
    /// 画箭头
    static func yx_drawArrow(direction: YXImageArrowDirection, size: CGFloat, color: UIColor, strokeWidth: CGFloat) -> UIImage {
        
        let offset = strokeWidth / 2.0
        let imageSize = direction == .up || direction == .down ? CGSize(width: size, height: size / 2.0 + offset) : CGSize(width: size / 2.0 + offset, height: size + offset)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        guard UIGraphicsGetCurrentContext() != nil else { return UIImage() }
        
        // Arrow drawing path
        let arrowPath = UIBezierPath()
        switch direction {
        case .up:
            arrowPath.move(to: CGPoint(x: 0, y: imageSize.height))
            arrowPath.addLine(to: CGPoint(x: imageSize.width / 2.0, y: offset))
            arrowPath.addLine(to: CGPoint(x: imageSize.width, y: imageSize.height))
        case .down:
            arrowPath.move(to: CGPoint(x: 0, y: 0))
            arrowPath.addLine(to: CGPoint(x: imageSize.width / 2.0, y: imageSize.height - offset))
            arrowPath.addLine(to: CGPoint(x: imageSize.width, y: 0))
        case .left:
            arrowPath.move(to: CGPoint(x: imageSize.width, y: 0))
            arrowPath.addLine(to: CGPoint(x: offset, y: imageSize.height / 2.0))
            arrowPath.addLine(to: CGPoint(x: imageSize.width, y: imageSize.height))
        case .right:
            arrowPath.move(to: CGPoint(x: 0, y: 0))
            arrowPath.addLine(to: CGPoint(x: imageSize.width - offset, y: imageSize.height / 2.0))
            arrowPath.addLine(to: CGPoint(x: 0, y: imageSize.height))
        }
        
        color.setStroke()
        color.setFill()
        arrowPath.lineWidth = strokeWidth
        arrowPath.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }

    /// 画关闭按钮
    static func yx_drawCloseImage(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)
        
        // Draw the lines of the cross shape
        context.move(to: CGPoint(x: lineWidth, y: lineWidth))
        context.addLine(to: CGPoint(x: size.width - lineWidth, y: size.height - lineWidth))
        context.move(to: CGPoint(x: size.width - lineWidth, y: lineWidth))
        context.addLine(to: CGPoint(x: lineWidth, y: size.height - lineWidth))
        
        context.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image ?? UIImage()
    }
}

