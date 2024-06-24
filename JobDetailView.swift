//
//  JobDetailView.swift
//  SwiftHire
//
//  Created by Justin Jiang on 6/20/24.
//

import SwiftUI

struct JobDetailView: View {
    var job: Job    // job to display details for

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(job.jobTitle).font(.largeTitle).bold()
                Text(job.companyName).font(.title2).foregroundColor(.secondary)
                Text(job.location).font(.headline).foregroundColor(.gray).padding(.bottom, 5)
                Divider()
                Group {
                    Text("Description:")
                        .font(.title3).bold()
                    Text(job.jobDescription)
                }
                Divider()
                Group {
                    Text("Requirements:")
                        .font(.title3).bold()
                    Text(job.requirements)
                }
            }
            .padding()
        }
        .navigationTitle(job.jobTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}
