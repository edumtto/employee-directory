import Foundation
import UIKit

extension UIView {
    func contrainAllEdgesToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return }
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant)
        ])
    }
}
