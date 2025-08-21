;; -------------------------------------------------------
;; Verified Loan Disbursement Engine (VLDE)
;; Contract: loan-approval.clar
;; -------------------------------------------------------

;; -----------------------------
;; ADMIN & GLOBAL STATE
;; -----------------------------
(define-data-var admin principal tx-sender)

;; -----------------------------
;; LOAN STORAGE MAP
;; -----------------------------
(define-map loans uint {
  borrower: principal,
  amount: uint,
  approved: bool,
  repaid: bool,
  start-block: uint,
  repaid-block: uint
})

;; -----------------------------
;; 1. Approve and Disburse Loan
;; -----------------------------
(define-public (approve-loan (loan-id uint))
  (begin
    ;; Only admin can approve
    (asserts! (is-eq tx-sender (var-get admin)) (err u200))

    ;; Fetch loan data
    (match (map-get? loans loan-id)
      loan-data
        (let (
          (already-approved (get approved loan-data))
          (already-repaid (get repaid loan-data))
        )
          ;; Prevent duplicate approval or repayment
          (asserts! (not already-approved) (err u201))
          (asserts! (not already-repaid) (err u202))

          (let (
            (borrower (get borrower loan-data))
            (amount (get amount loan-data))
          )
            ;; Transfer STX from contract to borrower
            (try! (stx-transfer? amount tx-sender borrower))

            ;; Update loan map with approval data
            (map-set loans loan-id {
              borrower: borrower,
              amount: amount,
              approved: true,
              repaid: false,
              start-block: stacks-block-height,
              repaid-block: u0
            })

            (ok { loan-id: loan-id, disbursed: amount })
          )
        )
      (err u203) ;; Loan not found
    )))

;; -----------------------------
;; 2. Read-only: Get Loan Status
;; -----------------------------
(define-read-only (get-loan (loan-id uint))
  (match (map-get? loans loan-id)
    loan (ok loan)
    (err u203)))