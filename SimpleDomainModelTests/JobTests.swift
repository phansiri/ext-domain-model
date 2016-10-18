//
//  JobTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

import ExtDomainModel

class JobTests: XCTestCase {
  
    // added description test to all testing functions
    
    func testCreateSalaryJob() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)
        XCTAssert(job.description == "Job title: Guest Lecturer that is paid Salary(1000)")
    }
    
    func testCreateHourlyJob() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)
        XCTAssert(job.description == "Job title: Janitor that is paid Hourly(15.0)")

    }
    
    func testSalariedRaise() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)
        XCTAssert(job.description == "Job title: Guest Lecturer that is paid Salary(1000)")

        
        job.raise(1000)
        XCTAssert(job.calculateIncome(50) == 2000)
        XCTAssert(job.description == "Job title: Guest Lecturer that is paid Salary(2000)")

    }
    
    func testHourlyRaise() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)
        XCTAssert(job.description == "Job title: Janitor that is paid Hourly(15.0)")
        
        job.raise(1.0)
        XCTAssert(job.calculateIncome(10) == 160)
        XCTAssert(job.description == "Job title: Janitor that is paid Hourly(16.0)")

    }
    
}
