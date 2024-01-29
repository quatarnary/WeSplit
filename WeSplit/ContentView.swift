//
//  ContentView.swift
//  WeSplit
//
//  Created by Bugra Aslan on 27.01.2024.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount = 10.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0.10
//    @State private var tipValue = 0.0
    let tipPercentages: [Double] = [0.0, 0.05, 0.10, 0.15, 0.20, 0.25]
    
    
    var tipValue: Double {
        checkAmount * tipPercentage
    }
    
    var totalPerPerson: Double {
        (checkAmount + tipValue) / Double(numberOfPeople + 2)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Amount") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                Section("How much tip you want to leave?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Number of People") {
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.wheel)
                }
                List {
                    HStack {
                        Text("Total + Tip:")
                        Text("\(checkAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))")
                        Text("+")
                        Text("\(tipValue.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))")
                    }
                    .font(.caption)
                    Text("Personal Amount: \(totalPerPerson.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
