//
//  ScrumView.swift
//  Scrumdinger
//
//  Created by Kanz on 2020/12/18.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State private var isPresented: Bool = false
    @State private var newScrumData = DailyScrum.Data()
    
    var body: some View {
        List {
            ForEach(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: binding(for: scrum))) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.color)
            }
        } // List
        .navigationTitle("Daily Scrums")
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "plus")
        }))
        .sheet(isPresented: $isPresented) {
            NavigationView {
                EditView(scrumData: $newScrumData)
                    .navigationBarItems(leading: Button("Dismiss", action: {
                        isPresented = false
                    }), trailing: Button("Add", action: {
                        let newScrum = DailyScrum(title: newScrumData.title,
                                                  attendees: newScrumData.attendees,
                                                  lengthInMinutes: Int(newScrumData.lengthInMinutes),
                                                  color: newScrumData.color)
                        scrums.append(newScrum)
                        isPresented = false
                    }))
            }
        }
    }
    
    private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
        guard let scrumIndex = scrums.firstIndex(where: { $0.id == scrum.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $scrums[scrumIndex]
    }
}

struct ScrumView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.data))
        }
    }
}
