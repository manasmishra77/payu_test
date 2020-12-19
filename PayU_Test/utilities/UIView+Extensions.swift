//
//  UIView+Extensions.swift
//  InfluencerMarketing
//
//  Created by Manas Mishra on 26/09/20.
//  Copyright © 2020 Manas Mishra. All rights reserved.
//

import UIKit

// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}
// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

let isIPAD  = (UI_USER_INTERFACE_IDIOM() == .pad)


struct ConstraintsCustom {
    var top: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?
    var leading: NSLayoutConstraint?
    var trailing: NSLayoutConstraint?
    var height: NSLayoutConstraint?
    var width: NSLayoutConstraint?
}

extension UIView {
    
    
    //Add constraints from 4Sides
    func addAsSubViewWithConstraints(_ superview: UIView, top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
        self.frame = superview.bounds
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing).isActive = true
    }
    
    func addFourConstraints(_ superview: UIView, top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing).isActive = true
    }
    //Applwing this will keep the view in the middle of the superview
    func addFourConstraintsAlignMentAndSize(_ superview: UIView, size: CGSize, xAlignment: CGFloat = 0, yAlignment: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: yAlignment).isActive = true
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: xAlignment).isActive = true
        self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }
    //Adding constraint for: Height, Top, Leading, Trailing
    func addAsSubviewWithHeightTopLeadingTrailing(_ superview: UIView, height: CGFloat, top: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
        self.frame = superview.bounds
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    //Adding constraint for: Height, top, Leading, Trailing
    func addAsSubviewWithFourConstraintsWithHeightTopLeadingTrailing(_ superview: UIView, height: CGFloat, top: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) -> ConstraintsCustom {
        self.frame = superview.bounds
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        var customConstraints = ConstraintsCustom()
        customConstraints.top = superview.topAnchor.constraint(equalTo: self.topAnchor, constant: top)
        customConstraints.leading = self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading)
        customConstraints.trailing = superview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailing)
        customConstraints.height = self.heightAnchor.constraint(equalToConstant: height)
        customConstraints.top?.isActive = true
        customConstraints.leading?.isActive = true
        customConstraints.trailing?.isActive = true
        customConstraints.height?.isActive = true
        return customConstraints
    }
    
    //Adding constraint for: Height, Bottom, Leading, Trailing
    func addAsSubviewWithFourConstraintsWithConstantHeight(_ superview: UIView, height: CGFloat, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) -> ConstraintsCustom {
        self.frame = superview.bounds
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        var customConstraints = ConstraintsCustom()
        customConstraints.bottom = superview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom)
        customConstraints.leading = self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading)
        customConstraints.trailing = superview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailing)
        customConstraints.height = self.heightAnchor.constraint(equalToConstant: height)
        customConstraints.bottom?.isActive = true
        customConstraints.leading?.isActive = true
        customConstraints.trailing?.isActive = true
        customConstraints.height?.isActive = true
        return customConstraints
    }
    
}

// Add Gradient
extension UIView {
    // MARK: Apply Gradient
    func applyGradient(initialColor : CGColor, finalColor: CGColor) {
        let initalColor  = initialColor
        let finalColor = finalColor
        
        let colorsArray = [initalColor, finalColor]
        
        let layer = CAGradientLayer()
        layer.colors = colorsArray
        layer.frame = self.bounds
        layer.startPoint = CGPoint(x: 0.0, y: 0.0)
        layer.endPoint = CGPoint(x: 0.0, y: 1.0)
        self.layer.insertSublayer(layer, at: 0)
    }
}

// Rotate indicator by 360 degree

