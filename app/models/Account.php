
<?php

    class Account {

        private $wallet = '';
        private $timeSeed = 0;

        public function __construct() {
            $this->wallet = \Base::instance()->get('wallet');
            $this->timeSeed = \Base::instance()->get('timeSeed');
        }

        public function getAccount($id) {
            $account = json_decode(file_get_contents($this->wallet . '/burst?requestType=getAccount&account=' . strtoupper($id)), true);

            if ($account['errorCode'] == null) {
                $infos = $this->getBalanceInfos($id);
                $account['transactions'] = $infos['transactions'];
                $account['totalReceive'] = $infos['totalReceive'];
                $account['totalSent'] = $infos['totalSent'];
                $account['countTransactions'] = $infos['countTransactions'];
                $account['forgedBlocks'] = $this->formatForgedBlocks($this->getAccountBlocks($id)['blocks']);

                return $this->formatAccount($account);
            }
            else {
                return null;
            }
        }

        public function justAccount($id) {
            $account = json_decode(file_get_contents($this->wallet . '/burst?requestType=getAccount&account=' . strtoupper($id)), true);

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
            $blocks = json_decode(file_get_contents($this->wallet . '/burst?requestType=getAccountBlocks&firstIndex=0&lastIndex=9&account=' . $account), true);

            return $blocks;
        }

        private function getBalanceInfos($account) {
            $transactions = new Transaction();
            $totalReceive = 0;
            $totalSent = 0;

            /*
            if ($transactions['transactions']) {
                foreach($transactions['transactions'] as $key => $value) {
                    if ($value['amountNQT'] == 0) {
                        $value['move'] = '';
                    }
                    else if ($transactions['transactions'][$key]['sender'] == $account || $transactions['transactions'][$key]['senderRS'] == $account) {
                        $totalSent += $value['amountNQT'];
                    }
                    else {
                        $totalReceive += $value['amountNQT'];
                    }
                }
            }
            */

            return array(
                'transactions' => $transactions->getTransactionPage($account, 1)['transactions'],
                'totalReceive' => $totalReceive,
                'totalSent' => $totalSent,
                'countTransactions' => $this->getTransactionsCount($account)
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

        private function formatForgedBlocks($blocks) {
            if ($blocks) {
                foreach($blocks as $key => $value) {
                    $blocks[$key] = $this->formatForgedBlock($value);
                }
            }

            return $blocks;
        }

        private function formatForgedBlock($block) {
            $block['blockReward'] = number_format($block['blockReward'], 2, '.', "'");
            $block['totalFeeNQT'] = number_format($block['totalFeeNQT'] / 100000000, 2, '.', "'");
            $block['timestamp'] = date('Y-m-d H:i:s', $this->timeSeed + $block['timestamp']);

            return $block;
        }

    }
