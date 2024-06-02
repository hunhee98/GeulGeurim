//
//  FolderCell.swift
//  GeulGeurim
//
//  Created by HUNHEE LEE on 2.06.2024.
//

import UIKit
import SnapKit

public final class FolderCell: UITableViewCell {
  private let iconView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "folder.fill")
    imageView.tintColor = UIColor.secondary
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = Font.T4_Regular
    label.textColor = UIColor.black
    return label
  }()
  
  private let createdDateLabel: UILabel = {
    let label = UILabel()
    label.font = Font.B1_Regular
    label.textColor = UIColor.gray500
    return label
  }()
  
  private let fileCountLabel: UILabel = {
    let label = UILabel()
    label.font = Font.B1_Regular
    label.textColor = UIColor.gray500
    return label
  }()
  
  private let dividerLineView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.gray200
    return view
  }()
  
  public override func prepareForReuse() {
    titleLabel.text = nil
    createdDateLabel.text = nil
    fileCountLabel.text = nil
  }

  public func configureCell(data: any FileItemProtocol) {
    selectionStyle = .none
    setupUIWithData(data: data)
    setupConstraints()
  }
  
  private func setupConstraints() {
    contentView.addSubview(iconView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(createdDateLabel)
    contentView.addSubview(fileCountLabel)
    contentView.addSubview(dividerLineView)
    
    iconView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(23)
      $0.size.equalTo(24)
      $0.centerY.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints {
      $0.leading.equalTo(iconView.snp.trailing).offset(21)
      $0.top.equalToSuperview().offset(17)
      $0.trailing.lessThanOrEqualToSuperview().offset(-45)
    }
    
    createdDateLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(5)
      $0.leading.equalTo(titleLabel)
    }
    
    fileCountLabel.snp.makeConstraints {
      $0.top.equalTo(createdDateLabel)
      $0.leading.equalTo(createdDateLabel.snp.trailing).offset(8)
    }
    
    dividerLineView.snp.makeConstraints {
      $0.bottom.equalToSuperview()
      $0.horizontalEdges.equalToSuperview().inset(20)
      $0.height.equalTo(1)
    }
  }
  
  private func setupUIWithData(data: any FileItemProtocol) {
    titleLabel.text = data.name
    createdDateLabel.text = "2024. 05. 28."
    fileCountLabel.text = "파일 1개"
  }
}