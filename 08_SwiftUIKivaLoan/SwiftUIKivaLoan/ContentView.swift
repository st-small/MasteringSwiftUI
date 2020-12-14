//
//  ContentView.swift
//  SwiftUIKivaLoan
//
//  Created by Stanly Shiyanovskiy on 24.11.2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var loanStore = LoanStore()
    
    @State private var filterEnabled = false
    @State private var maximumLoanAmount = 10000.0
    
    var body: some View {
        NavigationView {
            
            if filterEnabled {
                LoanFilterView(amount: $maximumLoanAmount)
                    .transition(.opacity)
            }
            
            List(loanStore.loans) { loan in
                
                LoanCellView(loan: loan)
                    .padding(.vertical, 5)
            }
            
            .navigationBarTitle("Kiva Loan")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        withAnimation(.linear) {
                                            filterEnabled.toggle()
                                            loanStore.filterLoans(maxAmount: Int(maximumLoanAmount))
                                        }
                                    }) {
                                        Text("Filter")
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
                                    }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear() {
            loanStore.fetchLatestLoans()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