extension UIView {
    func rotateBy360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate as? CAAnimationDelegate
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
    enum ViewShaketype {
        case horizontal
        case vertical
        case both
    }
    // MARK: Shake animation for view element
    func shakingAnimation(duration: Double = 0.001, frequency: Int, deltaLength: CGFloat = 1, shaketype: ViewShaketype) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = Float(frequency)
        animation.autoreverses = true
        switch shaketype {
        case .horizontal:
            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - deltaLength, y: self.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + deltaLength, y: self.center.y))
        case .vertical:
            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y - deltaLength))
            animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y + deltaLength))
        case .both:
            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - deltaLength, y: self.center.y - deltaLength))
            animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + deltaLength, y: self.center.y + deltaLength))
        }
        self.layer.add(animation, forKey: "position")
    }
    
    // MARK: Ripple animation for video player forword backword button
    func rippleEffectOnDoubleTap(location: CGPoint, isForward: Bool) {
        
        // outerFrame-outerView are used for bigger circle
        // innerFrame & innerFrame1 are used to create on tap small ripple views
        
        var yOffsetForOuterFrame = screenWidth/4
        
        if isIPAD && screenWidth > screenHeight {
            yOffsetForOuterFrame = screenHeight/4
        }

        var outerFrame = CGRect()
        if location.x < screenWidth/2 {
            outerFrame = CGRect(origin: CGPoint(x: 0-screenWidth/2, y: self.frame.minY-yOffsetForOuterFrame), size: CGSize(width: screenWidth, height: screenWidth))
        } else {
            
            outerFrame = CGRect(origin: CGPoint(x: screenWidth/2, y: self.frame.minY-yOffsetForOuterFrame), size: CGSize(width: screenWidth, height: screenWidth))
        }
        let outerView = UIView(frame: outerFrame)
        outerView.layer.cornerRadius = screenWidth/2
        outerView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        outerView.clipsToBounds = true
        outerView.tag = 111
        
        let innerframe = CGRect(x: location.x-outerFrame.origin.x, y: location.y-outerFrame.origin.y, width: 30, height: 30)
        let innerframe1 = CGRect(x: location.x-outerFrame.origin.x, y: location.y-outerFrame.origin.y, width: 30, height: 30)
        
        let innerView = UIView(frame: innerframe)
        let innerView1 = UIView(frame: innerframe1)
        innerView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        innerView1.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        innerView.layer.cornerRadius = 15
        innerView1.layer.cornerRadius = 15
        
        if let subView = self.viewWithTag(111) {
            subView.removeFromSuperview()
        } else {
            self.addSubview(outerView)
            outerView.addSubview(innerView)
            outerView.addSubview(innerView1)
            outerView.bringSubviewToFront(innerView)
            outerView.bringSubviewToFront(innerView1)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            outerView.alpha = 0
            innerView1.transform = CGAffineTransform(scaleX: 4, y: 4)
            innerView.transform = CGAffineTransform(scaleX: 6, y: 6)
        }) { (_) in
            innerView.isHidden = true
            outerView.removeFromSuperview()
            innerView1.isHidden = true
            innerView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    // MARK: Ripple animation for view element
    func rippleOnTouchEffect(bgColor: UIColor) {
        let origin = CGPoint(x: (self.frame.width)*3/8, y: 0)
        let frame = CGRect(origin: origin, size: CGSize(width: self.frame.width/4, height: self.frame.height))
        let colorView = UIView(frame: frame)
        colorView.backgroundColor = bgColor
        self.addSubview(colorView)
        UIView.animate(withDuration: 0.2, animations: {
            colorView.transform = CGAffineTransform(scaleX: 4, y: 1)
        }) { (_) in
            colorView.isHidden = true
            colorView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}

extension UIView {

    // there can be other views between `subview` and `self`
    func getConvertedFrame(fromSubview subview: UIView) -> CGRect? {
        // check if `subview` is a subview of self
        guard subview.isDescendant(of: self) else {
            return nil
        }

        var frame = subview.frame
        if subview.superview == nil {
            return frame
        }

        var superview = subview.superview
        while superview != self {
            frame = superview!.convert(frame, to: superview!.superview)
            if superview!.superview == nil {
                break
            } else {
                superview = superview!.superview
            }
        }

        return superview!.convert(frame, to: self)
    }

}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
