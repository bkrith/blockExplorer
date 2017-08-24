
<?php

    class Account {

        private $wallet = '';
        private $timeSeed = 0;

        public function __construct($f3) {
            $this->wallet = $f3->get('wallet');
            $this->timeSeed = $f3->get('timeSeed');
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
            $count = count(json_decode(file_get_contents($this->wallet . '/burst?requestType=getAccountTransactionIds&firstIndex=0&lastIndex=99&account=' . $account), true)['transactionIds']);

            return $count;
        }

        private function getAccountBlocks($account) {
            $blocks = json_decode(file_get_contents($this->wallet . '/burst?requestType=getAccountBlocks&account=' . $account), true);

            return $blocks;
        }

        private function getBalanceInfos($account) {
            $transactions = json_decode(file_get_contents($this->wallet . '/burst?requestType=getAccountTransactions&firstIndex=0&lastIndex=99&account=' . $account . '&firstIndex=0&lastIndex=' . $count), true);
            $count = count($transactions['transactions']);
            $totalReceive = 0;
            $totalSent = 0;

            if ($transactions['transactions']) {
                foreach($transactions['transactions'] as $key => $value) {
                    if ($transactions['transactions'][$key]['sender'] == $account || $transactions['transactions'][$key]['senderRS'] == $account) {
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
            $transaction['timestamp'] = date('Y-m-d H:i:s', $this->timeSeed + $transaction['timestamp']);

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
            $block['timestamp'] = date('Y-m-d H:i:s', $this->timeSeed + $block['timestamp']);

            return $block;
        }

    }
