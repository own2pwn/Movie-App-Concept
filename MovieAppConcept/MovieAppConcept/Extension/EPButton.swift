//
//  EPButton.swift
//  EPButton-T
//
//  Created by Evgeniy on 30.03.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

open class EPButton: UIButton {

    // MARK: - Interface

    @IBInspectable
    open var normalColor: UIColor?

    @IBInspectable
    open var normalTintColor: UIColor?

    @IBInspectable
    open var normalTitleColor: UIColor?

    @IBInspectable
    open var highlightColor: UIColor?

    @IBInspectable
    open var highlightTintColor: UIColor?

    @IBInspectable
    open var highlightTitleColor: UIColor?

    @IBInspectable
    open var normalImage: UIImage? {
        didSet {
            setImage(normalImage, for: .normal)
        }
    }

    @IBInspectable
    open var selectedImage: UIImage? {
        didSet {
            setImage(selectedImage, for: .selected)
        }
    }

    @IBInspectable
    open var baseAnimationDuration: TimeInterval = 0.25

    @IBInspectable
    open var highlightAnimationDuration: TimeInterval = 0.25

    @IBInspectable
    open var highlightEndedAnimationDuration: TimeInterval = 0.25

    @IBInspectable
    open var cornerRadius: CGFloat = 8

    // MARK: - Methods

    open func makeFlat() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }

    // MARK: - Overrides

    open override var isHighlighted: Bool {
        didSet {
            setHighlighted(isHighlighted)
        }
    }

    open override var isSelected: Bool {
        didSet {
            setSelected(isSelected)
        }
    }

    // MARK: - Selected

    private func setSelected(_ selected: Bool) {
        let animation = selected ? onSelection : onDeselection
        UIView.animate(baseAnimationDuration, animation)
    }

    private func onSelection() {
        imageView?.image = selectedImage
        setImage(selectedImage, for: .normal)
    }

    private func onDeselection() {
        imageView?.image = normalImage
        setImage(normalImage, for: .normal)
    }

    // MARK: - Highlight

    private func setHighlighted(_ highlighted: Bool) {
        let animation = highlighted ? onHighlightBegan : onHighlightEnded
        let duration = highlighted ? highlightAnimationDuration : highlightEndedAnimationDuration

        UIView.animate(duration, animation)
    }

    private func onHighlightBegan() {
        backgroundColor = highlightColor
        tintColor = highlightTintColor
        setTitleColor(highlightTitleColor, for: .normal)
    }

    private func onHighlightEnded() {
        backgroundColor = normalColor
        tintColor = normalTintColor
        setTitleColor(normalTitleColor, for: .normal)
    }

    // MARK: - Internal

    public override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        internalInit()
    }

    private func internalInit() {
        addTarget(self, action: #selector(observeTouch(_:)), for: .touchUpInside)
    }

    @objc
    private func observeTouch(_ sender: EPButton) {
        isSelected.toggle()
    }
}
