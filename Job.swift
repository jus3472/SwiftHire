//
//  Job.swift
//  SwiftHire
//
//  Created by Justin Jiang on 6/20/24.
//

import Foundation

struct Job: Identifiable, Equatable {
    let id = UUID()
    var jobTitle: String
    var companyName: String
    var location: String
    var jobDescription: String
    var requirements: String
}
