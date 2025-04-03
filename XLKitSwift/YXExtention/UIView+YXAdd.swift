//
//  UIView+YXExtension.swift
//  YXKitSwift
//
//  Created by zx on 2021/9/3.
//

import UIKit

public extension UIView {
    
    // MARK: - Public Func
    
    /// 添加并排列视图
    /// - Parameters:
    ///   - views: 子视图集合
    ///   - padding: 固定间距
    func yx_sortSubviews(views: [UIView], padding: CGFloat) {
        yx_sortSubviews(views: views, padding: padding, paddings: nil)
    }
    
    /// 添加并排列视图
    /// - Parameters:
    ///   - views: 子视图集合
    ///   - padding: 间距集合
    func yx_sortSubviews(views: [UIView], paddings: [CGFloat]) {
        yx_sortSubviews(views: views, padding: nil, paddings: paddings)
    }
    
    /// 横向排列子视图views
    /// - Parameters:
    ///   - views: 待排列子视图集合
    ///   - paddingH: 横向间距
    ///   - paddingV: 纵向间距
    ///   - isAutoWrap: 是否自动换行，默认true
    func yx_sortSubviewsByHorizontal(views: [UIView], paddingH: CGFloat, paddingV: CGFloat, isAutoWrap: Bool? = true) {
        
        var lastView: UIView?
        
        for view in views {
            
            addSubview(view)
            let maxX = (lastView?.maxX ?? -paddingH) + view.width + paddingH
            
            /// 换行
            if isAutoWrap == true, maxX > width {
                view.minX = 0
                view.minY = (lastView?.maxY ?? -paddingV) + paddingV
            }
            /// 不换行
            else {
                view.maxX = maxX
                view.minY = lastView?.minY ?? 0
            }
            
            lastView = view
        }
    }
    
    /// 添加虚线
    /// - Parameters:
    ///   - points: 每个拐角的点
    ///   - lineWidth: 每段虚线宽度
    ///   - lineSpace: 每段虚线间隔
    ///   - lineHeight: 虚线高度
    ///   - lineColor: 虚线颜色
    func yx_addDashLine(points: [CGPoint]?, lineWidth: CGFloat? = 2, lineSpace: CGFloat? = 2, lineHeight: CGFloat? = 1, lineColor: UIColor?) {
        
        guard let points = points, let lineWidth = lineWidth, let lineSpace = lineSpace, let lineHeight = lineHeight, let lineColor = lineColor else { return }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.bounds
        shapeLayer.position = CGPoint(x: self.width / 2.0, y: self.height / 2.0)
        shapeLayer.fillColor = lineColor.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineHeight
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = [NSNumber(value: Float(lineWidth)), NSNumber(value: Float(lineSpace))]
        
        let path = CGMutablePath()
        path.move(to: points.first ?? CGPoint.zero)
        points.forEach { point in
            path.addLine(to: point)
        }
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    
    // MARK: - Private
    
    /// 添加并排列视图
    /// - Parameters:
    ///   - views: 子视图集合
    ///   - padding: 固定间距
    ///   - paddings: 间距集合
    private func yx_sortSubviews(views: [UIView], padding: CGFloat? = 0, paddings: [CGFloat]? = nil) {
        
        var lastView: UIView?
        
        for (i, view) in views.enumerated() {
            
            addSubview(view)
            
            var space: CGFloat = padding ?? 0
            
            if let paddings = paddings {
                space = paddings[i]
            }
            
            view.minY = lastView?.maxY == nil ? view.minY : (lastView!.maxY + space)
            view.centerX = (view.superview?.width ?? 0) / 2
            
            lastView = view
        }
        
    }
    
    // MARK: - Dev
    
    /// 测试方法，添加标题
    func yxdev_addTitle(title: String?) {
        guard let title = title else { return }
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.textGradientColors([UIColor.red, UIColor.green], startPoint: CGPoint.zero, endPoint: CGPoint(x: label.width, y: 0))
        label.origin = CGPoint(x: 20, y: 10)
        addSubview(label)
    }

}

// MARK: - Frame

public extension UIView {
    
    /// 竖直方向最后一个视图
    @discardableResult
    func yx_lastVerticalView() -> UIView? {
        var lastView: UIView?
        for view in subviews {
            lastView = view.maxY >= (lastView?.maxY ?? 0) ? view : lastView
        }
        return lastView
    }
    
    /// 水平方向最后一个视图
    @discardableResult
    func yx_lastHorizontalView() -> UIView? {
        var lastView: UIView?
        for view in subviews {
            lastView = view.maxX >= (lastView?.maxX ?? 0) ? view : lastView
        }
        return lastView
    }
    
}
