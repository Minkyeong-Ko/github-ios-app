//
//  BaseTableViewCell.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/13.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        
    }
    
    func configUI() {
        
    }
    
}
