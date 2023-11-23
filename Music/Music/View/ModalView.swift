//
//  ModalView.swift
//  Music
//
//  Created by Simone Boni on 18/11/23.
//

import SwiftUI

struct ModalView: View {
    @State var showModal = false
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button(action: { showModal.toggle() }) {
            PlayerView()
        }
        .fullScreenCover(isPresented: $showModal) {
            CloseModalView()
        }
        
    }
}


#Preview {
    ModalView()
}
