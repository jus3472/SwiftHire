//
//  JobViewModel.swift
//  SwiftHire
//
//  Created by Justin Jiang on 6/20/24.
//

import Foundation
import SwiftCSV

class JobViewModel: ObservableObject {
    @Published var jobs = [Job]()   // list of jobs
    @Published var searchText = ""  // search text for filtering jobs

    var filteredJobs: [Job] {
        if searchText.isEmpty {
            return jobs // return all jobs if search text is empty
        } else {
            return jobs.filter { $0.jobTitle.localizedCaseInsensitiveContains(searchText) || $0.companyName.localizedCaseInsensitiveContains(searchText) }  // filter jobs based on search text
        }
    }

    func loadJobs() {
        jobs.removeAll()    // clear existing jobs

        do {
            if let resource = try CSV<Named>(
                name: "jobs",
                extension: "csv",
                bundle: .main,
                delimiter: .comma,
                encoding: .utf8) {

                for row in resource.rows {
                    if let jobTitle = row["Job Title"],
                       let companyName = row["Company Name"],
                       let location = row["Location"],
                       let jobDescription = row["Job Description"],
                       let requirements = row["Requirements"] {
                        let job = Job(jobTitle: jobTitle, companyName: companyName, location: location, jobDescription: jobDescription, requirements: requirements)
                        jobs.append(job)    // create and append new Job instance
                    }
                }
            } else {
                print("Failed to load or parse the CSV file.")
            }
        } catch {
            print("Error reading CSV: \(error)")    // log errors
        }
    }
}
