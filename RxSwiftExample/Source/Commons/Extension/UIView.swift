//
//  UIView.swift
//  airCloset
//
//  Created by Shohei Ohno on 2015/11/10.
//  Copyright © 2015年 Gungnir. All rights reserved.
//

import UIKit

extension UIView {

    // swiftlint:disable force_cast
    class func loadFromNib<T: UIView>(_ type: T.Type, bundle: Bundle = Bundle.main) -> T {
        return bundle.loadNibNamed(type.className, owner: self, options: nil)?.first as! T
    }

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    func roundView() {
        let minSize = min(bounds.width, bounds.height)
        layer.cornerRadius = minSize / 2
        layer.masksToBounds = true
    }

    func shadow(color: UIColor = UIColor.gray, radius: CGFloat = 1.0, offset: CGSize = CGSize(width: 1.0, height: 1.0), opacity: Float = 1.0) {
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }

    func border(_ borderColor: UIColor? = nil, borderWidth: CGFloat? = nil) {
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = borderWidth ?? 1
    }

    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = self.superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }

    func cornerRadius(corner: CGFloat) {
        layer.cornerRadius = corner
        layer.masksToBounds = true
    }

    func roundLeft() {
        let mask = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: bounds.height / 2, height: bounds.height / 2))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = mask.cgPath
        layer.mask = maskLayer
    }

    func roundTop(corner: CGFloat = 0.0) {
        let rightCornet = corner != 0.0 ? corner : bounds.height / 2
        let mask = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: rightCornet, height: rightCornet))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = mask.cgPath
        layer.mask = maskLayer
    }

    func roundTop(corner: CGFloat = 0.0, borderColor: UIColor, borderWidth: CGFloat) {
        let rightCornet = corner != 0.0 ? corner : bounds.height / 2
        let mask = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: rightCornet, height: rightCornet))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = mask.cgPath
        layer.mask = maskLayer

        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }

    func roundBottom(corner: CGFloat = 0.0) {
        let rightCornet = corner != 0.0 ? corner : bounds.height / 2
        let mask = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: rightCornet, height: rightCornet))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = mask.cgPath
        layer.mask = maskLayer
    }

    func roundBottom(corner: CGFloat = 0.0, borderColor: UIColor, borderWidth: CGFloat) {
        let rightCornet = corner != 0.0 ? corner : bounds.height / 2
        let mask = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.bottomRight, .bottomLeft],
                                cornerRadii: CGSize(width: rightCornet, height: rightCornet))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = mask.cgPath
        layer.mask = maskLayer

        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }

    func roundRight() {
        let mask = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topRight, .bottomRight],
                                cornerRadii: CGSize(width: bounds.height / 2, height: bounds.height / 2))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = mask.cgPath
        layer.mask = maskLayer
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func removeCorner() {
        layer.cornerRadius = 0.0
        roundCorners([], radius: 0.0)
    }

    func borderCustomMask(borderColor: UIColor, borderWidth: CGFloat) {
        guard let mask = layer.mask as? CAShapeLayer else { return }
        for sublayer in layer.sublayers! {
            if sublayer.value(forKey: "borderLayer") != nil {
                sublayer.removeFromSuperlayer()
            }
        }
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        borderLayer.setValue(true, forKey: "borderLayer")
        layer.addSublayer(borderLayer)
    }

    func roundedTopEdge(desiredCurve: CGFloat? = nil) {
        let bounds = CGRect(origin: .zero, size: CGSize(width: self.bounds.width, height: UIScreen.main.bounds.height))
        let rectBounds = CGRect(x: bounds.origin.x, y: bounds.origin.y + bounds.size.height / 2, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath = UIBezierPath(rect: rectBounds)
        let ovalBounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
        let ovalPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        self.layer.mask = maskLayer
    }

    func mask(withRect rect: CGRect, inverse: Bool = false) {
        let path = UIBezierPath(rect: rect)
        let maskLayer = CAShapeLayer()

        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
            path.usesEvenOddFillRule = true
        }

        maskLayer.path = path.cgPath

        self.layer.mask = maskLayer
    }

    func mask(withPath path: UIBezierPath, inverse: Bool = false) {
        let path = path
        let maskLayer = CAShapeLayer()

        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        }

        maskLayer.path = path.cgPath

        self.layer.mask = maskLayer
    }
}

extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }

    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}
