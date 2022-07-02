//
//  HomeViewControllerCell.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/7/1.
//

import UIKit

class HomeViewControllerCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "PingFang TC", size: 17)
        titleLabel.textAlignment = .left
        return titleLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupTitleLabelConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 提供外部呼叫設定抬頭文字
    func myConvert(text: String) {
        titleLabel.text = text
    }
    
    /// 設定抬頭文字位置
    private func setupTitleLabelConstraint() {
        self.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
}
