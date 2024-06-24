//
//  JobListView.swift
//  SwiftHire
//
//  Created by Justin Jiang on 6/20/24.
//

import SwiftUI

struct JobListView: View {
    @ObservedObject var viewModel = JobViewModel()  // observes JobViewModel for changes

    var body: some View {
        NavigationView {
            List(viewModel.filteredJobs) { job in
                NavigationLink(destination: JobDetailView(job: job)) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(job.jobTitle).font(.headline)
                                .foregroundColor(.primary)
                            Text(job.companyName).font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(job.location).font(.caption)
                                .foregroundColor(.gray)
                        }
                }
            }
            
            .searchable(text: $viewModel.searchText)    // adds search functionality
            .onAppear {
                viewModel.loadJobs()    // loads jobs when view appears
            }
            .navigationTitle("Jobs")
            .listStyle(GroupedListStyle())
        }
    }
}

#Preview {
    JobListView()
}
