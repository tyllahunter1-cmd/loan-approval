Overview

The Loan Approval Contract (VLDE) is a Clarity smart contract that enables a decentralized and transparent loan request and approval system on the Stacks blockchain.

It provides a secure way for borrowers to request loans, validators to approve or reject them, and the contract to automatically disburse STX upon approval.

This project is designed for submission under Code for STX
.

Problem

Traditional loan systems are centralized, prone to delays, corruption, and bias, and often lack transparency. Borrowers in decentralized ecosystems need a trustless, auditable loan approval mechanism that ensures fair and verifiable lending.

Solution

The Loan Approval Contract introduces a decentralized lending process:

Borrowers submit loan requests, specifying amount and purpose.

Validators review requests and decide approval or rejection.

Smart Contract automatically transfers STX loans to approved borrowers.

All loan applications and approvals are transparently stored on-chain for auditing.

Core Features

Loan Request Submission – borrowers create loan requests with metadata.

Validator Approval System – validators approve or reject requests.

Automatic Loan Disbursement – approved loans are instantly released to borrowers.

Transparency – all approvals, rejections, and disbursements are queryable on-chain.

Tech Stack

Smart Contract: Clarity

Testing: Clarinet

Frontend (Optional Demo): React + Stacks.js + Hiro Wallet
