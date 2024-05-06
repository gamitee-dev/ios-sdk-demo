//
//  CardView.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 17/12/2023.
//  Copyright © 2023 co.joyned. All rights reserved.
//
import Foundation
import UIKit
///
///
///
//@IBDesignable
public final class CardView : UIView
{
    // MARK: - Type
    private struct Keys
    {
        // MARK: - content
        static let isContentEnabled = "card_view_contentEnabled"
        static let contentColor     = "card_view_contentColor"
        // MARK: - border
        static let isBorderEnabled  = "card_view_borderEnabled"
        static let borderRadius     = "card_view_borderRadius"
        static let borderWidth      = "card_view_borderWidth"
        static let borderColor      = "card_view_borderColor"
        // MARK: - shadow
        static let isShadowEnabled  = "card_view_shadowEnabled"
        static let shadowRadius     = "card_view_shadowRadius"
        static let shadowOpacity    = "card_view_shadowOpacity"
        static let shadowOffset     = "card_view_shadowOffset"
        static let shadowColor      = "card_view_shadowColor"
        // MARK: - corners
        static let clipedCorners    = "card_view_clipedCorners"
        private init() {}
    }
    
    // MARK: - Properties
    public override var frame: CGRect
    {
        didSet {
            refreshLayerLocations()
        }
    }
    // MARK: - Properties - @IBOutlet
    @IBOutlet internal var contentView : UIView! {
        didSet { refreshLayerLocations() }
    }
    // MARK: - @IBInspectable - content
    @IBInspectable internal var contentColorEnabled : Bool    = false
    @IBInspectable internal var contentColor        : UIColor = UIColor.clear
    
    // MARK: - @IBInspectable - border
    @IBInspectable internal var isBorderEnabled : Bool      = false
    @IBInspectable internal var borderRadius    : CGFloat   = CGFloat.zero
    @IBInspectable internal var borderWidth     : CGFloat   = CGFloat.zero
    @IBInspectable internal var borderColor     : UIColor   = UIColor.clear
    
    // MARK: - @IBInspectable - shadow
    @IBInspectable internal var isShadowEnabled : Bool      = false
    @IBInspectable internal var shadowRadius    : CGFloat   = CGFloat.zero
    @IBInspectable internal var shadowOpacity   : Float     = Float.zero
    @IBInspectable internal var shadowOffset    : CGSize    = CGSize.zero
    @IBInspectable internal var shadowColor     : UIColor   = UIColor.clear
    
    // MARK: - Properties - fileprivate
    fileprivate var isFromCoder           : Bool
    fileprivate var backgroundColorBackup : UIColor?
    fileprivate var clipedCorners         : UIRectCorner
    
    // MARK: - Properties - private
    private var       contourLayer : CAShapeLayer
    private var outlineborderLayer : CAShapeLayer
    private var  inlineBorderLayer : CAShapeLayer
    
    private var outlineShadowLayer : CAShapeLayer
    private var  inlineShadowLayer : CAShapeLayer
    
    // MARK: - Initialization
    override init(frame: CGRect)
{
    self.backgroundColorBackup = nil
    self.clipedCorners  = []
    self.isFromCoder    = false
    self.contourLayer       = CAShapeLayer()
    self.outlineborderLayer = CAShapeLayer()
    self.inlineBorderLayer  = CAShapeLayer()
    self.outlineShadowLayer = CAShapeLayer()
    self.inlineShadowLayer  = CAShapeLayer()
    
    super.init(frame: frame)
    self.prepareView()
}
    
    deinit
    {
        // debugPrint("\(type(of: self)) was deallocated")
    }
    
    // MARK: - NSCoding
    public required init?(coder aDecoder: NSCoder)
    {
        self.backgroundColorBackup = nil
        self.clipedCorners  = []
        self.isFromCoder    = false
        self.contourLayer       = CAShapeLayer()
        self.outlineborderLayer = CAShapeLayer()
        self.inlineBorderLayer  = CAShapeLayer()
        self.outlineShadowLayer = CAShapeLayer()
        self.inlineShadowLayer  = CAShapeLayer()
        
        super.init(coder: aDecoder)
        
        // // MARK: - @IBInspectable - content
        // self.contentColorEnabled = aDecoder.decodeBool(forKey: Keys.isContentEnabled)
        // self.contentColor        = aDecoder.decodeObject(forKey: Keys.contentColor) as? UIColor ?? UIColor.clear
        //
        // // MARK: - @IBInspectable - border
        // self.isBorderEnabled = aDecoder.decodeBool(forKey: Keys.isBorderEnabled)
        // self.borderRadius    = CGFloat(aDecoder.decodeDouble(forKey: Keys.borderRadius))
        // self.borderWidth     = CGFloat(aDecoder.decodeDouble(forKey: Keys.borderWidth))
        // self.borderColor     = aDecoder.decodeObject(forKey: Keys.borderColor) as? UIColor ?? UIColor.clear
        //
        // // MARK: - @IBInspectable - shadow
        // self.isShadowEnabled = aDecoder.decodeBool(forKey: Keys.isShadowEnabled)
        // self.shadowRadius    = CGFloat(aDecoder.decodeDouble(forKey: Keys.shadowRadius))
        // self.shadowOpacity   = aDecoder.decodeFloat (forKey: Keys.shadowOpacity)
        // self.shadowOffset    = aDecoder.decodeCGSize(forKey: Keys.shadowOffset)
        // self.shadowColor     = aDecoder.decodeObject(forKey: Keys.shadowColor) as? UIColor ?? UIColor.clear
        //
        // // MARK: - Properties - fileprivate
        // self.clipedCorners   = aDecoder.decodeUIRectCorner(forKey: Keys.clipedCorners)
    }
    
