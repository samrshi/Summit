//
//  ContentView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI
import Cocoa

struct ContentView: View {
    @State private var showAddView: Bool = false
    
    @ObservedObject var meetings: Meetings = Meetings()
    
    var body: some View {
        VStack {
            Header(title: "Summit", showAddView: $showAddView)
            
            Divider()
            
            Group {
                if !self.showAddView {
                    ScrollView(.vertical) {
                        MeetingListView(meetings: meetings, showAddView: showAddView)
                    }
                }
                
                if self.showAddView {
                    AddView(presentationMode: self.$showAddView, meetings: self.meetings)
                }
            }
            .transition(.opacity)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
