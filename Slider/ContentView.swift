import SwiftUI

struct ContentView: View {
    @State private var sliderValue1: Double = 50.0
    @State private var sliderValue2: Double = 75.0
    @State private var selectedSegment1: Int = 2
    @State private var selectedSegment2: Int = 3
    @State private var showAlert: Bool = false

    var body: some View {
        VStack {
            Text("Muestra mensaje según el nivel")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()

            Slider(value: $sliderValue1, in: 0...100, step: 1.0)
                .onChange(of: sliderValue1) { newValue, oldValue in
                    updateSegmentedControlValue(sliderValue: newValue, selectedSegment: $selectedSegment1)
                }

                .padding(.horizontal)

            Picker("Nivel", selection: $selectedSegment1) {
                Text("Muy bajo").tag(0)
                Text("Bajo").tag(1)
                Text("Medio").tag(2)
                Text("Alto").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedSegment1) { newValue, oldValue in
                updateSliderValue(selectedSegment: newValue, sliderValue: $sliderValue1)
            }
            .padding()

            Slider(value: $sliderValue2, in: 0...100, step: 1.0)
                .onChange(of: sliderValue2) { newValue, oldValue in
                    updateSegmentedControlValue(sliderValue: newValue, selectedSegment: $selectedSegment2)
                }
                .padding(.horizontal)

            Picker("Nivel", selection: $selectedSegment2) {
                Text("Muy bajo").tag(0)
                Text("Bajo").tag(1)
                Text("Medio").tag(2)
                Text("Alto").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedSegment2) { newValue, oldValue in
                updateSliderValue(selectedSegment: newValue, sliderValue: $sliderValue2)
            }
            .padding()

            Button("Mostrar") {
                showAlert = true
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Mensajes"),
                      message: Text("Slider 1: \(getMessage(for: sliderValue1))\nSlider 2: \(getMessage(for: sliderValue2))\nNivel 1: \(getMessage(for: sliderValue1))\nNivel 2: \(getMessage(for: sliderValue2))"),
                      dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }

    func getMessage(for value: Double) -> String {
        switch value {
        case 0..<25:
            return "Muy bajo"
        case 25..<50:
            return "Bajo"
        case 50..<75:
            return "Medio"
        case 75...100:
            return "Alto"
        case 100:
            return "Alto"  // Ajuste para cuando el valor es exactamente 100
        default:
            return "Fuera de rango"
        }
    }

    func updateSliderValue(selectedSegment: Int, sliderValue: Binding<Double>) {
        sliderValue.wrappedValue = Double(selectedSegment) * 25.0
    }

    func updateSegmentedControlValue(sliderValue: Double, selectedSegment: Binding<Int>) {
        let segment = min(Int(sliderValue / 25.0), 3)
        selectedSegment.wrappedValue = segment
    }
}

#Preview {
    ContentView()
}
