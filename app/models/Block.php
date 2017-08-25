
<?php

    class Block {

        private $wallet = '';
        private $timeSeed = 0;
        private $blocks = null;
        private $f3 = null;

        public function __construct($f3) {
            $this->wallet = $f3->get('wallet');
            $this->timeSeed = $f3->get('timeSeed');
            $this->f3 = $f3;
        }

        public function all($page) {
            if ($page > 0) $page = $page - 1;
            
            $this->blocks = json_decode(file_get_contents($this->wallet . '/burst?requestType=getBlocks&firstIndex=' . ($page * 100) . '&lastIndex=' . (($page * 100) + 99)), true);

            return $this->formatBlocks();
        }

        public function getLastBlock() {
            $status = json_decode(file_get_contents($this->wallet . '/burst?requestType=getBlockchainStatus'), true);
            $lastBlockHeight = json_decode(file_get_contents($this->wallet . '/burst?requestType=getBlock&block=' . $status['lastBlock']), true)['height'];
            
            return $lastBlockHeight;
        }

        public function getByHeight($height) {
            $block = json_decode(file_get_contents($this->wallet . '/burst?requestType=getBlock&height=' . $height . '&includeTransactions=true'), true);
            
            if ($block['errorCode'] == null) {
                $block = $this->formatBlock(true, $block);
                $block['transactions'] = $this->formatTransactions($block['transactions']);
                
                return $block;
            }
            else {
                return null;
            }
        }

        public function justByHeight($height) {
            $block = json_decode(file_get_contents($this->wallet . '/burst?requestType=getBlock&height=' . $height . '&includeTransactions=true'), true);
            
            if ($block['errorCode'] == null) {
                return $block;
            }
            else {
                return null;
            }
        }

        public function getById($id) {
            $block = json_decode(file_get_contents($this->wallet . '/burst?requestType=getBlock&block=' . $id . '&includeTransactions=true'), true);
            
            if ($block['errorCode'] == null) {
                $block = $this->formatBlock(true, $block);
                $block['transactions'] = $this->formatTransactions($block['transactions']);
                
                return $block;
            }
            else {
                return null;
            }
        }

        public function justById($id) {
            $block = json_decode(file_get_contents($this->wallet . '/burst?requestType=getBlock&block=' . $id . '&includeTransactions=true'), true);
            
            if ($block['errorCode'] == null) {                
                return $block;
            }
            else {
                return null;
            }
        }

        public function getBlocksForPool() {
            $this->blocks = json_decode(file_get_contents($this->wallet . '/burst?requestType=getBlocks&firstIndex=0&lastIndex=50'), true);

            return $this->formatBlocks(true);
        }


        // Util Functions

        private function formatBlocks($forPools = false) {
            foreach($this->blocks['blocks'] as $key => $value) {
                $this->blocks['blocks'][$key] = $this->formatBlock(false, $this->blocks['blocks'][$key], $forPools);
            }

            return $this->blocks;
        }

        private function formatBlock($single, $block, $forPools = false) {
            $block['totalAmountNQT'] = number_format($block['totalAmountNQT'] / 100000000, 2, '.', "'");
            $block['totalFeeNQT'] = $block['totalFeeNQT'] / 100000000;
            if ($single || $forPools) {
                $block['generationTime'] = $this->findBlockTimestamp($block['height'] - 1);
                $block['generationTime'] = date('i:s', $block['timestamp'] - $block['generationTime']);

                $account = new Account($this->f3);
                $block['generatorName'] = $account->justAccount($block['generator'])['name'];
                $poolId = json_decode(file_get_contents($this->wallet . '/burst?requestType=getAccountTransactions&account=' . $block['generator'] . '&type=20&firstIndex=0&lastIndex=0'), true)['transactions'][0]['recipient'];
                if ($block['generator'] == $poolId) {
                    $block['poolName'] = 'Solo Miners';
                }
                else {
                    $block['poolName'] = $account->justAccount($poolId)['name'];
                }
            }
            $block['timestamp'] = date('Y-m-d H:i:s', $this->timeSeed + $block['timestamp']);
            $block['blockReward'] = number_format($block['blockReward'], 0, '.', "'");
            if ($block['payloadLength'] > 1024) $block['payloadLength'] = round($block['payloadLength'] / 1024, 2) . 'K';

            if ($block['totalAmountNQT'] > 0) $block['bold'] = 'bold';

            if ($block['totalAmountNQT'] <= 0) $block['totalAmountNQT'] = 0;
            if ($block['totalFeeNQT'] <= 0) $block['totalFeeNQT'] = 0;

            if ($forPools) {
                $block['netDiff'] = intval(18325193796 / intval($block['baseTarget']));
            }

            return $block;
        }

        private function findBlockTimestamp($height) {
            foreach($this->blocks['blocks'] as $block) {
                if ($block['height'] == $height) return $block['timestamp'];
            }

            return 0;
        }

        private function formatTransactions($transactions) {
            foreach($transactions as $key => $value) {
                $transactions[$key]['amountNQT'] = number_format($value['amountNQT'] / 100000000, 2, '.', "'");
                $transactions[$key]['feeNQT'] = $value['feeNQT'] / 100000000;
                $transactions[$key]['timestamp'] = date('Y-m-d H:i:s', $this->timeSeed + $value['timestamp']);
                if ($transactions[$key]['amountNQT'] <= 0) $transactions[$key]['amountNQT'] = 0;
                if ($transactions[$key]['feeNQT'] <= 0) $transactions[$key]['feeNQT'] = 0;
            }

            return $transactions;
        }

    }
