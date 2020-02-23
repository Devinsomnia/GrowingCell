//
//  ViewController.swift
//  GrowingCellTextView
//
//  Created by SwiftDevCenter on 12/03/19.
//  Copyright © 2019 SwiftDevCenter. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
  
  fileprivate let cellIdentifier = "GrowingCell"
  
  let myCustomCell = ViewCell()

  private var tableView: UITableView = {
    let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
    tableView.backgroundColor = .white
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
    
  override func viewDidLoad() {
    super.viewDidLoad()
      
    setup()
        
    let nib = UINib(nibName: "GrowingCell", bundle: nil)
    self.tableView.register(nib, forCellReuseIdentifier: "GrowingCell")
      
    self.tableView.tableFooterView = UIView()
    self.tableView.dataSource = self
  }
  
  func setup(){
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
    NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                 tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                 tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                  tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
    
    tableView.tableFooterView = UIView()
    tableView.rowHeight = 150

  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    if (indexPath.section == 0) && (indexPath.row == 0) {
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GrowingCell
      cell.cellDelegate = self
      return cell
    }
    
    if (indexPath.section == 0) && (indexPath.row == 1) {
      myCustomCell.cellDelegate = self
      return myCustomCell
    }
    
    return UITableViewCell()
  }
}

//cell protocol with nib
extension ViewController: GrowingCellProtocol {
  func updateHeightOfRow(_ cell: GrowingCell, _ textView: UITextView) {
    let size = textView.bounds.size
    let newSize = tableView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
      if size.height != newSize.height {
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        if let thisIndexPath = tableView.indexPath(for: cell) {
          tableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
        }
      }
  }
}
//cell protol with programmatically
extension ViewController: ViewCellProtocol {
  func updateHeightOfRow(_ cell: ViewCell, _ textView: UITextView) {
    let size = textView.bounds.size
    let newSize = tableView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
      if size.height != newSize.height {
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        if let thisIndexPath = tableView.indexPath(for: cell) {
          tableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
        }
      }
  }
}
