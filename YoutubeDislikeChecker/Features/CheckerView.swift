//
//  CheckerView.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 24/2/2025.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CheckerView: UIView {
    private let viewModel: CheckerViewModel
    private let textField = BorderTextField(id: UI.textField.id, hint: "Enter URL", fontTuple: (18, .regular))
    private let checkButton = UIButton.filled(id: UI.checkButton.id, text: "CHECK", fontTuple: (18, .semibold), textColor: .white, bgColor: .systemRed)
    private let resultView = ResultView()
    private let errorView = ErrorView()
    private let progressView = UIActivityIndicatorView.make(style: .large, color: .systemRed)
    private let disposeBag = DisposeBag()
    
    let closeButton = UIButton.filled(id: UI.closeButton.id, text: "close", fontTuple: (18, .semibold), textColor: .white, bgColor: .systemBlue)
    var onClose: (() -> Void)? = nil
    
    init(with viewModel: CheckerViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setUI()
        setLayout()
        setBinding()
    }
    
    private func setUI() {
        backgroundColor = .systemBackground
        closeButton.isHidden = true
    }
    
    private func setLayout() {
        addSubview(textField)
        addSubview(checkButton)
        addSubview(errorView)
        addSubview(resultView)
        addSubview(closeButton)
        addSubview(progressView)
        
        textField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(36)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        checkButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        errorView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(checkButton.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        resultView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(checkButton.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        closeButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        closeButton.rx.tap
            .throttle(.seconds(5), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self else { return }
                self.onClose?()
            })
            .disposed(by: disposeBag)
        
        progressView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setBinding() {
        checkButton.rx.tap
            .throttle(.seconds(5), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self else { return }
                self.getStats(with: textField.text ?? "")
            })
            .disposed(by: disposeBag)
        
        viewModel.videoStatsObservable
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }
                self.progressView.stop()
                switch result {
                case .success(let stats):
                    self.showStats(stats)
                case .failure(let error):
                    self.showError(error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func getStats(with URL: String) {
        progressView.start()
        self.viewModel.getVideoStats(with: URL)
        
    }
    
    private func showStats(_ stats: VideoStatsModel) {
        DispatchQueue.main.async {
            self.errorView.setText(message: nil)
            self.resultView.setText(stats)
        }
    }
    
    private func showError(_ error: Error) {
        DispatchQueue.main.async {
            self.resultView.setText(nil)
            self.errorView.setText(message: error.localizedDescription)
        }
    }
    
    func setURL(_ url: String) {
        DispatchQueue.main.async {
            self.textField.text = url
        }
        self.getStats(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Accessibility Identifier
extension CheckerView {
    private enum UI: String {
        case textField   = "CheckerView_TextField"
        case checkButton = "CheckerView_CheckButton"
        case closeButton = "CheckerView_CloseButton"
        
        var id: String {
            return rawValue
        }
    }
}
