import Foundation
import UIKit

protocol EmployeesDisplay: AnyObject {
    func startLoadingAnimation()
    func stopLoadingAnimation()
    func stopRefreshingAnimation()
    func displayEmployeeSummaries(_ summaries: [EmployeeSummary])
    func displayEmptyState()
    func displayError(message: String)
}

final class EmployeesViewController: UIViewController {
    private let interactor: EmployeesInteracting
    private var employeeSummaries = [EmployeeSummary]()
    
    private var loadingIndicator: UIActivityIndicatorView?
    private var emptyStateView: EmployeesEmptyStateView?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EmployeeSummaryCell.self, forCellReuseIdentifier: EmployeeSummaryCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
        
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.refreshControl = refreshControll
        
        return tableView
    }()
    
    init(interactor: EmployeesInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Employees"
        buildViewHierarchy()
        setUpConstraints()
        
        interactor.loadEmployees(isRefreshing: false)
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
    
    @objc private func refreshTableView() {
        interactor.loadEmployees(isRefreshing: true)
    }
    
    private func addExceptionStateView(_ exceptionView: UIView) {
        let size = CGSize(width: view.frame.width, height: view.frame.height / 1.5)
        exceptionView.frame = CGRect(origin: .zero, size: size)
        tableView.tableHeaderView = exceptionView
    }
    
    private func removeEmptyStateView() {
        tableView.tableHeaderView = nil
        emptyStateView = nil
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
    func startLoadingAnimation() {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        tableView.backgroundView = loadingIndicator
        loadingIndicator.startAnimating()
        
        self.loadingIndicator = loadingIndicator
    }
    
    func stopLoadingAnimation() {
        loadingIndicator?.stopAnimating()
        tableView.backgroundView = nil
        loadingIndicator = nil
    }
    
    func stopRefreshingAnimation() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func displayEmployeeSummaries(_ summaries: [EmployeeSummary]) {
        removeEmptyStateView()
        
        employeeSummaries = summaries
        tableView.reloadData()
    }
    
    func displayEmptyState() {
        let emptyStateView = EmployeesEmptyStateView()
        
        let size = CGSize(width: view.frame.width, height: view.frame.height / 1.5)
        emptyStateView.frame = CGRect(origin: .zero, size: size)
        tableView.tableHeaderView = emptyStateView
        
        self.emptyStateView = emptyStateView
    }
    
    func displayError(message: String) {
        let defaultAction = UIAlertAction(title: "Ok", style: .default)
        let alertController = UIAlertController(title: "Error 🫤", message: message, preferredStyle: .alert)
        alertController.addAction(defaultAction)
        
        // Deadline added to avoid conflicting with refresh control animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.present(alertController, animated: true)
        }
    }
}
