import Foundation
@testable import EmployeeDirectory

enum EmployeesMocks {
    static let employees: [Employee] = [
        Employee(
            uuid: "255346",
            fullName: "James Brown",
            phoneNumber: nil,
            emailAddress: "jb@abc.com",
            biography: nil,
            photoUrlSmall: nil,
            photoUrlLarge: nil,
            team: "Seller",
            employeeType: .fullTime
        ),
        Employee(
            uuid: "6335663",
            fullName: "Eric Clapton",
            phoneNumber: "5556669870",
            emailAddress: "eclapton@music.com",
            biography: "A short biography describing the employee.",
            photoUrlSmall: "https://some.url/path1.jpg",
            photoUrlLarge: "https://some.url/path2.jpg",
            team: "Public Web & Marketing",
            employeeType: .partTime
        ),
        Employee(
            uuid: "657323",
            fullName: "Mariah Carey",
            phoneNumber: "5059433883",
            emailAddress: "mc@voices.com",
            biography: nil,
            photoUrlSmall: nil,
            photoUrlLarge: nil,
            team: "Restaurants",
            employeeType: .contractor
        )
    ]
    
    static let employeeSummaries: [EmployeeSummary] = [
        EmployeeSummary(
            photoURL: nil,
            name: "James Brown",
            team: "Seller"
        ),
        EmployeeSummary(
            photoURL: URL(string: "https://some.url/path1.jpg")!,
            name: "Eric Clapton",
            team: "Public Web & Marketing"
        ),
        EmployeeSummary(
            photoURL: nil,
            name: "Mariah Carey",
            team: "Restaurants"
        )
    ]
}
