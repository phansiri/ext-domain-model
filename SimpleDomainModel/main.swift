//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

protocol CustomStringConvertible {
    var description: String {
        get
    }
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount : Int
    public var currency : String
    
    var description: String {
        get { return "\(currency)\(amount).0" }
    }
    
    enum Currency: String {
        case USD, EUR, CAN, GBP
    }
    
    private let conversionRate = [
        "usdToGBP": 0.5,
        "usdToEUR": 1.5,
        "usdToCAN": 1.25,
        "canToGBP": 0.61,
        "canToEUR": 0.6667,
        "canToUSD": 0.8,
        "gbpToUSD": 2.0,
        "gbpToEUR": 1.11,
        "gbpToCAN": 1.64,
        "eurToGBP": 0.90,
        "eurToUSD": 0.6667,
        "eurToCAN": 1.48,
        ]
    
    init(amount: Int, currency: String) {
        self.currency = currency
        self.amount = amount

    }

    
    public func convert(_ to: String) -> Money {
        
//        switch value {
//        case .GBP:
//            switch
//        }
       let conversionRate = [
            "usdToGBP": 0.5,
            "usdToEUR": 1.5,
            "usdToCAN": 1.25,
            "canToGBP": 0.61,
            "canToEUR": 0.6667,
            "canToUSD": 0.8,
            "gbpToUSD": 2.0,
            "gbpToEUR": 1.11,
            "gbpToCAN": 1.64,
            "eurToGBP": 0.90,
            "eurToUSD": 0.6667,
            "eurToCAN": 1.48,
            ]
        
        
        
        switch self.currency {
        case "GBP":
            switch to {
            case "USD":
                return Money(amount: Int(Double(self.amount) * conversionRate["gbpToUSD"]!), currency: "USD")
            case "EUR":
                return Money(amount: Int(Double(self.amount) * conversionRate["gbpToEUR"]!), currency: "EUR")
            case "CAN":
                return Money(amount: Int(Double(self.amount) * conversionRate["gbpToCAN"]!), currency: "CAN")
            default:
                return Money(amount: self.amount, currency: self.currency)
            }
        case "CAN":
            switch to {
            case "USD":
                return Money(amount: Int(Double(self.amount) * conversionRate["canToUSD"]!), currency: "USD")
            case "EUR":
                return Money(amount: Int(Double(self.amount) * conversionRate["canToEUR"]!), currency: "EUR")
            case "GBP":
                return Money(amount: Int(Double(self.amount) * conversionRate["canToGBP"]!), currency: "GBP")
            default:
                return Money(amount: self.amount, currency: self.currency)
            }
        case "EUR":
            switch to {
            case "USD":
                return Money(amount: Int(Double(self.amount) * conversionRate["eurToUSD"]!), currency: "USD")
            case "EUR":
                return Money(amount: Int(Double(self.amount) * conversionRate["eurToGBP"]!), currency: "GBP")
            case "CAN":
                return Money(amount: Int(Double(self.amount) * conversionRate["eurToCAN"]!), currency: "CAN")
            default:
                return Money(amount: self.amount, currency: self.currency)
            }
        default:
            switch to {
            case "GBP":
                return Money(amount: Int(Double(self.amount) * conversionRate["usdToGBP"]!), currency: "GBP")
            case "EUR":
                return Money(amount: Int(Double(self.amount) * conversionRate["usdToEUR"]!), currency: "EUR")
            case "CAN":
                return Money(amount: Int(Double(self.amount) * conversionRate["usdToCAN"]!), currency: "CAN")
            default:
                return Money(amount: self.amount, currency: self.currency)
            }
        }
    }


    public func add(_ to: Money) -> Money {
        return Money(amount: to.amount + self.convert(to.currency).amount, currency: to.currency)
    }
    
    public func subtract(_ from: Money) -> Money {
        return Money(amount: from.amount + self.convert(from.currency).amount, currency: from.currency)
    }
}


////////////////////////////////////
// Job
//
open class Job {
    fileprivate var title : String
    fileprivate var type : JobType


    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
  

    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
  

    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
        case .Hourly(let time):
            return Int(time * Double(hours))
        case .Salary(let time):
            return time
        }
    }
  
    open func raise(_ amt : Double) {
        switch self.type {
        case .Hourly(let hourly):
            self.type = .Hourly(hourly + amt)
        case .Salary(let salary):
            self.type = .Salary(salary + Int(amt))
        }
    }
}

////////////////////////////////////
// Person
//
open class Person {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0

    fileprivate var _job : Job? = nil
    open var job : Job? {
        get {
            return _job
        }
        set(value) {
            if self.age >= 16 {
                self._job = value
            }
        }
    }
  
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get {
            return _spouse
        }
        set(value) {
            if self.age >= 18 {
                self._spouse = value
            }
        }
    }
  
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
  
    open func toString() -> String {
        return ("[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]")
    }
}

////////////////////////////////////
// Family
//
open class Family {
    fileprivate var members : [Person] = []
  
    public init(spouse1: Person, spouse2: Person) {
        members.append(spouse1)
        members.append(spouse2)
        
        // test for validity before proceding
        assert(spouse1._spouse == nil)
        assert(spouse2._spouse == nil)
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
    }
  
    open func haveChild(_ child: Person) -> Bool {
//        child.age = 0
        members.append(child)
        return true
    }
    
    open func householdIncome() -> Int {
        var result: Int = 0
        for member in self.members {
            if member.job != nil {
                result = result + (member.job?.calculateIncome(2000))!
            }
        }
        return result
    }
}

