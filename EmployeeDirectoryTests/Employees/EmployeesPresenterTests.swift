import Foundation
@testable import EmployeeDirectory
import XCTest

private class EmployeesDisplaySpy: EmployeesDisplay {
    private(set) var startLoadingAnimationCount = 0
    func startLoadingAnimation() {
        startLoadingAnimationCount += 1
    }
    
    private(set) var stopLoadingAnimationCount = 0
    func stopLoadingAnimation() {
        stopLoadingAnimationCount += 1
    }
    
    private(set) var stopRefreshingAnimationCount = 0
    func stopRefreshingAnimation() {
        stopRefreshingAnimationCount += 1
    }
    
    private(set) var displayEmployeeSummariesCalls: [[EmployeeSummary]] = []
    func displayEmployeeSummaries(_ summaries: [EmployeeSummary]) {
        displayEmployeeSummariesCalls.append(summaries)
    }
    
    private(set) var displayEmptyStateCount = 0
    func displayEmptyState() {
        displayEmptyStateCount += 1
    }
    
    private(set) var displayErrorCalls: [String] = []
    func displayError(message: String) {
        displayErrorCalls.append(message)
    }
}

final class EmployeePresenterTests: XCTestCase {
    private var view: EmployeesDisplaySpy!
    private var sut: EmployeesPresenting!
    
    override func setUp() {
        super.setUp()
        view = EmployeesDisplaySpy()
        sut = EmployeesPresenter()
        sut.view = view
    }
    
    override func tearDown() {
        view = nil
        sut = nil
    }
    
    func testPresentLoadingIndicator_whenIsRefreshing_shouldNotDisplayLoadingAnimation() {
        sut.presentLoadingIndicator(isRefreshing: true)
        
        XCTAssertEqual(view.startLoadingAnimationCount, 0)
    }
    
    func testPresentLoadingIndicator_whenIsNotRefreshing_shouldDisplayLoadingAnimation() {
        sut.presentLoadingIndicator(isRefreshing: false)
        
        XCTAssertEqual(view.startLoadingAnimationCount, 1)
    }
    
    func testHideLoadingIndicator_whenIsNotRefreshing_shouldStopLoadingAnimation() {
        sut.hideLoadingIndicator(isRefreshing: false)
        
        XCTAssertEqual(view.stopLoadingAnimationCount, 1)
    }
    
    func testHideLoadingIndicator_whenIsRefreshing_shouldStopRefreshingAnimation() {
        sut.hideLoadingIndicator(isRefreshing: true)
        
        XCTAssertEqual(view.stopRefreshingAnimationCount, 1)
    }
    
    func testPresentError_shouldDisplayErrorMessage() {
        let expectedMessage = "Please, check your connection and try again later."
        sut.presentError()
        
        XCTAssertEqual(view.displayErrorCalls, [expectedMessage])
    }
    
    func testPresentLoadingIndicator_whenReceivedEmployeesList_shouldDisplayEmployeeSummaries() {
        sut.presentEmployees(EmployeesMocks.employees)
        
        XCTAssertEqual(view.displayEmployeeSummariesCalls, [EmployeesMocks.employeeSummaries])
    }
    
    func testPresentLoadingIndicator_whenReceivedEmptyList_shouldDisplayEmptyState() {
        sut.presentEmployees([])
        
        XCTAssertEqual(view.displayEmptyStateCount, 1)
    }
}
