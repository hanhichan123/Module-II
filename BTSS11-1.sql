CREATE DATABASE BT11_1;
USE BT11_1;

CREATE TABLE Accounts (
accountID INT PRIMARY KEY,
Balance DECIMAL(10,2)
);

CREATE TABLE Transactions (
TransactionID INT PRIMARY KEY,
FromAccountID INT NOT NULL,
FOREIGN KEY(FromAccountID) REFERENCES Accounts(accountID),
ToAccountID INT NOT NULL,
FOREIGN KEY(ToAccountID) REFERENCES Accounts(accountID),
Amount DECIMAL(10,2),
TransactionDATE DATETIME
)

-- Viết một stored procedure để thực hiện một giao dịch chuyển tiền từ một tài khoản sang tài khoản khác. 
-- Stored procedure này cần đảm bảo rằng giao dịch là nguyên tử (atomic) và số dư của tài khoản nguồn không bị âm.

DELIMITER $$
CREATE PROCEDURE TRAIN_MONEY (
IN _FromAccountID INT,
IN _ToAccountID INT,
IN _Amount DECIMAL(10,2)
)

DELIMITER $$
CREATE PROCEDURE TRAIN_MONEY (
    IN _FromAccountID INT,
    IN _ToAccountID INT,
    IN _Amount DECIMAL(10,2)
)
BEGIN
    DECLARE currentBalance DECIMAL(10,2);

    START TRANSACTION;

    SELECT Balance INTO currentBalance
    FROM accounts
    WHERE accountID = _FromAccountID
    FOR UPDATE;

    IF currentBalance < _Amount THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'SỐ DƯ KHẢ DỤNG KHÔNG ĐỦ';
    ELSE
        UPDATE accounts
        SET Balance = Balance - _Amount
        WHERE accountID = _FromAccountID;

        UPDATE accounts
        SET Balance = Balance + _Amount
        WHERE accountID = _ToAccountID;

        COMMIT;
    END IF;
END $$
DELIMITER ;

INSERT INTO Accounts (accountID, Balance) 
VALUES
(1, 1000.00),
(2, 500.00),
(3, 2000.00);

INSERT INTO Transactions (TransactionID, FromAccountID, ToAccountID, Amount, TransactionDATE) 
VALUES
(1, 1, 2, 300.00, NOW()),
(2, 2, 3, 150.00, NOW());


CALL TRAIN_MONEY(1, 2, 300.00);