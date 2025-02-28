//
//  ShareViewController.swift
//  YtDislikeCheckerShareExtension
//
//  Created by Elvis Cheng on 28/2/2025.
//

import UIKit
import Social
import UniformTypeIdentifiers
import RxSwift

class ShareViewController: UIViewController {
    private let viewModel = CheckerViewModel()
    private lazy var checkerView = CheckerView(with: viewModel)
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        // Ensure extensionItem and itemProvider is available
        if let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
           let itemProvider = extensionItem.attachments?.first {
            handleIncomingData(from: itemProvider)
        } else {
            close()
        }
    }
    
    private func setUI() {
        checkerView.closeButton.isHidden = false
        checkerView.onClose = { [weak self] in
            guard let self else { return }
            self.close()
        }
        view = checkerView
    }
    
    private func handleIncomingData(from itemProvider: NSItemProvider) {
        let urlType = UTType.url.identifier as String
        let textType = UTType.text.identifier as String
        
        if itemProvider.hasItemConformingToTypeIdentifier(urlType){
            handleURL(from: itemProvider)
        } else if itemProvider.hasItemConformingToTypeIdentifier(textType) {
            handleText(from: itemProvider)
        } else {
            close()
        }
    }
    
    private func handleURL(from itemProvider: NSItemProvider) {
        let urlType = UTType.url.identifier as String
        itemProvider.loadItem(forTypeIdentifier: urlType, options: nil) { (item, error) in
            if let url = item as? NSURL, let urlString = url.absoluteString, error == nil {
                self.checkerView.setURL(urlString)
            }
        }
    }
    
    private func handleText(from itemProvider: NSItemProvider) {
        let textType = UTType.text.identifier as String
        itemProvider.loadItem(forTypeIdentifier: textType, options: nil) { (item, error) in
            if let text = item as? String, error == nil {
                self.checkerView.setURL(text)
            }
        }
    }
    
    private func close() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
}
