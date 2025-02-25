//
//  CheckerViewController.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 24/2/2025.
//

import UIKit

class CheckerViewController: UIViewController {
    private let viewModel = CheckerViewModel()
    private lazy var checkerView = CheckerView(with: viewModel)

    override func viewDidLoad() {
        super.viewDidLoad()
        view = checkerView
    }
}

