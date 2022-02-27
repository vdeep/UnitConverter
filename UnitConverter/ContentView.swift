//
//  ContentView.swift
//  UnitConverter
//
//  Created by Vishal on 27/02/22.
//

import SwiftUI

struct ContentView: View {
    enum TemperatureUnit {
        case celcius
        case fahrenheit
        case kelvin

        var title: String {
            switch self {
            case .celcius: return "Celcius"
            case .fahrenheit: return "Fahrenheit"
            case .kelvin: return "Kelvin"
            }
        }

        static var all: [TemperatureUnit] {
            return [.celcius, .fahrenheit, .kelvin]
        }

        func baseValue(_ value: Double) -> Double {
            switch self {
            case .celcius: return value
            case .fahrenheit: return (value - 32.0) / 1.8
            case .kelvin: return value - 273.15
            }
        }

        func convert(_ value: Double) -> Double {
            switch self {
            case .celcius: return value
            case .fahrenheit: return value * 1.8 + 32.0
            case .kelvin: return value + 273.15
            }
        }
    }

    @State private var inputUnit: TemperatureUnit = .celcius
    @State private var inputValue: Double = 0
    @State private var outputUnit: TemperatureUnit = .fahrenheit
    @FocusState private var inputIsFocused: Bool

    private var outputValue: Double {
        let baseValue = inputUnit.baseValue(inputValue)
        return outputUnit.convert(baseValue)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(TemperatureUnit.all, id: \.self) {
                            Text($0.title)
                        }
                    }
                        .pickerStyle(.segmented)
                    TextField("Input value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Input")
                }

                Section {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(TemperatureUnit.all, id: \.self) {
                            Text($0.title)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text(outputValue.formatted())
                } header: {
                    Text("Output")
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        inputIsFocused = false
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
