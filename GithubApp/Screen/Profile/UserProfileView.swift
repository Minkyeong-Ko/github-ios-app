//
//  UserProfileView.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/13.
//

import UIKit

private enum Size {
    static let userProfileHorizontalPadding = 30.0
    static let horizontalPadding = 20.0
}

final class UserProfileView: UIView {
    // MARK: - Properties
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        let image = ImageLiteral.userProfileSymbol
        imageView.image = image
        
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "유저 이름"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Size.userProfileHorizontalPadding)
            make.centerY.equalToSuperview()
        }
        
        addSubview(profileImage)
        profileImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(86)
            make.trailing.equalToSuperview().inset(Size.userProfileHorizontalPadding)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func config(image: UIImage, name: String) {
        profileImage.image = image
        userNameLabel.text = name
    }
}
