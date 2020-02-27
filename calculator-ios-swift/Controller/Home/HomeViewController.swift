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
        sender.shine()
    }
    
    @IBAction func btnActionPlusMinus(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func btnActionPercent(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func btnActionDivision(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func btnActionMultiplication(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func btnActionSubstraction(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func btnActionAddition(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func btnActionResult(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func btnActionDecimal(_ sender: UIButton) {
        sender.shine()
    }
    
    @IBAction func btnActionNumber(_ sender: UIButton) {
        sender.shine()
        print(sender.tag)
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
