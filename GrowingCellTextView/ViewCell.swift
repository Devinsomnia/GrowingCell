//
//  ViewCell.swift
//  GrowingCellTextView
//
//  Created by Tundzhay Dzhansaz on 22.02.2020.
//  Copyright © 2020 SwiftDevCenter. All rights reserved.
//

import UIKit

protocol ViewCellProtocol: class {
    func updateHeightOfRow(_ cell: ViewCell, _ textView: UITextView)
}

class ViewCell: UITableViewCell {
  
  weak var cellDelegate: ViewCellProtocol?

  let cellView: UIView = {
     let view = UIView()
      view.backgroundColor = .systemRed
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
  }()

  
  let textView: UITextView = {
    let textView = UITextView()
    textView.text = "Lorem ipsum dolor sit er elit lamet"
    textView.textContainer.lineBreakMode = .byWordWrapping
    textView.textContainer.maximumNumberOfLines = 19
    textView.isScrollEnabled = false
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setup()
    
  }
    
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  func setup() {
    contentView.addSubview(cellView)
    NSLayoutConstraint.activate([cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                 cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                 cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
    
    cellView.addSubview(textView)
    NSLayoutConstraint.activate([textView.topAnchor.constraint(equalTo: cellView.topAnchor),
                                 textView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
                                 textView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
                                 textView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
                                 cellView.bottomAnchor.constraint(equalTo: textView.bottomAnchor),
    ])
  }
}


extension ViewCell: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    if let deletate = cellDelegate {
      deletate.updateHeightOfRow(self, textView)
    }
  }
}
