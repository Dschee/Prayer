//
//  PrayerViewController.swift
//  Prayer
//
//  Created by Cihat Gündüz on 17.01.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit
import HandySwift
import SwiftyTimer
import Imperio

class PrayerViewController: BrandedViewController, Coordinatable {
    // MARK: - Coordinatable Protocol Implementation

    typealias Action = PrayerAction
    var coordinate: ((PrayerAction) -> Void)!


    // MARK: - Stored Instance Properties

    var viewModel: PrayerViewModel! {
        didSet {
            title = viewModel.currentComponentName
            updateLineLabels()
            updateArrowLabels()
//            updateSeparators()
            if let movementSoundUrl = viewModel.movementSoundUrl {
                AudioPlayer.shared.playSound(at: movementSoundUrl)
            }
        }
    }


    // MARK: - IBOutlets

    @IBOutlet var previousLineLabel: UILabel!
    @IBOutlet var currentLineLabel: UILabel!
    @IBOutlet var nextLineLabel: UILabel!

    @IBOutlet var previousArrowLabel: UILabel!
    @IBOutlet var currentArrowLabel: UILabel!
    @IBOutlet var nextArrowLabel: UILabel!

    // TODO: make separators work again
//    @IBOutlet var currentLineComponentSeparator: UIView!
//    @IBOutlet var nextLineComponentSeparator: UIView!


    // MARK: - Instance Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        let doneSelector = #selector(doneButtonPressed)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: doneSelector)
        navigationItem.rightBarButtonItem = doneItem
    }

    func doneButtonPressed() { coordinate(.doneButtonPressed) }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        clearLineLabels()
        clearArrowLabels()
//        clearSeparators()
    }

    private func clearLineLabels() {
        // NOTE: a whitespace is added in order to have an intrinsic size for all labels
        previousLineLabel.text = " "
        currentLineLabel.text = " "
        nextLineLabel.text = " "
    }

    private func clearArrowLabels() {
        previousArrowLabel.text = " "
        currentArrowLabel.text = " "
        nextArrowLabel.text = " "
    }

//    private func clearSeparators() {
//        currentLineComponentSeparator.isHidden = true
//        nextLineComponentSeparator.isHidden = true
//    }

    private func updateLineLabels() {
        previousLineLabel.text = viewModel.previousLine ?? " "
        currentLineLabel.text = viewModel.currentLine + " "
        nextLineLabel.text = viewModel.nextLine ?? " "
    }

    private func updateArrowLabels() {
        previousArrowLabel.text = (viewModel.previousArrow?.rawValue ?? "") + " "
        currentArrowLabel.text = (viewModel.currentArrow?.rawValue ?? "") + " "
        nextArrowLabel.text = (viewModel.nextArrow?.rawValue ?? "") + " "
    }

//    private func updateSeparators() {
//        currentLineComponentSeparator.isHidden = !viewModel.currentIsComponentBeginning
//        nextLineComponentSeparator.isHidden = !viewModel.nextIsComponentBeginning
//    }
}
