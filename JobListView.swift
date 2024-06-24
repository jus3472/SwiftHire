//
//  JobListView.swift
//  SwiftHire
//
//  Created by Justin Jiang on 6/20/24.
//

import SwiftUI

struct JobListView: View {
    @ObservedObject var viewModel = JobViewModel()  // observes JobViewModel for changes
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            List(viewModel.filteredJobs) { job in    // list displaying filtered job entries
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
            
            // adds search functionality
            .searchable(text: $viewModel.searchText)
            
            // alert setup, shown based on showAlert state
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")) {
                    viewModel.errorMessage = nil    // clear error message on dismiss
                    showAlert = false   // hide alert
                })
            })
            .onAppear {
                // show alert if there is an error message
                showAlert = viewModel.errorMessage != nil
                // loads jobs when view appears
                viewModel.loadJobs()
            }
            .navigationTitle("Jobs")
            .listStyle(GroupedListStyle())
        }
    }
}

#Preview {
    JobListView()
}
