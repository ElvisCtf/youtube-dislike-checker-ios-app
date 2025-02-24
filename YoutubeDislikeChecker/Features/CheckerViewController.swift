//
//  CheckerViewController.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 24/2/2025.
//

import UIKit

class CheckerViewController: UIViewController {
    private lazy var checkerView = CheckerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = checkerView
    }

}

