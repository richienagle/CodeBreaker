//
//  CodeBreakerApp.swift
//  CodeBreaker
//
//  Created by Rich Nagle on 12/30/25.
//

import SwiftUI

@main
struct CodeBreakerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


// Model and UI
// Separate Logic and Data from UI
// Swift UI does this by:
// 1. Using structs as source of truth.  struct are generally immuatable and are copied
// 2. SwiftUI mmaes you mark all sources of truth with @State or @Observable
// truth sharing is marked by @Binding

// struct is a value type, and a class is a reference type
// mutablitlity od stucts is explicit (var vs. let)
// structs are copied!!
// Efficiency with copies - yes, Swift only makes a copy *on write* (when put in var)

// @States can make a stored var in a View be modifiable

// classes are good for sharing

// structs explicity declasre their identity (usually through var named 'id')

// struct Array<Element, Foo>  Element, Foo is a 'Generic' placeholder for a type

// enum Optional<T> {
//  case none
//  case some(T)    // some case has an associated value of that generic type T
// }

// Declare with syntaz T?
// var hello: String?       //T is String

//  if let safehello = hello {
//    print(safehello)
//  } else {
//    dosomethingelse
//  }