    public override func encode(with coder: NSCoder)
    {
        // // MARK: - @IBInspectable - content
        // coder.encode(contentColorEnabled, forKey: Keys.isContentEnabled)
        // coder.encode(contentColor       , forKey: Keys.contentColor)
        //
        // // MARK: - @IBInspectable - border
        // coder.encode(isBorderEnabled, forKey: Keys.isBorderEnabled)
        // coder.encode(borderRadius   , forKey: Keys.borderRadius   )
        // coder.encode(borderWidth    , forKey: Keys.borderWidth    )
        // coder.encode(borderColor    , forKey: Keys.borderColor    )
        //
        // // MARK: - @IBInspectable - shadow
        // coder.encode(isShadowEnabled, forKey: Keys.isShadowEnabled)
        // coder.encode(shadowRadius   , forKey: Keys.shadowRadius   )
        // coder.encode(shadowOpacity  , forKey: Keys.shadowOpacity  )
        // coder.encode(shadowOffset   , forKey: Keys.shadowOffset   )
        // coder.encode(shadowColor    , forKey: Keys.shadowColor    )
        //
        // // MARK: - Properties - fileprivate
        // coder.encodeUIRectCorner(clipedCorners, forKey: Keys.clipedCorners)
        
        super.encode(with: coder)
    }
    
    public override func awakeFromNib()
    {
        super.awakeFromNib()
        prepareView()
    }
    
    public override func layoutSubviews()
    {
        super.layoutSubviews()
        refreshLayerLocations()
    }
    
    public override func prepareForInterfaceBuilder()
    {
        super.prepareForInterfaceBuilder()
        refreshLayerLocations()
    }
}
// MARK: - @IBInspectable - computed properties
extension CardView
{
    @IBInspectable internal var shouldClipTopLeft    : Bool
    {
        get { clipedCorners.contains(.topLeft) }
        set { setOrRemove(newValue, cliped: .topLeft) }
    }
    @IBInspectable internal var shouldClipTopRight   : Bool
    {
        get { clipedCorners.contains(.topRight) }
        set { setOrRemove(newValue, cliped: .topRight) }
    }
    @IBInspectable internal var shouldClipBottomLeft : Bool
    {
        get { clipedCorners.contains(.bottomLeft) }
        set { setOrRemove(newValue, cliped: .bottomLeft) }
    }
    @IBInspectable internal var shouldClipBottomRight: Bool
    {
        get { clipedCorners.contains(.bottomRight) }
        set { setOrRemove(newValue, cliped: .bottomRight) }
    }
    
