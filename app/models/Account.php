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

    class Account {

        private $wallet = '';

        public function __construct($f3) {
            $this->wallet = $f3->get('wallet');
        }

        public function getAccount($id) {
            $account = json_decode(file_get_contents($this->wallet . '/burst?requestType=getAccount&account=' . $id), true);

            if ($account['errorCode'] == null) {
                $infos = $this->getBalanceInfos($id);
                $account['transactions'] = $infos['transactions'];
                $account['totalReceive'] = $infos['totalReceive'];
                $account['totalSent'] = $infos['totalSent'];
                $account['countTransactions'] = $infos['countTransactions'];
                $account['forgedBlocks'] = $this->formatBlocks($this->getAccountBlocks($id)['blocks']);

                return $this->formatAccount($account);
            }
            else {
                return null;
            }
        }

        public function justAccount($id) {
            $account = json_decode(file_get_contents($this->wallet . '/burst?requestType=getAccount&account=' . $id), true);

            if ($account['errorCode'] == null) {
                return $account;
            }
            else {
                return null;
            }
        }


        // Util Functions

        private function getTransactionsCount($account) {
            $count = count(json_decode(file_get_contents($this->wallet . '/burst?requestType=getAccountTransactionIds&account=' . $account), true)['transactionIds']);

            return $count;
        }

        private function getAccountBlocks($account) {
            $blocks = json_decode(file_get_contents($this->wallet . '/burst?requestType=getAccountBlocks&account=' . $account), true);

            return $blocks;
        }

        private function getBalanceInfos($account) {
            $count = $this->getTransactionsCount($account);
            $transactions = json_decode(file_get_contents($this->wallet . '/burst?requestType=getAccountTransactions&account=' . $account . '&firstIndex=0&lastIndex=' . $count), true);
            
            $totalReceive = 0;
            $totalSent = 0;

            if ($transactions['transactions']) {
                foreach($transactions['transactions'] as $key => $value) {
                    if ($transactions['transactions'][$key]['sender'] == $account) {
                        $totalSent += $value['amountNQT'];
                        $value['move'] = 'red';
                    }
                    else {
                        $totalReceive += $value['amountNQT'];
                        $value['move'] = 'green';
                    }

                    $transactions['transactions'][$key] = $this->formatTransaction($value);
                }
            }

            return array(
                'transactions' => $transactions['transactions'],
                'totalReceive' => $totalReceive,
                'totalSent' => $totalSent,
                'countTransactions' => $count
            );
        }

        private function formatAccount($account) {
            $account['effectiveBalanceNXT'] = number_format($account['effectiveBalanceNXT'] / 100000000, 2, '.', "'");
            $account['totalReceive'] = number_format($account['totalReceive'] / 100000000, 2, '.', "'");
            $account['totalSent'] = number_format($account['totalSent'] / 100000000, 2, '.', "'");
            
            if ($account['effectiveBalanceNXT'] <= 0) $account['effectiveBalanceNXT'] = 0;
            if (trim($account['description']) == '') $account['description'] = '-';

            return $account;
        }

        private function formatTransaction($transaction) {
            $transaction['amountNQT'] = number_format($transaction['amountNQT'] / 100000000, 2, '.', "'");
            $transaction['timestamp'] = date('Y-m-d H:i:s', 1407729600 + $transaction['timestamp']);

            return $transaction;
        }

        private function formatBlocks($blocks) {
            if ($blocks) {
                foreach($blocks as $key => $value) {
                    $blocks[$key] = $this->formatBlock($value);
                }
            }

            return $blocks;
        }

        private function formatBlock($block) {
            $block['blockReward'] = number_format($block['blockReward'], 2, '.', "'");
            $block['totalFeeNQT'] = number_format($block['totalFeeNQT'] / 100000000, 2, '.', "'");
            $block['timestamp'] = date('Y-m-d H:i:s', 1407729600 + $block['timestamp']);

            return $block;
        }

    }
