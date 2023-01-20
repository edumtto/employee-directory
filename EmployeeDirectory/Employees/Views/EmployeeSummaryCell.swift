import Foundation
import UIKit

final class EmployeeSummaryCell: UITableViewCell {
    static let identifier = String(describing: EmployeeSummaryCell.self)
    
    private let photoView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "placeholder.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let teamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let nameTeamStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
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
        contentView.addSubview(contentStackView)
        
        nameTeamStackView.addArrangedSubview(nameLabel)
        nameTeamStackView.addArrangedSubview(teamLabel)
        
        contentStackView.addArrangedSubview(photoView)
        contentStackView.addArrangedSubview(nameTeamStackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            photoView.widthAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    func configure(_ employeeSummary: EmployeeSummary) {
        // sdwebimage
        //photoView.image =
        nameLabel.text = employeeSummary.name
        teamLabel.text = employeeSummary.team
    }
}