    private func setOrRemove(_ action: Bool, cliped corner: UIRectCorner)
    {
        if action {
            clipedCorners.insert(corner)
        } else {
            clipedCorners.remove(corner)
        }
        refreshLayerLocations()
    }
}
fileprivate extension CardView
{
    // MARK: - typealias
    private typealias CornerRadiiDetails = (original: CGSize, inline: CGSize, outline: CGSize)
    
    // MARK: - functions
    func refreshLayerLocations()
    {
        applyContentConstraints()
        applyDisplayLocations()
    }
    
    // MARK: - functions - private
    private func prepareView()
    {
        self.clipsToBounds       = false
        self.layer.masksToBounds = false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColorBackup = backgroundColor
        backgroundColor = .clear
        [contourLayer,
         outlineborderLayer,inlineBorderLayer,
         outlineShadowLayer,inlineShadowLayer
        ].forEach {
            $0.lineCap     = .round
            $0.cornerCurve = .continuous
            $0.shouldRasterize = true
        }
        layer.insertSublayer(contourLayer, at: 0)
        layer.insertSublayer(outlineShadowLayer, at: 1)
    }
    
    private func applyContentConstraints()
    {
        guard let content = contentView , !subviews.contains(content) else { return }
        content.translatesAutoresizingMaskIntoConstraints = false
        addSubview(content)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: content, attribute: .top      , relatedBy: .equal, toItem: self, attribute: .top     , multiplier: 1.0, constant: isBorderEnabled ?  borderWidth : 0.0),
            NSLayoutConstraint(item: content, attribute: .leading  , relatedBy: .equal, toItem: self, attribute: .leading , multiplier: 1.0, constant: isBorderEnabled ?  borderWidth : 0.0),
            
            NSLayoutConstraint(item: content, attribute: .bottom   , relatedBy: .equal, toItem: self, attribute: .bottom  , multiplier: 1.0, constant: isBorderEnabled ? -borderWidth : 0.0),
            NSLayoutConstraint(item: content, attribute: .trailing , relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: isBorderEnabled ? -borderWidth : 0.0)
        ])
    }
    
    private func applyDisplayLocations()
    {
        guard let containingWindow = window ?? UIApplication.shared.v_keyWindow else { return }
        
        let initialRect = bounds
        let cornerRadii = computeCornerRadiiDetails(
            given       : isBorderEnabled ? borderRadius : 0.0,
            borderWidth : isBorderEnabled ? borderWidth  : 0.0
        )
        
        // setup irregular shape
        let contourOutlinePath = UIBezierPath(
            roundedRect: initialRect,
            byRoundingCorners: clipedCorners,
            cornerRadii: cornerRadii.outline
        )
        
        let finalContentColor = contentColorEnabled ? contentColor : backgroundColorBackup ?? .clear
        
        contourLayer.frame     = initialRect
        contourLayer.path      = contourOutlinePath.cgPath
        contourLayer.fillColor = finalContentColor.cgColor
        
        applyBorderDisplayElement(initialRect: initialRect, cornerRadii: cornerRadii)
        applyShadowDisplayElement(with: contourOutlinePath, withinContaining: containingWindow)
    }
    
    private func applyBorderDisplayElement(initialRect: CGRect, cornerRadii: CornerRadiiDetails)
    {
        // Border
        guard isBorderEnabled else { return }
        
        // We use double ammount for the border width, as half of it is outside of the layer
        contourLayer.lineWidth   = borderWidth * 2
        contourLayer.strokeColor = borderColor.cgColor
        contourLayer.mask        = outlineborderLayer
        
        let borderOutlinePath = UIBezierPath(
            roundedRect: initialRect,
            byRoundingCorners: clipedCorners,
            cornerRadii: cornerRadii.original
        )
        
        // Clip the Border
        outlineborderLayer.path  = borderOutlinePath.cgPath
        outlineborderLayer.frame = contourLayer.frame
        
        // Content clip
        if let content = contentView
        {
            let contentRect = content.bounds
            let contentInlinePath = UIBezierPath(
                roundedRect: contentRect,
                byRoundingCorners: clipedCorners,
                cornerRadii: cornerRadii.inline
            )
            
            inlineBorderLayer.path  = contentInlinePath.cgPath
            inlineBorderLayer.frame = content.layer.bounds
            content.layer.mask  = inlineBorderLayer
        }
    }
    
    private func applyShadowDisplayElement(with outlineContour : UIBezierPath, withinContaining window: UIWindow)
    {
        guard isShadowEnabled else { return }
        
        outlineShadowLayer.shadowRadius  = shadowRadius
        outlineShadowLayer.shadowOpacity = shadowOpacity
        outlineShadowLayer.shadowOffset  = shadowOffset
        outlineShadowLayer.shadowColor   = shadowColor.cgColor
        outlineShadowLayer.shadowPath    = outlineContour.cgPath

        let inlinePath = CGMutablePath()
        inlinePath.addRect(window.convert(UIScreen.main.bounds, to: self))
        inlinePath.addPath(outlineContour.cgPath)
        
        inlineShadowLayer.path     = inlinePath
        inlineShadowLayer.fillRule = .evenOdd
        outlineShadowLayer.mask    = inlineShadowLayer
    }
    
    private func computeCornerRadiiDetails(
        given cornerRadius: CGFloat,
        borderWidth: CGFloat
    ) -> CornerRadiiDetails {
        
        let originalCornerRadii = CGSize(
            width : cornerRadius,
            height: cornerRadius
        )
        
        let  outlineCornerRadii = CGSize(
            width : originalCornerRadii.width  + borderWidth * 0.5,
            height: originalCornerRadii.height + borderWidth * 0.5
        )
        
        let   inlineCornerRadii = CGSize(
            width : max(originalCornerRadii.width  - borderWidth * 0.5, 0),
            height: max(originalCornerRadii.height - borderWidth * 0.5, 0)
        )
        
        return (original: originalCornerRadii, inline: inlineCornerRadii, outline: outlineCornerRadii)
    }
}
