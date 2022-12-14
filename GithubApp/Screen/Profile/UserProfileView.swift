//
//  UserProfileView.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/13.
//

import UIKit

import RxSwift

private enum Size {
    static let userProfileHorizontalPadding = 30.0
    static let horizontalPadding = 20.0
    static let profileImageSize = 86.0
}

final class UserProfileView: UIView {
    
    // MARK: - UI Properties
    
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
    
    // MARK: - Init
    
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
            make.size.equalTo(Size.profileImageSize)
            make.trailing.equalToSuperview().inset(Size.userProfileHorizontalPadding)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func

    public func config(imageURL: String, name: String) {
        GithubManager.shared.getProfileImage(from: imageURL)
            .observe(on: MainScheduler.instance)
            .subscribe({ result in
                switch result {
                case let .next(image):
                    self.profileImage.image = image

                case let .error(err):
                    print(err.localizedDescription)

                case .completed:
                    break
                }
            }).disposed(by: GithubManager.shared.disposeBag)
        
        userNameLabel.text = name
    }
}
