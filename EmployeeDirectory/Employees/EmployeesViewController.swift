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
    private var errorView: EmployeesErrorView?
    
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
        tableView.contrainAllEdgesToSuperview()
    }
    
    @objc private func refreshTableView() {
        interactor.loadEmployees(isRefreshing: true)
    }
    
    private func removeExceptionStateViews() {
        errorView?.removeFromSuperview()
        errorView = nil
        
        emptyStateView?.removeFromSuperview()
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
        loadingIndicator?.removeFromSuperview()
        loadingIndicator = nil
    }
    
    func stopRefreshingAnimation() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func displayEmployeeSummaries(_ summaries: [EmployeeSummary]) {
        removeExceptionStateViews()
        
        employeeSummaries = summaries
        tableView.reloadData()
    }
    
    func displayEmptyState() {
        let emptyStateView = EmployeesEmptyStateView()
        
//        view.addSubview(emptyStateView)
        tableView.backgroundView = emptyStateView
        emptyStateView.contrainAllEdgesToSuperview()
        
        self.emptyStateView = emptyStateView
    }
    
    func displayError(message: String) {
        let errorView = EmployeesErrorView()
        errorView.configure(message: message)
        
        view.addSubview(errorView)
        errorView.contrainAllEdgesToSuperview()
        
        self.errorView = errorView
    }
}
