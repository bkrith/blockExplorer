
<?php

    class Transaction {

        private $wallet = '';
        private $timeSeed = 0;

        public function __construct() {
            $this->wallet = \Base::instance()->get('wallet');
            $this->timeSeed = \Base::instance()->get('timeSeed');
        }

        public function getTransaction($transaction) {
            $transaction = json_decode(file_get_contents($this->wallet . '/burst?requestType=getTransaction&transaction=' . $transaction), true);
            
            if ($transaction['errorCode'] == null) {
                return $this->formatTransaction($transaction);
            }
            else {
                return null;
            }
        }

        public function getTransactionPage($account, $page) {
            if ($page > 0) $page = $page - 1;
            $transactions = json_decode(file_get_contents($this->wallet . '/burst?requestType=getAccountTransactions&firstIndex=' . ($page * 20) . '&lastIndex=' . (($page * 20) + 19) . '&account=' . $account), true);
            
            if ($transactions['errorCode'] == null) {
                foreach($transactions['transactions'] as $key => $value) {
                    $transactions['transactions'][$key] = $this->formatTransaction($value, $account); 
                }

                return $transactions;
            }
            else {
                return null;
            }
        }

        public function justTransaction($transaction) {
            $transaction = json_decode(file_get_contents($this->wallet . '/burst?requestType=getTransaction&transaction=' . $transaction), true);
            
            if ($transaction['errorCode'] == null) {
                return $transaction;
            }
            else {
                return null;
            }
        }


        // Util Functions

        private function formatTransaction($transaction, $account = null) {
            $transaction['amountNQT'] = number_format($transaction['amountNQT'] / 100000000, 2, '.', "'");
            $transaction['feeNQT'] = $transaction['feeNQT'] / 100000000;
            $transaction['timestamp'] = date('Y-m-d H:i:s', $this->timeSeed + $transaction['timestamp']);
            if ($transaction['attachment']['messageIsText']) $transaction['attachment']['messageIsText'] = 'True';
            else $transaction['attachment']['messageIsText'] = 'False';

            if ($transaction['amountNQT'] <= 0) $transaction['amountNQT'] = 0;
            if ($transaction['feeNQT'] <= 0) $transaction['feeNQT'] = 0;

            if ($transaction['amountNQT'] == 0) {
                $transaction['move'] = '';
            }
            else if ($transaction['sender'] == $account || $transaction['senderRS'] == $account) {
                $transaction['move'] = 'redText';
            }
            else {
                $transaction['move'] = 'greenText';
            }

            if (trim($transaction['attachment']['message']) == '') $transaction['attachment']['message'] = '-';
            if (trim($transaction['attachment']['version.Message']) == '') $transaction['attachment']['version.Message'] = '-';

            switch($transaction['type']) {
                case 0:
                    $transaction['type'] = 'Ordinary payment';
                    break;
                case 1:
                    switch($transaction['subtype']) {
                        case 0:
                            $transaction['type'] = 'Arbitrary message';
                            break;
                        case 1:
                            $transaction['type'] = 'Alias assignment';
                            break;
                        case 2:
                            $transaction['type'] = 'Poll creation';
                            break;
                        case 3:
                            $transaction['type'] = 'Vote casting';
                            break;
                        case 4:
                            $transaction['type'] = 'Hub announcements';
                            break;
                        case 5:
                            $transaction['type'] = 'Acount info';
                            break;
                        case 6:
                            if ($transaction['attachment']['priceNQT'] == '0') {
                                if ($transaction['sender'] == $account && $transaction['recipient'] == $account) {
                                    $transaction['type'] = 'Alias sale cancellation';
                                }
                                else {
                                    $transaction['type'] = 'Alias transfer';
                                }
                            }
                            else {
                                $transaction['type'] = 'Alias sell';
                            }
                            break;
                        case 7:
                            $transaction['type'] = 'Alias buy';
                            break;
                    }
                    break;
                case 2:
                    switch($transaction['subtype']) {
                        case 0:
                            $transaction['type'] = 'Asset issuance';
                            break;
                        case 1:
                            $transaction['type'] = 'Asset transfer';
                            break;
                        case 2:
                            $transaction['type'] = 'Ask order placement';
                            break;
                        case 3:
                            $transaction['type'] = 'Bid order placement';
                            break;
                        case 4:
                            $transaction['type'] = 'Ask order cancellation';
                            break;
                        case 5:
                            $transaction['type'] = 'Bid order cancellation';
                            break;
                    }
                    break;
                case 3:
                    switch($transaction['subtype']) {
                        case 0:
                            $transaction['type'] = 'Marketplace listing';
                            break;
                        case 1:
                            $transaction['type'] = 'Marketplace removal';
                            break;
                        case 2:
                            $transaction['type'] = 'Marketplace price change';
                            break;
                        case 3:
                            $transaction['type'] = 'Marketplace quantity change';
                            break;
                        case 4:
                            $transaction['type'] = 'Marketplace purchase';
                            break;
                        case 5:
                            $transaction['type'] = 'Marketplace delivery';
                            break;
                        case 6:
                            $transaction['type'] = 'Marketplace feedback';
                            break;
                        case 7:
                            $transaction['type'] = 'Marketplace refund';
                            break;
                    }
                    break;
                case 4:
                    $transaction['type'] = 'Balance leasing';
                    break;
                case 20:
                    $transaction['type'] = 'Reward recipient assignment';
                    break;
                case 21:
                    switch($transaction['subtype']) {
                        case 0:
                            $transaction['type'] = 'Escrow creation';
                            break;
                        case 1:
                            $transaction['type'] = 'Escrow signing';
                            break;
                        case 2:
                            $transaction['type'] = 'Escrow result';
                            break;
                        case 3:
                            $transaction['type'] = 'Subscription subscribe';
                            break;
                        case 4:
                            $transaction['type'] = 'Subscription cancel';
                            break;
                        case 5:
                            $transaction['type'] = 'Subscription payment';
                            break;
                    }
                    break;
                case 22:
                    switch($transaction['subtype']) {
                        case 0:
                            $transaction['type'] = 'AT creation';
                            break;
                        case 1:
                            $transaction['type'] = 'AT payment';
                            break;
                    }
                    break;
            }

            return $transaction;
        }

    }
