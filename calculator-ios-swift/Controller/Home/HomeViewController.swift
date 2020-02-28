//
//  HomeViewController.swift
//  calculator-ios-swift
//
//  Created by David Martinez on 26/02/20.
//  Copyright © 2020 David Martinez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets
    
    // Result
    @IBOutlet weak var lblResult: UILabel!
    
    // Numbers
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    
    //Operators
    @IBOutlet weak var btnAC: UIButton!
    @IBOutlet weak var btnPlusMinus: UIButton!
    @IBOutlet weak var btnPercent: UIButton!
    @IBOutlet weak var btnDivision: UIButton!
    @IBOutlet weak var btnMultiplication: UIButton!
    @IBOutlet weak var btnSubstraction: UIButton!
    @IBOutlet weak var btnAddition: UIButton!
    @IBOutlet weak var btnResult: UIButton!
    @IBOutlet weak var btnDecimal: UIButton!
    
    // MARK: - Variables
    private var total: Double = 0                   // Total
    private var temp: Double = 0                    // Valor por pantalla
    private var operating = false                   // Indicar si se ha seleccionado un operador
    private var decimal = false                     // Indicar si el valor es decimal
    private var operation: OperationType = .none    // Operación actual
    
    // MARK: - Constantes
    
    private let kDecimalSeparator = Locale.current.decimalSeparator!
    private let kMaxLength = 9
    private let kTotal = "total"
    
    private enum OperationType {
        case none, addiction, substraction, multiplication, division, percent
    }
    
    // Formateo de valores auxiliar
    private let auxFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
    
    // Formateo de valores auxiliares totales
    private let auxTotalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = ""
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()

    // Formateo de valores por pantalla por defecto
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()
    
    // Formateo de valores por pantalla en formato científico
    private let printScientificFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 3
        formatter.exponentSymbol = "e"
        return formatter
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cambia el caracter decimal según la región del dispositivo
        btnDecimal.setTitle(kDecimalSeparator, for: .normal)
        
        total = UserDefaults.standard.double(forKey: kTotal)
        
        result()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // UI
        btn0.round()
        btn1.round()
        btn2.round()
        btn3.round()
        btn4.round()
        btn5.round()
        btn6.round()
        btn7.round()
        btn8.round()
        btn9.round()
        
        btnAC.round()
        btnPlusMinus.round()
        btnPercent.round()
        btnDivision.round()
        btnMultiplication.round()
        btnSubstraction.round()
        btnAddition.round()
        btnResult.round()
        btnDecimal.round()
    }
    
    // MARK: - Button Actions
    
    @IBAction func btnActionAC(_ sender: UIButton) {
        clear()
        sender.shine()
    }
    
    @IBAction func btnActionPlusMinus(_ sender: UIButton) {
        temp = temp * (-1)
        lblResult.text = printFormatter.string(from: NSNumber(value: temp))

        sender.shine()
    }
    
    @IBAction func btnActionPercent(_ sender: UIButton) {
        if operation != .percent {
            result()
        }
        
        operating = true
        operation = .percent
        result()
        
        sender.shine()
    }
    
    @IBAction func btnActionDivision(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .division
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    @IBAction func btnActionMultiplication(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .multiplication
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    @IBAction func btnActionSubstraction(_ sender: UIButton) {
        if operation != .none {
            result()
        }

        operating = true
        operation = .substraction
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    @IBAction func btnActionAddition(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .addiction
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    @IBAction func btnActionResult(_ sender: UIButton) {
        result()
        sender.shine()
    }
    
    @IBAction func btnActionDecimal(_ sender: UIButton) {
        let currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        
        if lblResult.text?.contains(kDecimalSeparator) ?? false || (!operating && currentTemp.count >= kMaxLength) {
            return
        }

        lblResult.text = lblResult.text! + kDecimalSeparator
        decimal = true
        
        selectVisualOperation()
        
        sender.shine()
    }
    
    @IBAction func btnActionNumber(_ sender: UIButton) {
        btnAC.setTitle("C", for: .normal)

        var currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        
        currentTemp = auxFormatter.string(from: NSNumber(value: temp))!

        // Hemos seleccionado una operación
        if operating {
            total = total == 0 ? temp : total
            lblResult.text = ""
            currentTemp = ""
            operating = false
        }

        // Hemos seleccionado decimales
        if decimal {
            currentTemp = "\(currentTemp)\(kDecimalSeparator)"
            decimal = false
        }

        let number = sender.tag
        temp = Double(currentTemp + String(number))!
        lblResult.text = printFormatter.string(from: NSNumber(value: temp))
        
        selectVisualOperation()
        
        sender.shine()
    }
    
    // Limpia los valores
    private func clear() {
        operation = .none
        btnAC.setTitle("AC", for: .normal)
        if temp != 0 {
            temp = 0
            lblResult.text = "0"
        } else {
            total = 0
            result()
        }
    }
    
    // Obtiene el resultado final
    private func result() {
        switch operation {
        case .none:
            // No hacemos nada
            break
        case .addiction:
            total = total + temp
            break
        case .substraction:
            total = total - temp
            break
        case .multiplication:
            total = total * temp
            break
        case .division:
            total = total / temp
            break
        case .percent:
            temp = temp / 100
            total = temp
            break
        }

        // Formateo en pantalla
        if let currentTotal = auxTotalFormatter.string(from: NSNumber(value: total)), currentTotal.count > kMaxLength {
            lblResult.text = printScientificFormatter.string(from: NSNumber(value: total))
        } else {
            lblResult.text = printFormatter.string(from: NSNumber(value: total))
        }
        
        operation = .none
        
        selectVisualOperation()
        
        UserDefaults.standard.set(total, forKey: kTotal)

        print("TOTAL: \(total)")
    }
    
    // Muestra de forma visual la operación seleccionada
    private func selectVisualOperation() {
        if !operating {
            // No estamos operando
            btnAddition.selectOperation(false)
            btnSubstraction.selectOperation(false)
            btnMultiplication.selectOperation(false)
            btnDivision.selectOperation(false)
        } else {
            switch operation {
            case .none, .percent:
                btnAddition.selectOperation(false)
                btnSubstraction.selectOperation(false)
                btnMultiplication.selectOperation(false)
                btnDivision.selectOperation(false)
                break
            case .addiction:
                btnAddition.selectOperation(true)
                btnSubstraction.selectOperation(false)
                btnMultiplication.selectOperation(false)
                btnDivision.selectOperation(false)
                break
            case .substraction:
                btnAddition.selectOperation(false)
                btnSubstraction.selectOperation(true)
                btnMultiplication.selectOperation(false)
                btnDivision.selectOperation(false)
                break
            case .multiplication:
                btnAddition.selectOperation(false)
                btnSubstraction.selectOperation(false)
                btnMultiplication.selectOperation(true)
                btnDivision.selectOperation(false)
                break
            case .division:
                btnAddition.selectOperation(false)
                btnSubstraction.selectOperation(false)
                btnMultiplication.selectOperation(false)
                btnDivision.selectOperation(true)
                break
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
