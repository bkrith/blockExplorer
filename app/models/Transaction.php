<!--
Block Explorer - Burstcoin block explorer 
Copyright (C) 2017 Vassilis 

This program is free software: you can redistribute it and/or modify it under the terms of 
the GNU General Public License as published by the Free Software Foundation, either version 
3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. 
If not, see <http://www.gnu.org/licenses/>.

Make a donation to the author Vassilis ( BURST-YY7Z-K8KK-E2B9-AKQCQ )

-->

<?php

    class Transaction {

        private $wallet = '';

        public function __construct($f3) {
            $this->wallet = $f3->get('wallet');
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

        private function formatTransaction($transaction) {
            $transaction['amountNQT'] = number_format($transaction['amountNQT'] / 100000000, 2, '.', "'");
            $transaction['feeNQT'] = $transaction['feeNQT'] / 100000000;
            $transaction['timestamp'] = date('Y-m-d H:i:s', 1407729600 + $transaction['timestamp']);
            if ($transaction['attachment']['messageIsText']) $transaction['attachment']['messageIsText'] = 'True';
            else $transaction['attachment']['messageIsText'] = 'False';

            if ($transaction['amountNQT'] <= 0) $transaction['amountNQT'] = 0;
            if ($transaction['feeNQT'] <= 0) $transaction['feeNQT'] = 0;

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
