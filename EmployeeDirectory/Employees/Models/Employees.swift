import Foundation

struct Employees: Decodable {
    let employees: [Employee]
}

struct Employee: Decodable {
    enum EmploymentType: String, Decodable {
        case fullTime = "FULL_TIME"
        case partTime = "PART_TIME"
        case contractor = "CONTRACTOR"
    }
    
    let uuid: String
    let fullName: String
    let phoneNumber: String
    let emailAddress: String
    let biography: String
    let photoUrlSmall: String
    let photoUrlLarge: String
    let team: String
    let employeeType: EmploymentType
}
