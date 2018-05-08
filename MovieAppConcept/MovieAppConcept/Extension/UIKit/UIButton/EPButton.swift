//
//  EPButton.swift
//  EPButton-T
//
//  Created by Evgeniy on 30.03.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public typealias EPButtonBlock = (EPButton) -> Void

open class EPButton: UIButton {

    // MARK: - Interface

    // MARK: - Colors

    @IBInspectable
    open var normalColor: UIColor?

    @IBInspectable
    open var normalTintColor: UIColor? {
        didSet {
            tintColor = normalTintColor
        }
    }

    @IBInspectable
    open var normalTitleColor: UIColor?

    @IBInspectable
    open var highlightColor: UIColor?

    @IBInspectable
    open var highlightTintColor: UIColor?

    @IBInspectable
    open var highlightTitleColor: UIColor?

    // MARK: - Image

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

    // MARK: - Animation

    @IBInspectable
    open var baseAnimationDuration: TimeInterval = 0.25

    @IBInspectable
    open var highlightAnimationDuration: TimeInterval = 0.25

    @IBInspectable
    open var highlightEndedAnimationDuration: TimeInterval = 0.25

    // MARK: - Properties

    @IBInspectable
    open var cornerRadius: CGFloat = 8

    @IBInspectable
    open var isHighlightable: Bool = true {
        didSet {
            adjustsImageWhenHighlighted = isHighlightable
        }
    }

    @IBInspectable
    open var isCheckable: Bool = true

    @IBInspectable
    open var isSelectable: Bool = true

    // TODO: rename to isCheckable or smth

    // MARK: - Methods

    open func makeFlat() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }

    // MARK: - Actions

    var onPrimaryAction: EPButtonBlock?

    var onHighlight: EPButtonBlock?

    var onUnhighlight: EPButtonBlock?

    // MARK: - Overrides

    open override var isHighlighted: Bool {
        didSet {
            setHighlighted(isHighlighted)
        }
    }

    open var isChecked: Bool = false {
        didSet {
            guard isCheckable else { return }
            setChecked(isChecked)
        }
    }

    open override var isSelected: Bool {
        didSet {
            setSelected(isSelected)
        }
    }

    // MARK: - Selected

    private func setChecked(_ checked: Bool) {
        guard isCheckable else { return }

        let animation = checked ? onSelection : onDeselection
        UIView.animate(baseAnimationDuration, animation)
    }

    private func setSelected(_ selected: Bool) {
        let image = selected ? selectedImage : normalImage
        setImage(image, for: .normal)
    }

    private func onSelection() {
        imageView?.image = selectedImage
    }

    private func onDeselection() {
        imageView?.image = normalImage
    }

    // MARK: - Highlight

    private func setHighlighted(_ highlighted: Bool) {
        guard isHighlightable else { return }

        let animation = highlighted ? onHighlightBegan : onHighlightEnded
        let duration = highlighted ? highlightAnimationDuration : highlightEndedAnimationDuration

        UIView.animate(duration, animation)
    }

    private func onHighlightBegan() {
        backgroundColor = highlightColor
        tintColor = highlightTintColor
        setTitleColor(highlightTitleColor, for: .normal)
        onHighlight?(self)
    }

    private func onHighlightEnded() {
        backgroundColor = normalColor
        tintColor = normalTintColor
        setTitleColor(normalTitleColor, for: .normal)
        onUnhighlight?(self)
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
        guard isSelectable else {
            onPrimaryAction?(self)
            return
        }

        isSelected.toggle()
    }
}
