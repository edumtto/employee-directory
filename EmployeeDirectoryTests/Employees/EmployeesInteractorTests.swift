import Foundation
@testable import EmployeeDirectory
import XCTest

private class EmployeesPresenterSpy: EmployeesPresenting {
    var view: EmployeeDirectory.EmployeesDisplay?
    
    private(set) var presentLoadingIndicatorCalls: [Bool] = []
    func presentLoadingIndicator(isRefreshing: Bool) {
        presentLoadingIndicatorCalls.append((isRefreshing))
    }
    
    private(set) var hideLoadingIndicatorCalls: [Bool] = []
    func hideLoadingIndicator(isRefreshing: Bool) {
        hideLoadingIndicatorCalls.append(isRefreshing)
    }
    
    private(set) var presentEmployeesCalls: [[Employee]] = []
    func presentEmployees(_ employees: [Employee]) {
        presentEmployeesCalls.append(employees)
    }
    
    private(set) var presentErrorCount = 0
    func presentError() {
        presentErrorCount += 1
    }
}

private class EmployeesServiceMock: EmployeesServicing {
    var result: Result<Employees, NetworkError>?
    
    func fetchEmployees(completion: @escaping (Result<Employees, NetworkError>) -> Void) {
        guard let result = result else {
            XCTFail("Expected non nil mock result for fetchEmpoyees call")
            return
        }
        completion(result)
    }
}



final class EmployeeInteractorTests: XCTestCase {
    private var service: EmployeesServiceMock!
    private var presenter: EmployeesPresenterSpy!
    private var sut: EmployeesInteracting!
    
    override func setUp() {
        super.setUp()
        service = EmployeesServiceMock()
        presenter = EmployeesPresenterSpy()
        sut = EmployeesInteractor(presenter: presenter, service: service)
    }
    
    override func tearDown() {
        service = nil
        presenter = nil
        sut = nil
    }
    
    func testLoadEmpoyees_whenResponseReturnsEmployeersAndIsNotRefreshing_shouldLoadAndPresentEmployees() {
        service.result = .success(Employees(employees: EmployeesMocks.employees))
        
        sut.loadEmployees(isRefreshing: false)
        
        XCTAssertEqual(presenter.presentLoadingIndicatorCalls, [false])
        XCTAssertEqual(presenter.hideLoadingIndicatorCalls, [false])
        XCTAssertEqual(presenter.presentEmployeesCalls, [EmployeesMocks.employees])
    }
    
    func testLoadEmpoyees_whenResponseReturnsEmployeersAndIsRefreshing_shouldRefreshAndPresentEmployees() {
        service.result = .success(Employees(employees: EmployeesMocks.employees))
        
        sut.loadEmployees(isRefreshing: true)
        
        XCTAssertEqual(presenter.presentLoadingIndicatorCalls, [true])
        XCTAssertEqual(presenter.hideLoadingIndicatorCalls, [true])
        XCTAssertEqual(presenter.presentEmployeesCalls, [EmployeesMocks.employees])
    }
    
    func testLoadEmpoyees_whenResponseReturnsEmptyList_shouldLoadAndPresentEmployees() {
        service.result = .success(Employees(employees: []))
        
        sut.loadEmployees(isRefreshing: false)
        
        XCTAssertEqual(presenter.presentLoadingIndicatorCalls, [false])
        XCTAssertEqual(presenter.hideLoadingIndicatorCalls, [false])
        XCTAssertEqual(presenter.presentEmployeesCalls, [[]])
    }
    
    func testLoadEmpoyees_whenResponseReturnsFailure_shouldLoadAndPresentError() {
        service.result = .failure(.badRequest)
        
        sut.loadEmployees(isRefreshing: false)
        
        XCTAssertEqual(presenter.presentLoadingIndicatorCalls, [false])
        XCTAssertEqual(presenter.hideLoadingIndicatorCalls, [false])
        XCTAssertEqual(presenter.presentErrorCount, 1)
    }
}
