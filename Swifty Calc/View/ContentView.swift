//
//  ContentView.swift
//  Swifty Calc
//
//  Created by Cory Carte on 7/16/22.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "×"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
}

enum CurrentOperation {
    case add, subtract, divide, multiply, equal, none
}

struct ContentView: View {
    @State var display: String = "0"
    @State var intermediateCalc: (n1: Double, op: CurrentOperation)?
    @State var doneTyping = false
    
    private var value: Double {
        get {
            guard let number = Double(self.display) else {
                fatalError("Error converting value to string: \(self.display)")
            }
            
            return number
        }
        set {
            self.display = String(newValue)
        }
    }
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    private func buttonWidth(_ item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        
        return ((UIScreen.main.bounds.width - (5 * 12)) / 4)
    }
    
    private var buttonHeight: CGFloat {
        get {
            return ((UIScreen.main.bounds.width) - (5 * 12)) / 4
        }
    }
    
    private func getButtonColor(_ button: CalcButton) -> Color {
        switch (button) {
        case .add, .subtract, .multiply, .divide, .equal:
            return Color(.orange)
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }

    private func getCurrentOp(_ button: CalcButton) -> CurrentOperation {
        switch button {
        case .add:
            return CurrentOperation.add
        case .subtract:
            return CurrentOperation.subtract
        case .multiply:
            return CurrentOperation.multiply
        case .divide:
            return CurrentOperation.divide
        default:
            fatalError("Unknown current op: \(button.rawValue)")
        }
    }
    
    private func performTwoNumberCalculation(_ n2: Double) -> Double {
        if let intermediate = intermediateCalc {
            
        } else {
            return n2
        }
    }
    
    private func handleButton(_ button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide:
            intermediateCalc = (n1: self.value, op: getCurrentOp(button))
        case .equal:
            per
        default:
            break
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                // Calc text display
                HStack{
                    Spacer()
                    Text(display)
                        .bold()
                        .font(.system(size: 75))
                        .foregroundColor(.white)
                }
                .padding()
                // buttons
                ForEach(buttons, id:\.self) { row in
                    HStack {
                    ForEach(row, id: \.self) { item in
                        Button(action: {
                            print("Handle button: \(item.rawValue)")
                            self.handleButton(item)
                        }, label: {
                            Text(item.rawValue)
                                .font(.system(size: 32))
                                .frame(width: self.buttonWidth(item),
                                       height: self.buttonHeight)
                                .background(getButtonColor(item))
                                .foregroundColor(Color.white)
                                .cornerRadius(self.buttonWidth(item) / 2)
                        })
                    }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro")
    }
}
