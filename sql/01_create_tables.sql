BEGIN;

-- table -> branches
CREATE TABLE IF NOT EXISTS branches (
    branch_id   BIGINT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city        VARCHAR(100),
    state       VARCHAR(100),
    opened_date DATE,
    ifsc_code   VARCHAR(20) UNIQUE
);

-- table -> customers
CREATE TABLE IF NOT EXISTS customers (
    customer_id   BIGINT PRIMARY KEY,
    name          VARCHAR(150) NOT NULL,
    gender        VARCHAR(30),
    date_of_birth DATE,
    city          VARCHAR(100),
    state         VARCHAR(100),
    phone         VARCHAR(20),
    email         VARCHAR(255),
    occupation    VARCHAR(100),
    annual_income NUMERIC(14, 2),
    join_date     DATE,
    credit_score  SMALLINT
);

-- table -> employees
CREATE TABLE IF NOT EXISTS employees (
    employee_id BIGINT PRIMARY KEY,
    name        VARCHAR(150) NOT NULL,
    branch_id   BIGINT,
    role        VARCHAR(100),
    hire_date   DATE,
    salary      NUMERIC(14, 2),
    CONSTRAINT fk_employees_branch
        FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

-- table -> accounts
CREATE TABLE IF NOT EXISTS accounts (
    account_id   BIGINT PRIMARY KEY,
    customer_id  BIGINT NOT NULL,
    branch_id    BIGINT NOT NULL,
    account_type VARCHAR(50),
    balance      NUMERIC(16, 2),
    open_date    DATE,
    status       VARCHAR(30),
    CONSTRAINT fk_accounts_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_accounts_branch
        FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

-- table -> loans
CREATE TABLE IF NOT EXISTS loans (
    loan_id      BIGINT PRIMARY KEY,
    customer_id  BIGINT NOT NULL,
    branch_id    BIGINT NOT NULL,
    loan_type    VARCHAR(100),
    loan_amount  NUMERIC(16, 2),
    interest_rate NUMERIC(7, 4),
    term_months  INTEGER,
    start_date   DATE,
    status       VARCHAR(30),
    CONSTRAINT fk_loans_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_loans_branch
        FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

-- table -> cards
CREATE TABLE IF NOT EXISTS cards (
    card_id      BIGINT PRIMARY KEY,
    customer_id  BIGINT NOT NULL,
    account_id   BIGINT NOT NULL,
    card_type    VARCHAR(50),
    issue_date   DATE,
    expiry_date  DATE,
    credit_limit NUMERIC(16, 2),
    status       VARCHAR(30),
    CONSTRAINT fk_cards_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_cards_account
        FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- table -> support_tickets
CREATE TABLE IF NOT EXISTS support_tickets (
    ticket_id         BIGINT PRIMARY KEY,
    customer_id       BIGINT NOT NULL,
    issue_type        VARCHAR(100),
    date_opened       DATE,
    date_resolved     DATE,
    status            VARCHAR(30),
    satisfaction_score SMALLINT,
    CONSTRAINT fk_support_tickets_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- table -> transactions
CREATE TABLE IF NOT EXISTS transactions (
    transaction_id  BIGINT PRIMARY KEY,
    account_id      BIGINT NOT NULL,
    txn_date        DATE,
    txn_type        VARCHAR(50),
    amount          NUMERIC(16, 2),
    channel         VARCHAR(50),
    merchant_category VARCHAR(100),
    CONSTRAINT fk_transactions_account
        FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- table -> loan_payments
CREATE TABLE IF NOT EXISTS loan_payments (
    payment_id          BIGINT PRIMARY KEY,
    loan_id             BIGINT NOT NULL,
    payment_date        DATE,
    amount_paid         NUMERIC(16, 2),
    principal_component NUMERIC(16, 2),
    interest_component  NUMERIC(16, 2),
    late_payment_flag   SMALLINT,
    CONSTRAINT fk_loan_payments_loan
        FOREIGN KEY (loan_id) REFERENCES loans(loan_id),
    CONSTRAINT chk_late_payment_flag
        CHECK (late_payment_flag IN (0, 1) OR late_payment_flag IS NULL)
);

-- table -> card_transactions
CREATE TABLE IF NOT EXISTS card_transactions (
    card_txn_id      BIGINT PRIMARY KEY,
    card_id          BIGINT NOT NULL,
    txn_date         DATE,
    merchant_category VARCHAR(100),
    amount           NUMERIC(16, 2),
    is_fraud         SMALLINT,
    CONSTRAINT fk_card_transactions_card
        FOREIGN KEY (card_id) REFERENCES cards(card_id),
    CONSTRAINT chk_card_transactions_is_fraud
        CHECK (is_fraud IN (0, 1) OR is_fraud IS NULL)
);

-- Helpful indexes for common joins and filtering.
CREATE INDEX IF NOT EXISTS idx_employees_branch_id
    ON employees(branch_id);
CREATE INDEX IF NOT EXISTS idx_accounts_customer_id
    ON accounts(customer_id);
CREATE INDEX IF NOT EXISTS idx_accounts_branch_id
    ON accounts(branch_id);
CREATE INDEX IF NOT EXISTS idx_loans_customer_id
    ON loans(customer_id);
CREATE INDEX IF NOT EXISTS idx_loans_branch_id
    ON loans(branch_id);
CREATE INDEX IF NOT EXISTS idx_cards_customer_id
    ON cards(customer_id);
CREATE INDEX IF NOT EXISTS idx_cards_account_id
    ON cards(account_id);
CREATE INDEX IF NOT EXISTS idx_support_tickets_customer_id
    ON support_tickets(customer_id);
CREATE INDEX IF NOT EXISTS idx_transactions_account_id
    ON transactions(account_id);
CREATE INDEX IF NOT EXISTS idx_transactions_txn_date
    ON transactions(txn_date);
CREATE INDEX IF NOT EXISTS idx_loan_payments_loan_id
    ON loan_payments(loan_id);
CREATE INDEX IF NOT EXISTS idx_card_transactions_card_id
    ON card_transactions(card_id);
CREATE INDEX IF NOT EXISTS idx_card_transactions_txn_date
    ON card_transactions(txn_date);

COMMIT;


-- Sequence for importing data 
-- branches -> customers -> emoloyees -> accounts -> loans -> support_tickets -> transactions -> loan_payments -> card_transactions