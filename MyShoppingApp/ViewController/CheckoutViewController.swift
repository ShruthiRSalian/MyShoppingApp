//
//  CheckoutViewController.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 19/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class CheckoutViewController: UIViewController {

    @IBOutlet weak var cardNumber: ValidatingTextField!
    @IBOutlet weak var expDate: ValidatingTextField!
    @IBOutlet weak var cvv: ValidatingTextField!
    @IBOutlet weak var buyButton: UIButton!
    
    var checkoutViewModel = CheckoutViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpObservable()
        setUpRx()
    }
    
    @IBAction func buyItems(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "resultViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //Binding text fields and corresponding variables, to observe for value changes.
    func setUpObservable() {
        cardNumber.rx.text.orEmpty.bind(to: checkoutViewModel.observableCardNumber).disposed(by: checkoutViewModel.disposeBag)
        expDate.rx.text.orEmpty.bind(to: checkoutViewModel.observableExpDate).disposed(by: checkoutViewModel.disposeBag)
        cvv.rx.text.orEmpty.bind(to: checkoutViewModel.observableCVV).disposed(by: checkoutViewModel.disposeBag)
    }
    
    //Sets up isValid observable for enabling buy button. isValid calculated using combining validation of other values.
    func setUpRx() {
        var isValid: Observable<Bool>!
        
        isValid = Observable.combineLatest(self.checkoutViewModel.observableCardNumber.asObservable(),
                                           self.checkoutViewModel.observableExpDate.asObservable(),
                                           self.checkoutViewModel.observableCVV.asObservable()) {
                                            [weak self](cardNumber, expDate, cvv) in
                                            
                                            let validCard = self?.checkoutViewModel.validate(cardText: cardNumber) ?? false
                                            let validExpDate = self?.checkoutViewModel.validate(expirationDateText: expDate) ?? false
                                            let validCvv = self?.checkoutViewModel.validate(cvvText: cvv) ?? false
                                            
                                            return validCard && validExpDate && validCvv
        }
        
        _ = isValid.asObservable().subscribe { [weak self](newValue) in
            self?.buyButton.isEnabled = newValue.element!
        }
    }
}
