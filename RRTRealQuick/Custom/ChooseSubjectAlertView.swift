//
//  ChooseSubjectAlertView.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-25.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import UIKit

enum SubjectPageType {
    case books
    case subjects
}

class ChooseSubjectAlertView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    var pageType: SubjectPageType = .books
    var bookType: BookType?
    
    var onTapSubject: ((Subject, BookType) -> Void)?
    var onTapBook: ((BookType) -> Void)?
    
    //MARK: - Init
    override init(frame: CGRect) {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    convenience init(pageType: SubjectPageType, bookType: BookType? = nil) {
        self.init()
        
        self.bookType = bookType
        self.pageType = pageType
        reloadView()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("ChooseSubjectAlertView", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(content)
        
        addTapToRemoveFromView()
    }
    
    func reloadView() {
        stackView.arrangedSubviews.forEach { arrangedView in
            stackView.removeArrangedSubview(arrangedView)
        }
        
        if pageType == .books {
            BookType.allCases.forEach { book in
                let button = AMButton(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 44))
                button.setTitle(book.rawValue, for: .normal)
                button.backgroundColor = .red
                button.identifier = book.rawValue
                button.addTarget(self, action: #selector(didTapBookButton(_:)), for: .touchUpInside)
                stackView.addArrangedSubview(button)
            }
        } else {
            guard let bookType = bookType else { return }
            switch bookType {
            case .clusterOneAndTwo:
                if bookType == .clusterOneAndTwo {
                    Subject.allCases.forEach({ (subject) in
                        guard subject.rawValue.contains("Bushong") || subject.rawValue.contains("Glossary") || subject.rawValue.contains("All") else { return }
                        let button = AMButton(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 44))
                        button.setTitle(subject.rawValue, for: .normal)
                        button.backgroundColor = .red
                        button.identifier = subject.rawValue
                        button.addTarget(self, action: #selector(didTapSubjectButton(_:)), for: .touchUpInside)
                        stackView.addArrangedSubview(button)
                    })
                }
            case .radBiology:
                Subject.allCases.forEach({ (subject) in
                    guard subject.rawValue.contains("RadBiology") || subject.rawValue.contains("All") else { return }
                    
                    let button = AMButton(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 44))
                    button.setTitle(subject.rawValue, for: .normal)
                    button.backgroundColor = .red
                    button.identifier = subject.rawValue
                    button.addTarget(self, action: #selector(didTapSubjectButton(_:)), for: .touchUpInside)
                    stackView.addArrangedSubview(button)
                })
            }
            
        }
    }
    
    @objc func didTapBookButton(_ sender: AMButton) {
        removeFromSuperview()
        guard let book = BookType(rawValue: sender.identifier ?? "") else { return }
        onTapBook?(book)
        
    }
    
    @objc func didTapSubjectButton(_ sender: AMButton) {
        
        guard let subject = Subject(rawValue: sender.identifier ?? ""), let bookType = bookType else { return }
        onTapSubject?(subject, bookType)
        removeFromSuperview()
    }
}
