import Foundation
import UIKit

protocol EmployeesDisplay: AnyObject {
    func startLoading()
    func stopLoading()
    func displayEmployeeSummaries(_ summaries: [EmployeeSummary])
    func displayError()
}

final class EmployeesViewController: UIViewController {
    private let interactor: EmployeesInteracting
    private var employeeSummaries = [EmployeeSummary]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EmployeeSummaryCell.self, forCellReuseIdentifier: EmployeeSummaryCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
        tableView.backgroundColor = .gray
        return tableView
    }()
    
    init(interactor: EmployeesInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViewHierarchy()
        setUpConstraints()
        
        interactor.loadEmployees()
    }
    
    private func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension EmployeesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employeeSummaries.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeSummaryCell.identifier),
              let summaryCell = cell as? EmployeeSummaryCell
        else {
            return UITableViewCell()
        }
        summaryCell.configure(employeeSummaries[indexPath.row])
        return summaryCell
    }
}

extension EmployeesViewController: EmployeesDisplay {
    func startLoading() {
        
    }
    
    func stopLoading() {
        
    }
    
    func displayEmployeeSummaries(_ summaries: [EmployeeSummary]) {
        employeeSummaries = summaries
        tableView.reloadData()
    }
    
    func displayError() {
        
    }
}

//final class TableViewDataSource<T: UITableViewCell>: NSObject, UITableViewDataSource {
//    var data = [T]()
//
//

//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}
