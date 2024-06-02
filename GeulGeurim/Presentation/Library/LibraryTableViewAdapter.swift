//
//  LibraryTableViewAdapter.swift
//  GeulGeurim
//
//  Created by HUNHEE LEE on 2.06.2024.
//

import UIKit

protocol LibraryTableViewAdapterDelegate: AnyObject {
  func libraryTableView(didUpdateItems itemCount: Int)
  func libraryTableView(didSelectFileItem file: FileItemWrapper)
}

public final class LibraryTableViewAdapter: NSObject {
  typealias DiffableDataSource = UITableViewDiffableDataSource<Int, FileItemWrapper>
  
  private var tableView: UITableView
  private var diffableDataSource: DiffableDataSource?
  weak var delegate: LibraryTableViewAdapterDelegate?
  
  public init(tableView: UITableView) {
    self.tableView = tableView
    super.init()
    tableView.delegate = self
    self.registerCells()
    self.configureDataSource()
  }
  
  private func configureDataSource() {
    diffableDataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier -> UITableViewCell? in
      let cell = self.configureCell(for: tableView, at: indexPath, with: itemIdentifier)
      return cell
    })
  }

  private func registerCells() {
    tableView.register(ContentCell.self, forCellReuseIdentifier: ContentCell.identifier)
    tableView.register(FolderCell.self, forCellReuseIdentifier: FolderCell.identifier)
  }

  private func configureCell(for tableView: UITableView, at indexPath: IndexPath, with itemIdentifier: FileItemWrapper) -> UITableViewCell? {
    switch itemIdentifier.file.type {
    case .content:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentCell.identifier, for: indexPath) as? ContentCell else { return nil }
      cell.configureCell(data: itemIdentifier.file)
      return cell
    case .folder:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: FolderCell.identifier, for: indexPath) as? FolderCell else { return nil }
      cell.configureCell(data: itemIdentifier.file)
      return cell
    }
  }
  
  public func applySnapshot(files: [FileItemWrapper], animated: Bool = true) {
    var snapshot = NSDiffableDataSourceSnapshot<Int, FileItemWrapper>()
    snapshot.appendSections([0])
    snapshot.appendItems(files, toSection: 0)
    diffableDataSource?.apply(snapshot, animatingDifferences: animated)
    delegate?.libraryTableView(didUpdateItems: snapshot.numberOfItems)
  }
}

extension LibraryTableViewAdapter: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let file = diffableDataSource?.itemIdentifier(for: indexPath) else { return }
    delegate?.libraryTableView(didSelectFileItem: file)
  }
}

