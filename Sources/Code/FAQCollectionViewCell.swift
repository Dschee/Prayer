//
//  FAQCollectionViewCell.swift
//  Prayer
//
//  Created by Cihat Gündüz on 19.02.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

class FAQCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
}


extension String {
    /// - Returns: A hyphenated NSAttributedString with justified alignment and word wrapping line break mode.
    public func hyphenated() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.hyphenationFactor = 1.0
        paragraphStyle.alignment = .justified
        paragraphStyle.lineBreakMode = .byWordWrapping

        return NSAttributedString(string: self, attributes: [NSParagraphStyleAttributeName: paragraphStyle])
    }
}

extension NSAttributedString {
    /// Calculates and returns the height needed to fit the text into a width-constrained rect.
    ///
    /// - Parameters:
    ///   - fixedWidth: The fixed width of the rect.
    ///   - font: The font of the text to calculate for.
    /// - Returns: The height needed to fit the text into a width-constrained rect.
    public func height(forFixedWidth fixedWidth: CGFloat, font: UIFont) -> CGFloat {
        let constraintSize = CGSize(width: fixedWidth, height: .greatestFiniteMagnitude)
        return rect(for: constraintSize, font: font).height
    }

    /// Calculates and returns the width needed to fit the text into a height-constrained rect.
    ///
    /// - Parameters:
    ///   - fixedHeight: The fixed height of the rect.
    ///   - font: The font of the text to calculate for.
    /// - Returns: The width needed to fit the text into a height-constrained rect.
    public func width(forFixedHeight fixedHeight: CGFloat, font: UIFont) -> CGFloat {
        let constraintSize = CGSize(width: .greatestFiniteMagnitude, height: fixedHeight)
        return rect(for: constraintSize, font: font).width
    }

    private func rect(for constraintSize: CGSize, font: UIFont) -> CGRect {
        let copy = mutableCopy() as! NSMutableAttributedString
        copy.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, length))
        return copy.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, context: nil)
    }
}
