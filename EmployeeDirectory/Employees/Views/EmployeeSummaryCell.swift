import Foundation
import UIKit

final class EmployeeSummaryCell: UITableViewCell {
    private let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let teamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let nameTeamStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildHierarchy()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildHierarchy() {
        nameTeamStackView.addArrangedSubview(nameLabel)
        nameTeamStackView.addArrangedSubview(teamLabel)
        
        contentStackView.addArrangedSubview(photoView)
        contentStackView.addArrangedSubview(nameTeamStackView)
        
        contentView.addSubview(contentStackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            photoView.widthAnchor.constraint(equalToConstant: 58),
            photoView.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    func configure(_ employeeSummary: EmployeeSummary) {
        // sdwebimage
        //photoView.image =
        nameLabel.text = employeeSummary.name
        teamLabel.text = employeeSummary.team
    }
}
