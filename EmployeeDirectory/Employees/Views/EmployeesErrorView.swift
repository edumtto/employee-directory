import Foundation
import UIKit

final class EmployeesErrorView: UIView {
    private let ilustrationView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "warning.png"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        buildHierarchy()
        setUpContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildHierarchy() {
        stackView.addArrangedSubview(ilustrationView)
        stackView.addArrangedSubview(messageLabel)
        addSubview(stackView)
    }
    
    private func setUpContraints() {
        NSLayoutConstraint.activate([
            ilustrationView.heightAnchor.constraint(equalToConstant: 72),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func configure(message: String) {
        messageLabel.text = message
    }
}
