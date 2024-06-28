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
            List {
                Text("SwiftHire")
                    .font(.custom("Futura", size:40))
                    .foregroundColor(Color(red: 244/255, green: 96/255, blue: 54/255))
                    .frame(maxWidth: .infinity, maxHeight: 80, alignment: .center)
                    .listRowSeparator(.hidden)
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    if !viewModel.searchText.isEmpty {
                        Button(action: {
                            withAnimation {
                                viewModel.searchText = ""
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .transition(.scale)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(20)
                .padding(.horizontal, 15)
                
                ForEach(viewModel.filteredJobs) { job in
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
                                    .padding(.top, 4)
                                    .transition(.slide)
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
                    .animation(.easeInOut(duration: 0.3), value: viewModel.filteredJobs)
                }
                
                Section(footer: Text("© 2024 Justin Jiang. All rights reserved.")
                    .font(.custom("Futura", size:15))
                    .foregroundColor(Color(red: 61/255, green: 61/255, blue: 61/255))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 30)
                    .listRowSeparator(.hidden)
                ) {
                    EmptyView()
                }
                
            }
        
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")) {
                    viewModel.errorMessage = nil    // Clear error message on dismiss
                    withAnimation {
                        showAlert = false   // Hide alert
                    }
                })
            })
            .onAppear {
                withAnimation {
                    showAlert = viewModel.errorMessage != nil
                    viewModel.loadJobs()
                }
            }
            .onChange(of: viewModel.errorMessage, initial: true) { oldError, newError in
                withAnimation {
                    showAlert = newError != nil
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    JobListView()
}
