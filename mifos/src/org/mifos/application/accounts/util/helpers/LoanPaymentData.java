/**

 * LoanPaymentData.java    version: xxx



 * Copyright (c) 2005-2006 Grameen Foundation USA

 * 1029 Vermont Avenue, NW, Suite 400, Washington DC 20005

 * All rights reserved.



 * Apache License
 * Copyright (c) 2005-2006 Grameen Foundation USA
 *

 * Licensed under the Apache License, Version 2.0 (the "License"); you may
 * not use this file except in compliance with the License. You may obtain
 * a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
 *

 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and limitations under the

 * License.
 *
 * See also http://www.apache.org/licenses/LICENSE-2.0.html for an explanation of the license

 * and how it is applied.

 *

 */

package org.mifos.application.accounts.util.helpers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.mifos.application.accounts.business.AccountActionDateEntity;
import org.mifos.application.accounts.business.AccountFeesActionDetailEntity;
import org.mifos.application.accounts.loan.business.LoanScheduleEntity;
import org.mifos.application.bulkentry.business.BulkEntryAccountFeeActionView;
import org.mifos.application.bulkentry.business.BulkEntryInstallmentView;
import org.mifos.application.bulkentry.business.BulkEntryLoanInstallmentView;
import org.mifos.framework.util.helpers.Money;

public class LoanPaymentData extends AccountPaymentData {

	private Money principalPaid;

	private Money interestPaid;

	private Money penaltyPaid;

	private Money miscFeePaid;

	private Money miscPenaltyPaid;

	private Map<Short, Money> feesPaid;

	public Map<Short, Money> getFeesPaid() {
		return feesPaid;
	}

	private void setFeesPaid(Map<Short, Money> feesPaid) {
		this.feesPaid = feesPaid;
	}

	public Money getInterestPaid() {
		return interestPaid;
	}

	private void setInterestPaid(Money interestPaid) {
		this.interestPaid = interestPaid;
	}

	public Money getPenaltyPaid() {
		return penaltyPaid;
	}

	private void setPenaltyPaid(Money penaltyPaid) {
		this.penaltyPaid = penaltyPaid;
	}

	public Money getPrincipalPaid() {
		return principalPaid;
	}

	private void setPrincipalPaid(Money principalPaid) {
		this.principalPaid = principalPaid;
	}

	public Money getMiscFeePaid() {
		return miscFeePaid;
	}

	private void setMiscFeePaid(Money miscFeePaid) {
		this.miscFeePaid = miscFeePaid;
	}

	public Money getMiscPenaltyPaid() {
		return miscPenaltyPaid;
	}

	private void setMiscPenaltyPaid(Money miscPenaltyPaid) {
		this.miscPenaltyPaid = miscPenaltyPaid;
	}

	public LoanPaymentData(AccountActionDateEntity accountActionDate) {
		super(accountActionDate);
		LoanScheduleEntity loanScheduleEntity = (LoanScheduleEntity) accountActionDate;
		setPrincipalPaid(loanScheduleEntity.getPrincipalDue());
		setInterestPaid(loanScheduleEntity.getInterestDue());
		setPenaltyPaid(loanScheduleEntity.getPenalty().subtract(
				loanScheduleEntity.getPenaltyPaid()));
		setMiscFeePaid(loanScheduleEntity.getMiscFeeDue());
		setMiscPenaltyPaid(loanScheduleEntity.getMiscPenaltyDue());
		Map<Short, Money> feesPaid = new HashMap<Short, Money>();
		Set<AccountFeesActionDetailEntity> accountFeesActionDetails = loanScheduleEntity
				.getAccountFeesActionDetails();
		if (accountFeesActionDetails != null
				&& accountFeesActionDetails.size() > 0) {
			for (AccountFeesActionDetailEntity accountFeesActionDetailEntity : accountFeesActionDetails) {
				if (accountFeesActionDetailEntity.getFeeAmount() != null
						&& accountFeesActionDetailEntity.getFeeAmount()
								.getAmountDoubleValue() != 0)
					feesPaid.put(accountFeesActionDetailEntity.getFee()
							.getFeeId(), accountFeesActionDetailEntity
							.getFeeDue());
			}
		}
		setFeesPaid(feesPaid);
		setPaymentStatus(PaymentStatus.PAID.getValue());
	}

