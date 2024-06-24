//
//  JobViewModel.swift
//  SwiftHire
//
//  Created by Justin Jiang on 6/20/24.
//

import Foundation
import SwiftCSV

class JobViewModel: ObservableObject {
    @Published var jobs = [Job]()   // stores an array of Job objects
    @Published var searchText = ""  // holds the current search query text
    @Published var errorMessage: String?    // stores error message if CSV loading fails

    // computed property to filter jobs based on searchText
    var filteredJobs: [Job] {
        if searchText.isEmpty {
            return jobs // return all jobs if search text is empty
        } else {
            return jobs.filter { $0.jobTitle.localizedCaseInsensitiveContains(searchText) || $0.companyName.localizedCaseInsensitiveContains(searchText) }  // returns jobs that match the search text either in jobTitle or companyName
        }
    }

    // function to load jobs from a CSV file
    func loadJobs() {
        jobs.removeAll()    // clear existing jobs

        do {
            // attempt to load CSV file with specified parameters
            if let resource = try CSV<Named>(
                name: "jobs",
                extension: "csv",
                bundle: .main,
                delimiter: .comma,
                encoding: .utf8) {

                // iterate over each row in the CSV file
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
                // set error message and print to console if CSV file could not be loaded or parsed
                self.errorMessage = "Failed to load or parse the CSV file."
                print("Failed to load or parse the CSV file.")
            }
        } catch {
            // catch and set error message and print to console if an error occurs during CSV reading
            self.errorMessage = "Error reading CSV: \(error.localizedDescription)"
            print("Error reading CSV: \(error)")
        }
    }
    
    // helper function to return value or a default string if the value is nil or empty
    func getValueOrDefault(_ value: String?, defaultString: String) -> String {
        // checks if value is nil or empty, returns defaultString if true, otherwise returns the value
        return value?.isEmpty ?? true ? defaultString : value!
    }

}
