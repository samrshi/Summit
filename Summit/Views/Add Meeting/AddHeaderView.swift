//
//  AddHeaderView.swift
//  Summit
//
//  Created by hawkeyeshi on 9/14/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct AddHeaderView: View {
    @EnvironmentObject var userInfo: UserInfo
    let editViewState: EditViewStates
    
    var body: some View {
        HStack(alignment: .center) {
            Text("\(editViewState == .add ? "Add" : "Edit") a Recurring Meeting")
                .heading2()
                
            Spacer()
        }
        .padding(.bottom)
    }
}
