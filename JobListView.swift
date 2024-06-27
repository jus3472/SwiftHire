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
                            
                            Text(job.jobTitle).font(.custom("Vedo", size: 18))
                                .fontWeight(.heavy)
                                .foregroundColor(Color(red: 61/255, green: 61/255, blue: 61/255, opacity: 1)).padding(.top, 9)
                            
                            Text(job.companyName).font(.custom("AvenirNext-Medium", size: 16))
                                .foregroundColor(Color(red: 244/255, green: 96/255, blue: 54/255, opacity: 1))
                            
                            Text(job.location).font(.custom("AvenirNext-Regular", size: 12))
                                .foregroundColor(.gray).frame(width: 100, height: 10)

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
            .navigationTitle("Jobs").font(.custom("Futura-Medium", size: 15))
            .listStyle(GroupedListStyle())
        }
        
    }
}

#Preview {
    JobListView()
}
