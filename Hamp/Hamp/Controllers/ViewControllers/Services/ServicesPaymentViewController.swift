//
//  ServicesPaymentViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 18/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class ServicesPaymentViewController: HampViewController {
    
    //MARK: Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var endOrderButton: HorizontalCircleGradientButton!
    
    var ordersManager: OrderManager!

    private var cardsProvider: CreditCardsProvider!
    private var selectedCreditCard: CreditCard?
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerReusableCell(ServicesPaymentCollectionViewCell.self)
        collectionView.registerReusableSupplementaryView(ServicesPaymentFooterView.self, kind: UICollectionElementKindSectionFooter)
        cardsProvider = CreditCardsProvider.init()
        setEndOrderDisabled()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.reloadData()
    }
    
    func setEndOrderDisabled() {
        endOrderButton.isEnabled = false
        endOrderButton.alpha = 0.7
    }
    
    //MARK: Actions 
    @IBAction func endOrderWasPressed(sender: UIButton) {
		let transaction = TransactionFactory.createTransaction(services: ordersManager.servicesHired(), amount: ordersManager.order.totalAmount, creditCard: CreditCard(identifier: selectedCreditCard!.identifier))
        
        self.endOrderButton.isEnabled = false
		
		let nav = self.navigationController as? TabBarLargeTitlesNavigationViewController
		nav?.needsActivityIndicator = true
		nav?.startActivityIndicator()
	
		return 
        Hamp.Transactions.createTransaction(transaction: transaction) { (response) in
            if response.code == .ok {
                let newTransaction = response.data!
				let message = newTransaction.booking?.pickUpLockers?.reduce("") { $0 + "\n" + "\($1.number!) - \($1.code!)"}
				
                DispatchQueue.main.async { [unowned self] in
					ProvidersManager.sharedInstance.hampDataManager.addData (object: DBTransaction.init(transaction: newTransaction))
					self.popToRootController(with: {
						let alert = UIAlertController(title: "Genial", message: message!, actions: .ok, style: .alert, block: { (response) in
							print(response)
						})
						self.present(alert, animated: true)
					})
                }
            } else {
                print("ERROR CREATING TRANSACTION", response.message)
            }
        }
    }

	func popToRootController(with blockOnDismiss: (() -> Void)? = nil) {
        ordersManager.removeServicesHired()
		navigationController?.popToRootViewController(completion: blockOnDismiss)
    }
}

extension ServicesPaymentViewController: UICollectionViewDataSource {
    //MARK: DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsProvider.numberOfCreditCards()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReusableCell(indexPath: indexPath) as ServicesPaymentCollectionViewCell

        cell.creditCard = cardsProvider.getCreditCardAt(index: indexPath.row)
        
        if let selectedCardID = selectedCreditCard?.identifier {
            let iden = cardsProvider.getCreditCardAt(index: indexPath.row)!.identifier
            cell.checkBox.isSelected = selectedCardID == iden
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ServicesPaymentCollectionViewCell
        self.selectedCreditCard = cell.creditCard
        self.endOrderButton.isEnabled = true
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeReusableSupplementaryView(kind: kind, indexPath: indexPath) as ServicesPaymentFooterView
        reusableView.delegate = self
        return reusableView
    }
}

extension ServicesPaymentViewController: ServicesPaymentFooterDelegate {
    //MARK: Footer delegate
    func footerWasPressed(on footerView: ServicesPaymentFooterView) {
        performSegue(withIdentifier: "presentAddCreditCard", sender: nil)
    }
}

extension ServicesPaymentViewController: UICollectionViewDelegateFlowLayout {
    //MARK: Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let size: CGFloat = collectionView.frame.width - padding*2
        return CGSize.init(width: size, height: 62)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let padding: CGFloat = 20
        let size: CGFloat = collectionView.frame.width - padding*2
        return CGSize.init(width: size, height: 72)
    }
}