	public LoanPaymentData(BulkEntryInstallmentView bulkEntryAccountAction) {
		super(bulkEntryAccountAction);
		BulkEntryLoanInstallmentView installmentView = (BulkEntryLoanInstallmentView) bulkEntryAccountAction;
		setPrincipalPaid(installmentView.getPrincipal());
		setInterestPaid(installmentView.getInterest());
		setPenaltyPaid(installmentView.getPenalty());
		setMiscFeePaid(installmentView.getMiscFee());
		setMiscPenaltyPaid(installmentView.getMiscPenalty());
		Map<Short, Money> feesPaid = new HashMap<Short, Money>();
		List<BulkEntryAccountFeeActionView> bulkEntryAccountFeeActionViews = installmentView
				.getBulkEntryAccountFeeActions();
		if (bulkEntryAccountFeeActionViews != null
				&& bulkEntryAccountFeeActionViews.size() > 0) {
			for (BulkEntryAccountFeeActionView accountFeesActionDetailEntity : bulkEntryAccountFeeActionViews) {
				if (accountFeesActionDetailEntity.getFeeAmount() != null
						&& accountFeesActionDetailEntity.getFeeAmount()
								.getAmountDoubleValue() != 0)
					feesPaid.put(accountFeesActionDetailEntity.getFee()
							.getFeeId(), accountFeesActionDetailEntity
							.getFeeAmount());
			}
		}
		setFeesPaid(feesPaid);
		
	}

	public LoanPaymentData(AccountActionDateEntity accountActionDate,
			Money total) {
		super(accountActionDate);
		LoanScheduleEntity loanScheduleEntity = (LoanScheduleEntity) accountActionDate;
		setMiscPenaltyPaid(getLowest(total, loanScheduleEntity
				.getMiscPenaltyDue()));
		total = total.subtract(getMiscPenaltyPaid());

		setPenaltyPaid(getLowest(total, (loanScheduleEntity.getPenalty()
				.subtract(loanScheduleEntity.getPenaltyPaid()))));
		total = total.subtract(getPenaltyPaid());

		setMiscFeePaid(getLowest(total, loanScheduleEntity.getMiscFeeDue()));
		total = total.subtract(getMiscFeePaid());

		Map<Short, Money> feesPaid = new HashMap<Short, Money>();
		Set<AccountFeesActionDetailEntity> accountFeesActionDetails = loanScheduleEntity
				.getAccountFeesActionDetails();
		if (accountFeesActionDetails != null
				&& accountFeesActionDetails.size() > 0) {
			for (AccountFeesActionDetailEntity accountFeesActionDetailEntity : accountFeesActionDetails) {
				Money feeAmount = getLowest(total,
						accountFeesActionDetailEntity.getFeeDue());
				feesPaid.put(accountFeesActionDetailEntity.getFee().getFeeId(),
						feeAmount);
				total = total.subtract(feeAmount);
			}
		}
		setFeesPaid(feesPaid);

		setInterestPaid(getLowest(total, loanScheduleEntity.getInterestDue()));
		total = total.subtract(getInterestPaid());

		setPrincipalPaid(getLowest(total, loanScheduleEntity.getPrincipalDue()));
		if (total.getAmountDoubleValue() >= loanScheduleEntity
				.getPrincipalDue().getAmountDoubleValue())
			setPaymentStatus(PaymentStatus.PAID.getValue());
		else
			setPaymentStatus(PaymentStatus.UNPAID.getValue());
	}

	public Money getTotalPaidAmount() {
		return getTotalPaidAmnt().add(getTotalFees());
	}

	public Money getTotalAmountPaid() {
		return getTotalPaidAmnt().add(getTotalFeePaid());
	}

	public Money getTotalPaidAmnt() {
		Money totalAmount = new Money();
		return totalAmount.add(getInterestPaid()).add(getPenaltyPaid()).add(
				getPrincipalPaid()).add(getMiscFeePaid()).add(
				getMiscPenaltyPaid());
	}

	public Money getTotalFees() {
		Money totalAmount = new Money();
		LoanScheduleEntity loanScheduleEntity = (LoanScheduleEntity) getAccountActionDate();
		for (AccountFeesActionDetailEntity accountFeesActionDetail : loanScheduleEntity
				.getAccountFeesActionDetails()) {
			if (getFeesPaid().containsKey(
					accountFeesActionDetail.getFee().getFeeId())) {
				accountFeesActionDetail.makePayment(getFeesPaid().get(
						accountFeesActionDetail.getFee().getFeeId()));
				totalAmount = totalAmount.add(accountFeesActionDetail
						.getFeeAmountPaid());
			}
		}
		return totalAmount;
	}

	public Money getTotalFeePaid() {
		Money totalFeePaid = new Money();
		if (!getFeesPaid().isEmpty())
			for (Short feeId : getFeesPaid().keySet()) {
				totalFeePaid = totalFeePaid.add(getFeesPaid().get(feeId));
			}
		return totalFeePaid;
	}

	private Money getLowest(Money money1, Money money2) {
		if (money1.getAmountDoubleValue() > money2.getAmountDoubleValue())
			return money2;
		else
			return money1;
	}
}
