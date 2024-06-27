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
            List(viewModel.filteredJobs) { job in
                ZStack {
                    // invisible NavigationLink
                    NavigationLink(destination: JobDetailView(job: job)) {
                        EmptyView()
                    }
                    .opacity(0) // makes the NavigationLink and its default pointer fully transparent

                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(job.jobTitle)
                                .font(.custom("Vedo", size: 18))
                                .fontWeight(.heavy)
                                .foregroundColor(Color(red: 61/255, green: 61/255, blue: 61/255))
                                .padding(.top, 9)
                            Text(job.companyName)
                                .font(.custom("AvenirNext-Medium", size: 16))
                                .foregroundColor(Color(red: 244/255, green: 96/255, blue: 54/255))
                            Text(job.location)
                                .font(.custom("AvenirNext-Regular", size: 12))
                                .foregroundColor(.gray)
                                .frame(width: 100, height: 10)
                        }
                        Spacer()
                        Image(systemName: "arrowshape.right.fill")
                            .foregroundColor(Color(red: 244/255, green: 96/255, blue: 54/255))
                            .brightness(0.1)
                    }
                    .padding(5)
                }
            }
            
            .searchable(text: $viewModel.searchText)
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")) {
                    viewModel.errorMessage = nil    // Clear error message on dismiss
                    showAlert = false   // Hide alert
                })
            })
            .onAppear {
                showAlert = viewModel.errorMessage != nil
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
