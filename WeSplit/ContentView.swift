//
//  ContentView.swift
//  WeSplit
//
//  Created by Jiaming Guo on 2022-07-19.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
    
    private var currencyCode: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "CAD")
    private let tipPercentages = [10, 15, 20, 25, 0]
    
    private var grandTotal: Double {
        let tipValue = checkAmount / 100 * Double(tipPercentage)
        return checkAmount + tipValue
    }
    
    private var totalPerPerson: Double {
        return grandTotal / Double(numberOfPeople + 2)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyCode)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker(selection: $numberOfPeople, label: Text("Number of People")) {
                        ForEach(2..<50) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Enter the amount")
                }
                
                Section {
                    Picker(selection: $tipPercentage, label: Text("Tip Percentage")) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    VStack(spacing: 10) {
                        HStack {
                            Text("Grand Total")
                            Spacer()
                            Text(grandTotal, format: currencyCode)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(tipPercentage == 0 ? .red : .primary)
                        }
                        HStack {
                            Text("Amount Per Person")
                            Spacer()
                            Text(totalPerPerson, format: currencyCode)
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.bottom)
                    .padding(.top)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
