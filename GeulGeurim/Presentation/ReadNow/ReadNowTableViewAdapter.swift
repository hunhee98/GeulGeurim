//
//  ReadNowTableViewAdapter.swift
//  GeulGeurim
//
//  Created by HUNHEE LEE on 28.05.2024.
//

import UIKit

protocol ReadNowTableViewAdapterDelegate: AnyObject {
  func readNowTableView(didUpdateItems itemCount: Int)
  func readNowTableView(didSelectFileItem file: FileItemWrapper)
}

public final class ReadNowTableViewAdapter: NSObject {
  typealias DiffableDataSource = UITableViewDiffableDataSource<Int, FileItemWrapper>
  
  private var tableView: UITableView
  private var diffableDataSource: DiffableDataSource?
  weak var delegate: ReadNowTableViewAdapterDelegate?
  
  public init(tableView: UITableView) {
    self.tableView = tableView
    super.init()
    tableView.delegate = self
    tableView.register(ContentCell.self, forCellReuseIdentifier: ContentCell.identifier)
    self.configureDataSource()
  }
  
  private func configureDataSource() {
    diffableDataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier -> UITableViewCell? in
      guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentCell.identifier, for: indexPath) as? ContentCell else { return nil }
      cell.configureCell(data: itemIdentifier.file)
      cell.selectionStyle = .none
      return cell
    })
  }
  
  public func applySnapshot(files: [FileItemWrapper], animated: Bool = true) {
    var snapshot = NSDiffableDataSourceSnapshot<Int, FileItemWrapper>()
    snapshot.appendSections([0])
    snapshot.appendItems(files, toSection: 0)
    diffableDataSource?.apply(snapshot, animatingDifferences: animated)
    delegate?.readNowTableView(didUpdateItems: snapshot.numberOfItems)
  }
}

extension ReadNowTableViewAdapter: UITableViewDelegate {  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let file = diffableDataSource?.itemIdentifier(for: indexPath) else { return }
    delegate?.readNowTableView(didSelectFileItem: file)
  }
}