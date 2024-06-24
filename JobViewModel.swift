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
    @Published var errorMessage: String?    // error message

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
                    let jobTitle = getValueOrDefault(row["Job Title"], defaultString: "Unknown Job Title")
                    let companyName = getValueOrDefault(row["Company Name"], defaultString: "Unknown Company Name")
                    let location = getValueOrDefault(row["Location"], defaultString: "Unknown Location")
                    let jobDescription = getValueOrDefault(row["Job Description"], defaultString: "No Description Provided")
                    let requirements = getValueOrDefault(row["Requirements"], defaultString: "No Requirements Listed")

                    let job = Job(jobTitle: jobTitle, companyName: companyName, location: location, jobDescription: jobDescription, requirements: requirements)
                    jobs.append(job)
                }
            } else {
                self.errorMessage = "Failed to load or parse the CSV file."
                print("Failed to load or parse the CSV file.")
            }
        } catch {
            self.errorMessage = "Error reading CSV: \(error.localizedDescription)"
            print("Error reading CSV: \(error)")    // log errors
        }
    }
    
    func getValueOrDefault(_ value: String?, defaultString: String) -> String {
        return value?.isEmpty ?? true ? defaultString : value!
    }

}
