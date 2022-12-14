//
//  RepositoryTableViewCell.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/13.
//

import UIKit

private enum Size {
    // view
    static let horizontalPadding = 20.0
    // font
    static let fullNameFontSize = 17.0
    static let descriptionFontSize = 12.0
    static let starNumberFontSize = 12.0
    // star number label
    static let starNumberImageSize = 15.0
    static let starNumberStackViewSpacing = 5.0
    // stackView
    
    static let starButtonWidth = 20.0
    static let stackViewSpacing = 5.0
    static let stackViewLayoutMargins = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
}

final class RepositoryTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    private var isStarFilled: Bool = true
    var repository: Repository?
    
    // MARK: - UI Properties
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Size.fullNameFontSize)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Size.descriptionFontSize)
        label.textColor = UIColor.githubGray
        return label
    }()
    
    private let starNumber: UIStackView = {
        let imageView = UIImageView(image: ImageLiteral.starFill)
        imageView.frame = .init(origin: .zero, size: .init(width: Size.starNumberImageSize, height: Size.starNumberImageSize))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .githubGray
        
        let label = UILabel()
        label.font = .systemFont(ofSize: Size.starNumberFontSize)
        label.textColor = .githubGray
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = Size.starNumberStackViewSpacing
        
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fullNameLabel, descriptionLabel, starNumber])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Size.stackViewSpacing
        stackView.layoutMargins = Size.stackViewLayoutMargins
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    let starButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.starFill, for: .normal)
        button.tintColor = .githubYellow
        return button
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupButton()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func render() {
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().inset(Size.horizontalPadding)
            make.trailing.equalToSuperview().inset(Size.horizontalPadding + Size.starButtonWidth)
        }
        
        contentView.addSubview(starButton)
        starButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(Size.horizontalPadding)
        }
    }
    
    // MARK: - Func
    
    public func configure(repositoryInfo: Repository) {
        fullNameLabel.text = repositoryInfo.fullName
        descriptionLabel.text = repositoryInfo.descriptionField
        let label = starNumber.arrangedSubviews[1] as! UILabel
        label.text = repositoryInfo.stargazersCount
    }
    
    private func setupButton() {
        starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
    }
    
    @objc func starButtonTapped() {
        isStarFilled = !isStarFilled
        toggleStarButtonImage()
        if isStarFilled {
            GithubManager.shared.starRepository(repo: repository?.fullName ?? "")
        } else {
            GithubManager.shared.unstarRepository(repo: repository?.fullName ?? "")
        }
    }
    
    func toggleStarButtonImage() {
        if isStarFilled {
            self.starButton.setImage(ImageLiteral.starFill, for: .normal)
        } else {
            self.starButton.setImage(ImageLiteral.starOutline, for: .normal)
        }
    }
}
